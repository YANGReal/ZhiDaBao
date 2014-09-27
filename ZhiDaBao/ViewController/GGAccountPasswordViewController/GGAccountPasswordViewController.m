//
//  GGAccountPasswordViewController.m
//  GG
//
//  Created by YANGReal on 14-9-23.
//  Copyright (c) 2014年 GG. All rights reserved.
//

#import "GGAccountPasswordViewController.h"
#import "GGUpdatePasswordViewController.h"
@interface GGAccountPasswordViewController ()

- (IBAction)goNext:(id)sender;
- (IBAction)loginOut:(id)sender;
@end

@implementation GGAccountPasswordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"账户设置";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


- (IBAction)goNext:(id)sender
{
    GGUpdatePasswordViewController *vc = [[GGUpdatePasswordViewController alloc] initWithNibName:@"GGUpdatePasswordViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)back
{
    [(GGMainViewController *)self.tabBarController showTabBar:YES];
    [super back];
}


- (IBAction)loginOut:(id)sender
{
    [AppUtility removeObjectForkey:UID];
    ZDBAppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app goLogin];;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
