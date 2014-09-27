//
//  ZDBAppDelegate.h
//  ZhiDaBao
//
//  Created by YANGReal on 14-9-27.
//  Copyright (c) 2014年 YANGReal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GGMainViewController.h"
@interface ZDBAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong , nonatomic) GGMainViewController *mainVC;

- (void)switchRootViewController;
- (void)goLogin;
@end
