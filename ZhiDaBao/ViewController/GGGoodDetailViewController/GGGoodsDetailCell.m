//
//  GGGoodsDetailCell.m
//  GG
//
//  Created by YANGReal on 14-9-24.
//  Copyright (c) 2014年 GG. All rights reserved.
//

#import "GGGoodsDetailCell.h"

@interface GGGoodsDetailCell ()
@property (weak , nonatomic) IBOutlet UIImageView *avatarView;
@end

@implementation GGGoodsDetailCell

- (void)awakeFromNib
{
    // Initialization code
    [self.avatarView setupBorder:CLEAR_COLOR cornerRadius:25];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    //
}

+(CGFloat)cellHeightWithData:(NSDictionary *)data
{
    return 68;
}

@end
