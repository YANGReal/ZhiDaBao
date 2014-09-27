//
//  GGGoodListCell.m
//  GG
//
//  Created by YANGReal on 14-9-23.
//  Copyright (c) 2014年 GG. All rights reserved.
//

#import "GGGoodListCell.h"

@interface GGGoodListCell ()
@property (weak , nonatomic) IBOutlet UIView *bgView;
@property (weak , nonatomic) IBOutlet UIImageView *cover;
@property (weak , nonatomic) IBOutlet UILabel *nameLabel;
@property (weak , nonatomic) IBOutlet UILabel *priceLabel;
@property (weak , nonatomic) IBOutlet UILabel *oldLabel;
@end

@implementation GGGoodListCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = CLEAR_COLOR;
        UIView *bgView = [[UIView alloc] initWithFrame:RECT(10, 0, 300, 108)];
        bgView.tag = -100;
        bgView.backgroundColor = WHITE_COLOR;
        [self.contentView addSubview:bgView];
        
        UIImageView *cover = [[UIImageView alloc] initWithFrame:RECT(13, 12, 116, 84)];
        cover.clipsToBounds = YES;
        cover.tag = 100;
        cover.contentMode = UIViewContentModeScaleAspectFill;
        [bgView addSubview:cover];
        cover.image = [UIImage imageFromMainBundleFile:@"pizza.png"];
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:RECT(137 ,20 ,166 ,21)];
        nameLabel.font = [UIFont systemFontOfSize:15];
        nameLabel.tag = 101;
        nameLabel.text = @"123444";
        [bgView addSubview:nameLabel];
        
        //150 ,75 ,52 ,21
        UILabel *oldLabel = [[UILabel alloc] initWithFrame:RECT(150 ,75 ,52 ,21)];
        oldLabel.font = [UIFont systemFontOfSize:15];
        oldLabel.tag = 103;
        oldLabel.textColor = [UIColor lightGrayColor];
        oldLabel.text = @"14";
        oldLabel.textAlignment = NSTextAlignmentCenter;
        [bgView addSubview:oldLabel];
        
        UILabel *priceLabel = [[UILabel alloc] initWithFrame:RECT(238 ,75 ,65 ,21)];
        priceLabel.font = [UIFont systemFontOfSize:17];
        priceLabel.tag = 102;
        priceLabel.textColor = BLUE_COLOR;
        priceLabel.text = @"14";
        [bgView addSubview:priceLabel];

    }
    return self;
}


- (void)awakeFromNib
{
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.bgView.backgroundColor = WHITE_COLOR;
    self.backgroundColor = CLEAR_COLOR;
    self.cover.clipsToBounds = YES;
}

- (void)layoutSubviews
{
     [super layoutSubviews];
    _nameLabel.text = [_data stringAttribute:@"name"];
    self.oldLabel.text = [_data stringAttribute:@"price"];
    self.priceLabel.text = [_data stringAttribute:@"discount_price"];
    
    NSString *imgurl = [_data stringAttribute:@"image1"];
    if (imgurl.length == 0)
    {
        imgurl = [_data stringAttribute:@"icon"];
    }
    NSURL *url = [NSURL URLWithString:imgurl];
    UIImage *placeHolder = [UIImage imageWithColor:C2];
    [self.cover setImageWithURL:url placeholderImage:placeHolder];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
