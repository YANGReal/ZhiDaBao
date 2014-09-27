//
//  GGFansDetailViewController.m
//  GG
//
//  Created by YANGReal on 14-9-23.
//  Copyright (c) 2014年 GG. All rights reserved.
//

#import "GGFansDetailViewController.h"
#import "GGPrivateMessageViewController.h"

@interface GGFansDetailViewController ()

- (IBAction)privateMessageButtonClicked:(id)sender;

@end

@implementation GGFansDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"用户详情";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)privateMessageButtonClicked:(id)sender
{
    GGPrivateMessageViewController *vc = [[GGPrivateMessageViewController alloc] initWithNibName:@"GGPrivateMessageViewController" bundle:nil];
    vc.messageType = kToSingle;
    [self.navigationController pushViewController:vc animated:YES];
   
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
