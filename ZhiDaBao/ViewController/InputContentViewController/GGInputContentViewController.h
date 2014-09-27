//
//  GGInputContentViewController.h
//  GG
//
//  Created by YANGReal on 14-7-20.
//  Copyright (c) 2014年 GG. All rights reserved.
//

#import "GGBaseViewController.h"

@class GGInputContentViewController;

@protocol GGInputContentViewControllerDelegate <NSObject>

@optional
- (void)backFromGGInputContentViewController:(GGInputContentViewController *)vc withContent:(NSString *)content;

@end


@interface GGInputContentViewController : GGBaseViewController
@property (assign , nonatomic) NSInteger textLength;
@property (strong , nonatomic) NSIndexPath *indexPath;
@property (assign , nonatomic) id<GGInputContentViewControllerDelegate>delegate;
@end
