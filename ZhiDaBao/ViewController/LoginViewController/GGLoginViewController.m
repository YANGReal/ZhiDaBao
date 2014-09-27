//
//  GGLoginViewController.m
//  GG
//
//  Created by foj on 14-7-27.
//  Copyright (c) 2014年 GG. All rights reserved.
//

#import "GGLoginViewController.h"
#import "GGPhoneRegisterViewController.h"
#import "GGForgetPasswordViewController.h"
#import "GGCreateShopViewController.h"
#define user @"13813458759"
#define pass @"123456"
#import "GGMapViewController.h"
@interface GGLoginViewController ()<UITextFieldDelegate>
@property (weak , nonatomic) IBOutlet UITextField *accountField;
@property (weak , nonatomic) IBOutlet UITextField *passwordField;
@property (weak , nonatomic) IBOutlet UIButton *loginBtn;

- (IBAction)loginBtn:(id)sender;
- (IBAction)doRegister:(id)sender;
- (IBAction)forgetPassword:(id)sender;
@end

@implementation GGLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //self.title = @"登录";
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupViews];
    // Do any additional setup after loading the view from its nib.
}

- (void)setupViews
{
    self.accountField.backgroundColor = WHITE_COLOR;
    self.passwordField.backgroundColor = WHITE_COLOR;
    self.accountField.text = user;
    self.passwordField.text = pass;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}

- (IBAction)doRegister:(id)sender
{
    GGPhoneRegisterViewController *vc = [[GGPhoneRegisterViewController alloc] initWithNibName:@"GGPhoneRegisterViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)forgetPassword:(id)sender
{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"pizza" ofType:@"png"];
    NSString *uid = [AppUtility getObjectForKey:UID];
    [NBNetworkEngine uploadImageWithURL:kUploadImage(uid) params:nil filePath:path completeHander:^(id jsonObject, BOOL success) {
        
        DLog(@"obj = %@",jsonObject);
    }];
    return;
    
    GGForgetPasswordViewController *vc = [[GGForgetPasswordViewController alloc] initWithNibName:@"GGForgetPasswordViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (void)login
{
    if ([self checkInput])
    {
        [self showMBLodingWithMessage:@"登录中"];
        NSString *accout =_accountField.text;;
        NSString *password = _passwordField.text;
        //DLog(@"url = %@",kLogin_URL);
        [NBNetworkEngine loadDataWithURL:kLogin_URL(accout,password) params:nil completeHander:^(id jsonObject, BOOL success) {
            
            DLog(@"json = %@",jsonObject);
            NSDictionary *dict = (NSDictionary *)jsonObject;
            NSString *ret = [dict stringAttribute:@"resultCode"];
            if ([ret isEqualToString:@"200"])
            {
                [self showMBWithMessage:@"登录成功"];
                NSString *uid = [dict stringAttribute:@"token"];
                [AppUtility storeObject:password forKey:PASS_WORD_KEY];
                [AppUtility storeObject:accout forKey:USER_NAME_KEY];
                [AppUtility storeObject:uid forKey:UID];
                NSString *shopCreated = [dict stringAttribute:@"shopCreated"];
                if ([shopCreated isEqualToString:@"1"])
                {
                    NSDictionary *detail = dict[@"detail"];
                    
                    NSString *shopId = [detail stringAttribute:@"id"];
                    [AppUtility storeObject:shopId forKey:@"shopId"];
                    ZDBAppDelegate *app = [[UIApplication sharedApplication] delegate];
                    [app performSelector:@selector(switchRootViewController) withObject:nil afterDelay:2];
                }
                else
                {
                    GGCreateShopViewController *vc = [[GGCreateShopViewController alloc] initWithNibName:@"GGCreateShopViewController" bundle:nil];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                
                
            }
            else
            {
                NSString *msg = [dict stringAttribute:@"resultMessage"];
                [self showMBWithMessage:msg];
            }
            [self hideMBLoding];
        }];
    }
}


- (IBAction)loginBtn:(id)sender
{
    [self login];
}

- (BOOL)checkInput
{
    if (_accountField.text.length == 0)
    {
        [self showMBWithMessage:@"请输入账户名"];
        [_accountField becomeFirstResponder];
        return NO;
    }
    if (_passwordField.text.length < 6)
    {
        [self showMBWithMessage:@"请输入至少六位数密码"];
        [_passwordField becomeFirstResponder];
        return NO;
    }
    [_accountField resignFirstResponder];
    [_passwordField resignFirstResponder];
    return YES;
}


- (void)back
{
    self.navigationController.navigationBarHidden = YES;
    [super back];
}

- (void)touchesBegan:(NSSet *)touches
           withEvent:(UIEvent *)event
{
    [self.accountField resignFirstResponder];
    [self.passwordField resignFirstResponder];
   
}


#pragma mark - UITextFieldDelegate


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (!ISIP5)
    {
        if (textField == _passwordField)
        {
            [UIView animateWithDuration:ANIMATION_DURATION animations:^{
                
                self.view.y = -30;
            }];
            return;
        }
    }
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:ANIMATION_DURATION animations:^{
        
        self.view.y = 0;
    }];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _accountField)
    {
        [_passwordField becomeFirstResponder];
    }
    else
    {
        [self login];
    }
    return YES;
}

#pragma mark - 内存管理

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
