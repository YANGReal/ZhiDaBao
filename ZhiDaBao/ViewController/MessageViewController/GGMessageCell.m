//
//  GGMessageCell.m
//  GG
//
//  Created by YANGReal on 14-7-19.
//  Copyright (c) 2014年 GG. All rights reserved.
//

#import "GGMessageCell.h"

@interface GGMessageCell ()
@property (weak , nonatomic) IBOutlet UIImageView *avatarView;
@property (weak , nonatomic) IBOutlet UIView *bgView;;
@end

@implementation GGMessageCell

- (void)awakeFromNib
{
    // Initialization code
    self.backgroundColor = CLEAR_COLOR;
    self.avatarView.clipsToBounds = YES;
    self.bgView.backgroundColor = WHITE_COLOR;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
   
   

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
