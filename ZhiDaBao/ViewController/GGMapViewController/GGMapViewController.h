//
//  GGMapViewController.h
//  GG
//
//  Created by YANGReal on 14-9-22.
//  Copyright (c) 2014年 GG. All rights reserved.
//

#import "GGBaseViewController.h"

@class GGMapViewController;
@protocol GGMapViewControllerDelegate <NSObject>

@optional
- (void)mapViewController:(GGMapViewController *)mapViewController didChooseCoor:(CLLocationCoordinate2D)coordinate WithPlace:(NSString *)place;

@end

@interface GGMapViewController : GGBaseViewController
@property (assign , nonatomic) id<GGMapViewControllerDelegate>delegate;
@end
