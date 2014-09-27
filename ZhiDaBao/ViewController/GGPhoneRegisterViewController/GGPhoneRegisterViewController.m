//
//  GGPhoneRegisterViewController.m
//  GG
//
//  Created by YANGReal on 14-9-22.
//  Copyright (c) 2014年 GG. All rights reserved.
//

#import "GGPhoneRegisterViewController.h"
#import "GGVerifyCodeViewController.h"
@interface GGPhoneRegisterViewController ()<UITextFieldDelegate>
@property (weak , nonatomic) IBOutlet UITextField *textField;
@property (weak , nonatomic) IBOutlet UIView *view1,*view2,*view3;
@end

@implementation GGPhoneRegisterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"请输入手机号码";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#e9e9e9"];
    [self.textField becomeFirstResponder];
    self.view1.height = 0.5;
    self.view2.height = 0.5;
    self.view3.height = 0.5;
    [self setupRightBarButtonItem];
}

- (void)setupRightBarButtonItem
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = RECT(0, 0, 23, 23);
    [btn setBackgroundImage:[UIImage imageFromMainBundleFile:@"goNext.png"] forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(goNext) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (void)goNext
{
    if ([AppUtility isValidateMobile:_textField.text])
    {
        [NBNetworkEngine loadDataWithURL:kSendVerifyCode_URL(_textField.text) completeHander:^(id jsonObject, BOOL success) {
            NSDictionary *dict = (NSDictionary *)jsonObject;
            DLog(@"dict = %@",dict);
            if ([[dict stringAttribute:@"resultCode"] isEqualToString:@"200"])
            {
                
                GGVerifyCodeViewController *vc = [[GGVerifyCodeViewController alloc] initWithNibName:@"GGVerifyCodeViewController" bundle:nil];
                vc.phoneNumber = _textField.text;
                [self.navigationController pushViewController:vc animated:YES];
            }
            else
            {
                NSString *msg = [dict stringAttribute:@"resultMessage"];
                [self showMBWithMessage:msg];
            }
            
        }];
        
    }
    else
    {
        [self showMBWithMessage:@"请输入正确的手机号码"];
    }
}


#pragma mark - 

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self goNext];
    return YES;
}
#pragma mark  -

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_textField resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
