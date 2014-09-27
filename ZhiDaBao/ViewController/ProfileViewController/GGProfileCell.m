//
//  GGProfileCell.m
//  GG
//
//  Created by YANGReal on 14-7-19.
//  Copyright (c) 2014年 GG. All rights reserved.
//

#import "GGProfileCell.h"

@interface GGProfileCell ()

@property (weak , nonatomic) IBOutlet UIView *bgView;
@property (weak , nonatomic) IBOutlet UILabel *titleLabel;
@property (weak , nonatomic) IBOutlet UIImageView *arrow;
@end

@implementation GGProfileCell

- (void)awakeFromNib
{
    // Initialization code
    self.backgroundColor = CLEAR_COLOR;
    self.bgView.backgroundColor = WHITE_COLOR;
    UIView *line = [[UIView alloc] initWithFrame:RECT(5, self.height-1, self.width-10, 0.5)];
    line.backgroundColor = C2;
    [self.contentView addSubview:line];

    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.text = _title;
   
    //_arrow.hidden = [_title isEqualToString:@"个性签名"];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
