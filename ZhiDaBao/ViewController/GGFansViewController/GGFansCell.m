//
//  GGFansCell.m
//  GG
//
//  Created by YANGReal on 14-9-23.
//  Copyright (c) 2014年 GG. All rights reserved.
//

#import "GGFansCell.h"

@interface GGFansCell ()
@property (weak , nonatomic) IBOutlet UIView *line;
- (IBAction)buttonClicked:(id)sender;

@end

@implementation GGFansCell

- (void)awakeFromNib
{
    // Initialization code
    self.line.height = 0.5;
    self.line.backgroundColor = BG_COLOR;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)buttonClicked:(id)sender
{
    if([self.delegate respondsToSelector:@selector(fansCell:didClickPrivateMessageWithIndex:)])
    {
        [self.delegate fansCell:self didClickPrivateMessageWithIndex:_index];
    }
}

@end
