//
//  GGSetPasswordViewController.m
//  GG
//
//  Created by YANGReal on 14-9-22.
//  Copyright (c) 2014年 GG. All rights reserved.
//

#import "GGSetPasswordViewController.h"
#import "GGCreateShopViewController.h"
@interface GGSetPasswordViewController ()
@property (weak , nonatomic) IBOutlet UITextField *oldPasswordField;
@property (weak , nonatomic) IBOutlet UITextField *PasswordField;
@property (weak , nonatomic) IBOutlet UIView *view1,*view2,*view3;
@end

@implementation GGSetPasswordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"设置密码";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#e9e9e9"];
    [self.oldPasswordField becomeFirstResponder];
    self.view1.height = 0.5;
    self.view2.height = 0.5;
    self.view3.height = 0.5;
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
//    GGCreateShopViewController *vc = [[GGCreateShopViewController alloc] initWithNibName:@"GGCreateShopViewController" bundle:nil];
//    [self.navigationController pushViewController:vc animated:YES];
//    return;
    if (_oldPasswordField.text.length<6)
    {
        [self showMBWithMessage:@"请输入至少六位数密码"];
        return;
    }
     if (![_PasswordField.text isEqualToString:_oldPasswordField.text])
    {
        [self showMBWithMessage:@"两次输入的密码不一致"];
        return;
    }
    
    NSString *url = kSetPassword(_phoneNumber, _verifyCode, _PasswordField.text);
    if(_forget)
    {
        url = kResetPassword(_phoneNumber, _verifyCode, _PasswordField.text);
    }
    [NBNetworkEngine loadDataWithURL:url completeHander:^(id jsonObject, BOOL success) {
        DLog(@"dict = %@",jsonObject);
        NSDictionary *dict = (NSDictionary *)jsonObject;
        if ([[dict stringAttribute:RESULT_CODE] isEqualToString:@"200"])
        {
            if (_forget)
            {
                [self showMBWithMessage:@"设置密码成功"];
                return ;
            }
            GGCreateShopViewController *vc = [[GGCreateShopViewController alloc] initWithNibName:@"GGCreateShopViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
            [AppUtility storeObject:_PasswordField.text forKey:PASS_WORD_KEY];
            [AppUtility storeObject:_phoneNumber forKey:USER_NAME_KEY];
        }
        else
        {
            NSString *msg = [dict stringAttribute:@"resultMessage"];
            [self showMBWithMessage:msg];
        }
        
        
    }];
}


#pragma mark -

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _oldPasswordField)
    {
        [_PasswordField becomeFirstResponder];
    }
    else
    {
        [self goNext];
    }
   
    return YES;
}
#pragma mark  -

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_PasswordField resignFirstResponder];
    [_oldPasswordField resignFirstResponder];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
