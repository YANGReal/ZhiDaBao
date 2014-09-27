//
//  GGHomePageCell.h
//  GG
//
//  Created by YANGReal on 14-7-19.
//  Copyright (c) 2014年 GG. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GGHomePageCell;

@protocol GGHomePageCellDelegate <NSObject>

@optional

- (void)homeCell:(GGHomePageCell *)cell didClickLikeButtonWithData:(NSDictionary *)data;
- (void)homeCell:(GGHomePageCell *)cell didClickCommentButtonWithData:(NSDictionary *)data;
- (void)homeCell:(GGHomePageCell *)cell didClickShareButtonWithData:(NSDictionary *)data;

@end

@interface GGHomePageCell : UITableViewCell
@property (strong , nonatomic)  NSDictionary *data;

@property (assign , nonatomic) id<GGHomePageCellDelegate>delegate;
@end
