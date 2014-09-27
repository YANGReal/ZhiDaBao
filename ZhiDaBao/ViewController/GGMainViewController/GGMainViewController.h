//
//  GBMainViewController.h
//  GroupBuy
//
//  Created by YANGReal on 14-3-20.
//  Copyright (c) 2014年 YANGReal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GGMainViewController : UITabBarController


/*选中TabBar*/

- (void)selectedTabBarAtIndex:(int)index;

/* 隐藏TabBar*/
- (void)hideTabBar:(BOOL)animated;


/*显示TabBar*/
- (void)showTabBar:(BOOL)animated;

@end
