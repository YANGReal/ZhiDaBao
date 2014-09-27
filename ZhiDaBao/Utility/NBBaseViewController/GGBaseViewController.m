//
//  NBBaseViewController.m
//  iCareer
//
//  Created by YANGRui on 14-2-27.
//  Copyright (c) 2014年 andy. All rights reserved.
//

#import "GGBaseViewController.h"
#import "MBProgressHUD.h"
@interface GGBaseViewController ()<MBProgressHUDDelegate>
@property (strong , nonatomic) UIImageView *navBanner;
@end

@implementation GGBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.frame = IP5ORIP4FRAME;
    self.view.backgroundColor = WHITE_COLOR;
    self.view.backgroundColor = BG_COLOR;
    [self setupLeftBarButtonItem];
   
   
	// Do any additional setup after loading the view.
}



- (void)setupLeftBarButtonItem
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];

    btn.frame = RECT(0, 0, 23, 23);
    [btn setBackgroundImage:[UIImage imageFromMainBundleFile:@"back.png"] forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (void)hideBanner
{
    self.navBanner.hidden = YES;
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)showMBCompleteWithText:(NSString *)text
{
   MBProgressHUD  *HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	[self.view.window addSubview:HUD];
	HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark.png"]];
	// Set custom view mode
	HUD.mode = MBProgressHUDModeCustomView;
	HUD.delegate = self;
	HUD.labelText = text;
	[HUD show:YES];
	[HUD hide:YES afterDelay:2];

}

- (void)showMBFailedWithText:(NSString *)text
{
    MBProgressHUD  *HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	[self.view.window addSubview:HUD];
	HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark.png"]];
	// Set custom view mode
	HUD.mode = MBProgressHUDModeCustomView;
	HUD.delegate = self;
	HUD.labelText = text;
	[HUD show:YES];
	[HUD hide:YES afterDelay:2];

}
- (void)showMBLodingWithMessage:(NSString *)message
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:window];
    HUD.tag = 1234;
	[window addSubview:HUD];
    HUD.delegate = self;
    
    HUD.labelText = message;
	[HUD show:YES];

}
- (void)hideMBLoding
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    MBProgressHUD *HUD = (MBProgressHUD *)[window viewWithTag:1234];
    [HUD hide:YES];
}
- (void)showMBWithMessage:(NSString *)message
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
	
	// Configure for text only and offset down
	hud.mode = MBProgressHUDModeText;
	hud.labelText = message;
	hud.margin = 20.f;
	hud.yOffset = 10.f;
	hud.removeFromSuperViewOnHide = YES;
	[hud hide:YES afterDelay:2];
}


#pragma mark - MBProgressHUDDelegate method

- (void)hudWasHidden:(MBProgressHUD *)hud
{
    [hud removeFromSuperview];
    hud = nil;
}


- (void)showMessageWithStatusCode:(NSString *)code
{
    if ([code isEqualToString:@"0"])
    {
        [self showMBWithMessage:@"用户名或密码错误"];
    }
    else if ([code isEqualToString:@"1"])
    {
        [self showMBWithMessage:@"非法字符"];
    }
    else if ([code isEqualToString:@"2"])
    {
        [self showMBWithMessage:@"账号已被注册"];
    }
    else if ([code isEqualToString:@"3"])
    {
        [self showMBWithMessage:@"请输入六位数以上密码"];
    }
    else
    {
        [self showMBWithMessage:@"用户名过短,请输入三个字符以上用户名"];
    }
    
}

#pragma mark - 内存管理

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
