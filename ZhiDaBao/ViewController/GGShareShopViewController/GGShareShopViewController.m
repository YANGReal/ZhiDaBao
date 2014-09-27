//
//  GGShareShopViewController.m
//  GG
//
//  Created by YANGReal on 14-9-23.
//  Copyright (c) 2014年 GG. All rights reserved.
//

#import "GGShareShopViewController.h"

@interface GGShareShopViewController ()
@property (weak , nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation GGShareShopViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"编辑截屏";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupRightBarButtonItem];
    self.imageView.image = _shopImage;
    // Do any additional setup after loading the view from its nib.
}

- (void)setupRightBarButtonItem
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = RECT(0, 0, 40, 23);
    [btn setTitle:@"分享" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(shareButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (void)back
{
     [(GGMainViewController *)self.tabBarController showTabBar:YES];
    [super back];
}

- (void)shareButtonClicked
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
