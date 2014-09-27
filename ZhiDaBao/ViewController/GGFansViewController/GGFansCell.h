//
//  GGFansCell.h
//  GG
//
//  Created by YANGReal on 14-9-23.
//  Copyright (c) 2014年 GG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GGFansCell;
@protocol GGFansCellDelegate <NSObject>

@optional

- (void)fansCell:(GGFansCell *)cell
didClickPrivateMessageWithIndex:(NSInteger)index;

@end

@interface GGFansCell : UITableViewCell
@property (assign , nonatomic) id<GGFansCellDelegate>delegate;
@property (assign , nonatomic) NSInteger index;
@end
