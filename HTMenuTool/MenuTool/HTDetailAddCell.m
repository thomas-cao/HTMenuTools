//
//  HTDetailAddCell.m
//
//  Created by emppu－cao on 16/11/23.
//  Copyright © 2016年 emppu－cao. All rights reserved.
//

#import "HTDetailAddCell.h"

#define PPRGBAColor(r,g,b,a)    [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

@implementation HTDetailAddCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.layer.borderColor = PPRGBAColor(147,151,154,1.0).CGColor;
        self.contentView.layer.borderWidth = 0.75;
        self.userInteractionEnabled = NO;
        [self addContent];
    }
    return self;
}

- (void)addContent
{
    UILabel *explainLabel = [[UILabel alloc]init];
    explainLabel.text = @"";
    explainLabel.textColor = PPRGBAColor(147,151,154,1.0);
    explainLabel.font = [UIFont systemFontOfSize:14];
    explainLabel.numberOfLines = 0;
    [self.contentView addSubview:explainLabel];
    self.explainLabel = explainLabel;

    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat W = self.contentView.frame.size.width;
    self.explainLabel.frame = CGRectMake(10, 0, W - 20, self.contentView.frame.size.height);
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
