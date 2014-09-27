//
//  NBBaseViewController.h
//  iCareer
//
//  Created by YANGRui on 14-2-27.
//  Copyright (c) 2014年 andy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GGBaseViewController : UIViewController

- (void)setupLeftBarButtonItem;
- (void)back;

- (void)showMBCompleteWithText:(NSString *)text;
- (void)showMBFailedWithText:(NSString *)text;
- (void)showMBLodingWithMessage:(NSString *)message;
- (void)hideMBLoding;
- (void)showMBWithMessage:(NSString *)message;

- (void)showMessageWithStatusCode:(NSString *)code;


@end
