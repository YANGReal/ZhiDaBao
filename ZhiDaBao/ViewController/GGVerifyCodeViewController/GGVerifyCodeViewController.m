//
//  GGVerifyCodeViewController.m
//  GG
//
//  Created by YANGReal on 14-9-22.
//  Copyright (c) 2014年 GG. All rights reserved.
//

#import "GGVerifyCodeViewController.h"
#import "GGSetPasswordViewController.h"
@interface GGVerifyCodeViewController ()
{
    NSTimer *timer;
    int count;
}
@property (weak , nonatomic) IBOutlet UITextField *textField;
@property (weak , nonatomic) IBOutlet UIView *view1,*view2,*view3;
@property (weak , nonatomic) IBOutlet UILabel *label;
@property (weak , nonatomic) IBOutlet UILabel *countLabel;
@property (weak , nonatomic) IBOutlet UIButton *button;

- (IBAction)reSendCode:(id)sender;

@end

@implementation GGVerifyCodeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
         self.title = @"填写验证码";
        count =61;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#e9e9e9"];
    [self.textField becomeFirstResponder];
    self.view1.height = 0.5;
    self.view2.height = 0.5;
    self.view3.height = 0.5;
    [self setupRightBarButtonItem];
    NSString *someNumber = [_phoneNumber substringWithRange:NSMakeRange(4, 4)];
    NSString *phone = [_phoneNumber stringByReplacingOccurrencesOfString:someNumber withString:@"****"];
    self.label.text = [NSString stringWithFormat:@"我们已发送验证码短信至%@",phone];
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countTime:) userInfo:nil repeats:YES];
    [timer fire];
    self.button.enabled = NO;
}


- (void)countTime:(NSTimer *)time
{
    count --;
    self.countLabel.text = [NSString stringWithFormat:@"重新发送验证码(%d)",count];
    if (count == 0)
    {
        [timer invalidate];
        timer = nil;
        self.button.enabled = YES;
        self.countLabel.textColor = BLUE_COLOR;
        count = 61;
    }
}

- (void)setupRightBarButtonItem
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = RECT(0, 0, 23, 23);
    [btn setBackgroundImage:[UIImage imageFromMainBundleFile:@"goNext.png"] forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(goNext) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (IBAction)reSendCode:(id)sender
{
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countTime:) userInfo:nil repeats:YES];
    [timer fire];
    self.button.enabled = NO;
    self.countLabel.textColor = [UIColor lightGrayColor];
    [NBNetworkEngine loadDataWithURL:kSendVerifyCode_URL(_phoneNumber) completeHander:^(id jsonObject, BOOL success) {
        NSDictionary *dict = (NSDictionary *)jsonObject;
        DLog(@"dict = %@",dict);
        if ([[dict stringAttribute:@"resultCode"] isEqualToString:@"200"])
        {
            
            [self showMBWithMessage:@"验证码发送成功"];
        }
        else
        {
            NSString *msg = [dict stringAttribute:@"resultMessage"];
            [self showMBWithMessage:msg];
        }
        
    }];

}


- (void)goNext
{
    if (_textField.text.length!=0)
    {
        [self showMBLodingWithMessage:@"验证中"];
        
        NSString *url = kCheckCode(_phoneNumber, _textField.text);
        if (_forget)
        {
            url = KRecheckCode(_phoneNumber, _textField.text);
        }
        [NBNetworkEngine loadDataWithURL:url completeHander:^(id jsonObject, BOOL success) {
            DLog(@"jsonObject = %@",jsonObject);
            NSDictionary *dict = (NSDictionary *)jsonObject;
             [self hideMBLoding];
            if ([[dict stringAttribute:@"resultCode"] isEqualToString:@"200"])
            {
                GGSetPasswordViewController *vc = [[GGSetPasswordViewController alloc] initWithNibName:@"GGSetPasswordViewController" bundle:nil];
                vc.forget = _forget;
                vc.phoneNumber = _phoneNumber;
                vc.verifyCode = _textField.text;
                [self.navigationController pushViewController:vc animated:YES];
            }
            else
            {
                NSString *msg = [dict stringAttribute:@"验证码错误"];
                DLog(@"msg = %@",[dict stringAttribute:@"resultMessage"]);
                [self showMBWithMessage:msg];
            }
        }];
    }
    else
    {
        [self showMBWithMessage:@"请输入验证码"];
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
