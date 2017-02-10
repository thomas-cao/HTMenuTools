//
//  HTDetaiAlertContentCell.m
//  首页滑动页面
//
//  Created by emppu－cao on 16/11/23.
//  Copyright © 2016年 emppu－cao. All rights reserved.
//

#import "HTDetaiAlertContentCell.h"

@interface HTDetaiAlertContentCell()
/** 选择=标记 */
@property (nonatomic, weak) UIButton *markBtn;
///** 商品价格 */
//@property (nonatomic, weak) UILabel *goodsPrice;

@end

@implementation HTDetaiAlertContentCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self addContent];
    }
    
    return self;
}

- (void)addContent
{
    UIButton *markBtn = [[UIButton alloc]init];
    [markBtn setImage:[UIImage imageNamed:@"PPDetailAlertCheck_NorMal"] forState:UIControlStateNormal];
    [markBtn setImage:[UIImage imageNamed:@"PPDetailAlertCheck_Selected"] forState:UIControlStateSelected];
    markBtn.userInteractionEnabled = NO;
    [self.contentView addSubview:markBtn];
    self.markBtn = markBtn;
    
    
    UILabel *name = [[UILabel alloc]init];
    name.text = @"";
    name.font = [UIFont systemFontOfSize:14];
    name.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:name];
    self.goodsName = name;
    
    UILabel *price = [[UILabel alloc]init];
    price.text = @"";
    price.textColor = [UIColor orangeColor];
    price.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:price];
    self.goodsPrice = price;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat superH = self.contentView.frame.size.height;
    self.markBtn.frame = CGRectMake(0, 0, 35, superH);
    
    CGFloat superW = self.contentView.frame.size.width;
    CGFloat priceW = 50;
    
    self.goodsPrice.frame = CGRectMake(superW - priceW, 0, priceW, superH);
    
    self.goodsName.frame = CGRectMake(35, 0, superW - 35 - priceW, superH);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    self.markBtn.selected = selected;

}
@end
