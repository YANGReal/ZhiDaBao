//
//  GGUpdatePasswordViewController.m
//  GG
//
//  Created by YANGReal on 14-9-23.
//  Copyright (c) 2014年 GG. All rights reserved.
//

#import "GGUpdatePasswordViewController.h"

@interface GGUpdatePasswordViewController ()<UITextFieldDelegate>
@property (weak , nonatomic) IBOutlet UITextField *oldField;
@property (weak , nonatomic) IBOutlet UITextField *pwField;
@property (weak , nonatomic) IBOutlet UITextField *repeatField;

- (IBAction)submitButtonClicked:(id)sender;

@end

@implementation GGUpdatePasswordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"密码设置";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupRightBarButtonItem];
    _oldField.backgroundColor = CLEAR_COLOR;
    _pwField.backgroundColor = CLEAR_COLOR;
    _repeatField.backgroundColor = CLEAR_COLOR;
    // Do any additional setup after loading the view from its nib.
}

- (void)setupRightBarButtonItem
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = RECT(0, 0, 23, 23);
    [btn setBackgroundImage:[UIImage imageFromMainBundleFile:@"ok_icon.png"] forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(okButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (void)okButtonClicked
{
    [self submit];
}

- (BOOL)check
{
    if (_oldField.text.length == 0)
    {
        [self showMBWithMessage:@"请输入原密码"];
        [_oldField becomeFirstResponder];
        return NO;
    }
    if(_pwField.text.length<6)
    {
        [self showMBWithMessage:@"请输入至少6位数新密码"];
        [_pwField becomeFirstResponder];
        return NO;
    }
    if (![_pwField.text isEqualToString:_repeatField.text])
    {
        [self showMBWithMessage:@"两次输入的新密码不一致"];
        [_repeatField becomeFirstResponder];
        return NO;

    }
    return YES;
}

- (IBAction)submitButtonClicked:(id)sender
{
    [self submit];
}


- (void)submit
{
    if ([self check])
    {
        [_oldField resignFirstResponder];
        [_pwField resignFirstResponder];
        [_repeatField resignFirstResponder];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_oldField resignFirstResponder];
    [_pwField resignFirstResponder];
    [_repeatField resignFirstResponder];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _oldField)
    {
        [_pwField becomeFirstResponder];
    }
    else if (textField == _pwField)
    {
        [_repeatField becomeFirstResponder];
    }
    else
    {
        [self submit];
    }
    
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
