//
//  GGShopCompleteViewController.m
//  GG
//
//  Created by YANGReal on 14-9-22.
//  Copyright (c) 2014年 GG. All rights reserved.
//

#import "GGShopCompleteViewController.h"

@interface GGShopCompleteViewController ()

@end

@implementation GGShopCompleteViewController

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
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithHexString:@"#e9e9e9"];
   
    [self setupRightBarButtonItem];

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
    ZDBAppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app switchRootViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
