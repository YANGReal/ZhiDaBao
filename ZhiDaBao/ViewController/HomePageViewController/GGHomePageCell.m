//
//  GGHomePageCell.m
//  GG
//
//  Created by YANGReal on 14-7-19.
//  Copyright (c) 2014年 GG. All rights reserved.
//

#import "GGHomePageCell.h"

@interface GGHomePageCell ()
@property (weak , nonatomic) IBOutlet UIImageView *coverView;
@property (weak , nonatomic) IBOutlet UIView *bgView;
@property (weak , nonatomic) IBOutlet UILabel *contentLabel;
@property (weak , nonatomic) IBOutlet UILabel *subLabel;

@property (strong , nonatomic) UIImage *placeHolder;



@end

@implementation GGHomePageCell

- (void)awakeFromNib
{
    // Initialization code
    self.bgView.backgroundColor = WHITE_COLOR;
    self.coverView.clipsToBounds = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
   // self.contentView.backgroundColor = [UIColor colorWithHexString:@"#c6c6c6"];
   // self.backgroundColor = [UIColor colorWithHexString:@"#c6c6c6"];
    //self.placeHolder = [UIImage imageFromMainBundleFile:@"placeHolder.png"];
    UIView *line = [[UIView alloc] initWithFrame:RECT(0, 0, _bgView.width, 3)];
    line.y = self.bgView.height-3;
    line.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    [_bgView addSubview:line];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

}


- (IBAction)like:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(homeCell:didClickLikeButtonWithData:)])
    {
        [self.delegate homeCell:self didClickLikeButtonWithData:_data];
    }
}

- (IBAction)comment:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(homeCell:didClickCommentButtonWithData:)])
    {
        [self.delegate homeCell:self didClickCommentButtonWithData:_data];
    }
}

- (IBAction)share:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(homeCell:didClickShareButtonWithData:)])
    {
        [self.delegate homeCell:self didClickShareButtonWithData:_data];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
