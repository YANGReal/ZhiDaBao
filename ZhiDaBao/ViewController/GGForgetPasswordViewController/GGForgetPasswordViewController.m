//
//  GGForgetPasswordViewController.m
//  GG
//
//  Created by YANGReal on 14-9-24.
//  Copyright (c) 2014年 GG. All rights reserved.
//

#import "GGForgetPasswordViewController.h"
#import "GGVerifyCodeViewController.h"
@interface GGForgetPasswordViewController ()
@property (weak , nonatomic) IBOutlet UITextField *textField;
@end

@implementation GGForgetPasswordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title  = @"忘记密码";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    [self setupRightBarButtonItem];
    // Do any additional setup after loading the view from its nib.
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
        [NBNetworkEngine loadDataWithURL:KResendCode(_textField.text) completeHander:^(id jsonObject, BOOL success) {
            NSDictionary *dict = (NSDictionary *)jsonObject;
            DLog(@"dict = %@",dict);
            if ([[dict stringAttribute:@"resultCode"] isEqualToString:@"200"])
            {
                
                GGVerifyCodeViewController *vc = [[GGVerifyCodeViewController alloc] initWithNibName:@"GGVerifyCodeViewController" bundle:nil];
                vc.forget = YES;
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
