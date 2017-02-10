//
//  HTDetailActionView.m
//  首页滑动页面
//
//  Created by emppu－cao on 16/4/27.
//  Copyright © 2016年 emppu－cao. All rights reserved.
//

#import "HTDetailActionView.h"
#import "HTDetaiAlertContentCell.h"
#import "HTDetailAddCell.h"

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height

#define margin 15
// 按钮的高度 。
#define btnH 45
// alert样式弹框的高度
#define alertH 320

static NSString *const MainCell = @"MainCell";
static NSString *const AttachedCell = @"AttachedCell";

typedef  void (^actionBlock)();
@interface HTDetailActionView() <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) UIView *backView;
@property (nonatomic, copy) void(^actionBlock)(NSInteger);
@property (nonatomic, assign) CGFloat backViewH;

@property (nonatomic, strong) NSMutableArray *dataAry;
@property (nonatomic, strong) NSMutableArray *markAry;
/** 上次选中的行 */
@property (nonatomic, assign) NSInteger idxRow;

@end


@implementation HTDetailActionView

+ (instancetype)action
{
    return [[self alloc]init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setUpContentWithStyle:HTDetailActionSheet];
          }
    
    return self;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self setUpContentWithStyle:HTDetailActionSheet];
        }
    
    return self;
}
- (void)dealloc
{
    NSLog(@"%s", __func__);
}

- (void)setActionStyle:(HTDetailActionStyle)actionStyle
{
    _actionStyle = actionStyle;
    [self setUpContentWithStyle:actionStyle];
    
}

- (void)setUpContentWithStyle:(HTDetailActionStyle)style
{
    self.idxRow = -1;
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    // 2.添加自己到窗口上
    [window addSubview:self];
    self.frame = window.bounds;
    self.backgroundColor = [UIColor blackColor];
    self.alpha = 0.65;

    // 创建背板
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    [window addSubview:backView];
    self.backView = backView;
    // 添加约束
    if (style == HTDetailActionSheet) {
        
        self.backView.frame = CGRectMake(0, ScreenH, ScreenW, self.backViewH);
       
    }else
    {
        backView.layer.cornerRadius = 8;
        self.backView.frame = CGRectMake(margin, 0, ScreenW - (margin * 2), alertH);
        self.backView.center = self.center;
        // 添加子控件
        [self addchildViews];
        
    }
}

- (void)addchildViews
{
    // 标题
    UILabel *title = [[UILabel alloc]init];
    title.text = @"商品展示页";
    title.textAlignment = NSTextAlignmentCenter;
    [self.backView addSubview:title];
    title.font = [UIFont systemFontOfSize:20];
    CGFloat titleW = self.backView.frame.size.width;
    CGFloat titleH = 45;
    title.frame = CGRectMake(0, 0, titleW, titleH);
    
    // 删除按钮，
    UIButton *removeBtn = [[UIButton alloc]init];
    [removeBtn setImage:[UIImage imageNamed:@"PPDetailAlertCancel"] forState:UIControlStateNormal];
    CGFloat btnW = 45;
    removeBtn.contentEdgeInsets = UIEdgeInsetsMake(-18, 0, 0, -18);
    removeBtn.frame = CGRectMake(titleW - btnW, 0, btnW, titleH);
    [removeBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [removeBtn addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:removeBtn];
    
    
    // 确认购买
    UIButton *Okbtn = [[UIButton alloc]init];
    [Okbtn setTitle:@"确认" forState:UIControlStateNormal];
    Okbtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    Okbtn.backgroundColor = [UIColor orangeColor];
    Okbtn.titleLabel.font = [UIFont systemFontOfSize:16];
    Okbtn.layer.cornerRadius = 5;
    CGFloat okH = 45;
    CGFloat okX = 8;
    CGFloat okW = titleW - okX * 2;
    CGFloat okY = self.backView.frame.size.height - 80;
    Okbtn.frame = CGRectMake(okX, okY, okW, okH);
    [Okbtn addTarget:self action:@selector(okButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:Okbtn];
    
    
    // 添加选框。
    CGFloat contentH = self.backView.frame.size.height - titleH - (okH + 35);
    CGRect contentframe = CGRectMake(okX, titleH, okW, contentH);
    UITableView *contentView = [[UITableView alloc]initWithFrame:contentframe style:UITableViewStylePlain];
    contentView.dataSource = self;
    contentView.delegate = self;
    contentView.separatorStyle = UITableViewCellSeparatorStyleNone;
    contentView.showsVerticalScrollIndicator = NO;
    contentView.backgroundColor = [UIColor whiteColor];
    [self.backView addSubview:contentView];
    
}

- (void)okButtonClick
{
    
    [self cancelButtonClick];
    __weak __typeof(&*self)weakSelf = self;
    self.OKBtnClickWithIdx(weakSelf.idxRow);
}



#pragma mark -------- 取消选择框  -----------
- (void)cancelButtonClick
{
    if (self.didCancelClick) {
        self.didCancelClick();
    }
    if (self.actionStyle == HTDetailActionAlert) {
        [UIView animateWithDuration:0.25 animations:^{
            self.backView.hidden = YES;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            [self.backView removeFromSuperview];
        }];
        
    }else if (self.actionStyle == HTDetailActionSheet)
    {
        [UIView animateWithDuration:0.25 animations:^{
            
            self.backView.frame = CGRectMake(0, ScreenH, ScreenW, self.backViewH);
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            [self.backView removeFromSuperview];
        }];
    }

}

- (void)click:(UIButton *)button
{
    //    dispatch_async(dispatch_get_global_queue(0, 0), ^{
    
    self.actionBlock(button.tag);
    //    });
    [self cancelButtonClick];
    
}


- (void)setActionWithTitles:(NSArray  *)titles selectedIndex:(void (^)(NSInteger))index
{
    if (self.actionStyle == HTDetailActionAlert)return;

    [titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        self.actionBlock = index;
        NSString *title = titles[idx];
        
        UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        titleBtn.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255.0)/ 189.0 green:arc4random_uniform(255.0)/ 189.0 blue:arc4random_uniform(255.0)/ 189.0 alpha:1.0];
        [titleBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        
        [titleBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [titleBtn setTitle:title forState:UIControlStateNormal];
        [titleBtn.layer setBorderWidth:0.75];
        titleBtn.layer.cornerRadius = 2.5;
        titleBtn.layer.masksToBounds=YES;
        [titleBtn.layer setBorderColor:[UIColor lightGrayColor].CGColor];


        titleBtn.frame = CGRectMake(margin,5 + idx * (btnH + 5), ScreenW - (margin / 0.5), btnH);
        [self.backView addSubview:titleBtn];
        titleBtn.tag = idx;
        self.backViewH = CGRectGetMaxY(titleBtn.frame);
        
    }];
  
}

- (void)setActionAlertWithItems:(NSArray<NSDictionary *> *)AlertItems 
{
    
    if (self.actionStyle == HTDetailActionSheet)return;
    NSDictionary *dic = @{@"Cell": @"MainCell",@"isAttached":@(NO)};
    for (NSDictionary *dict in AlertItems) {
        [self.markAry addObject:dic];
        [self.dataAry addObject:dict];
        
    }

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.actionStyle == HTDetailActionSheet) {
        [self cancelButtonClick];
    }
}
- (void)showView
{

    if(self.actionStyle == HTDetailActionSheet)
    {
        CGFloat backH = self.backViewH + (margin * 2);
        [UIView animateWithDuration:0.25 animations:^{
            
            CGFloat backY = ScreenH - backH + 10;
            self.backView.frame = CGRectMake(0, backY, ScreenW, backH);
        }];
        
    }else if (self.actionStyle == HTDetailActionAlert){
        self.backView.transform = CGAffineTransformMakeScale(0.35, 0.35);
       [UIView animateWithDuration:0.25 animations:^{
           self.backView.transform = CGAffineTransformIdentity;
       }];
        
        
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.markAry.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[self.markAry[indexPath.row] objectForKey:@"Cell"] isEqualToString:MainCell]) {
        HTDetaiAlertContentCell *cell = [tableView dequeueReusableCellWithIdentifier:MainCell];
        if (cell == nil) {
            
            cell = [[HTDetaiAlertContentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MainCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if(indexPath.row <= self.dataAry.count)
        {
        NSDictionary *dict = self.dataAry[indexPath.row];
        cell.goodsName.text = [dict objectForKey:@"name"];
        cell.goodsPrice.text = [dict objectForKey:@"price"];
        }
        return cell;
        
    }else if ([[self.markAry[indexPath.row] objectForKey:@"Cell"] isEqualToString:AttachedCell])
    {
        HTDetailAddCell *cell = [tableView dequeueReusableCellWithIdentifier:AttachedCell];
        if (cell == nil) {
            cell = [[HTDetailAddCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AttachedCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    
        if(indexPath.row <= self.dataAry.count)   
        {
            NSDictionary *dict = self.dataAry[indexPath.row - 1];
            cell.explainLabel.text = [dict objectForKey:@"detail"];
        }
        
        return cell;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 重复点击某一行
//    if (self.idxRow == indexPath.row) {
//        [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    }
//    self.idxRow = indexPath.row;
    
    NSIndexPath *path = nil;
    
    if ([[self.markAry[indexPath.row] objectForKey:@"Cell"] isEqualToString:MainCell]) {
        path = [NSIndexPath indexPathForItem:(indexPath.row+1) inSection:indexPath.section];
        // 传递点击的索引
        self.idxRow = indexPath.row;
    }else{
        path = indexPath;
    }
    
    if ([[self.markAry[indexPath.row] objectForKey:@"isAttached"] boolValue]) {
        // 关闭附加cell
        NSDictionary * dic = @{@"Cell": MainCell,@"isAttached":@(NO)};
        self.markAry[(path.row-1)] = dic;
        [self.markAry removeObjectAtIndex:path.row];
        [self.dataAry removeObjectAtIndex:path.row];
        
        [tableView beginUpdates];
        [tableView deleteRowsAtIndexPaths:@[path]  withRowAnimation:UITableViewRowAnimationMiddle];
        [tableView endUpdates];
        
    }else{
        // 打开附加cell
        NSDictionary * dic = @{@"Cell": MainCell,@"isAttached":@(YES)};
        self.markAry[(path.row-1)] = dic;
        NSDictionary * addDic = @{@"Cell": AttachedCell,@"isAttached":@(YES)};
        [self.markAry insertObject:addDic atIndex:path.row];
        [self.dataAry insertObject:addDic atIndex:path.row];
        [tableView beginUpdates];
        [tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationMiddle];
        [tableView endUpdates];
        
    }
 
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[self.markAry[indexPath.row] objectForKey:@"Cell"] isEqualToString:MainCell])
    {
        return 50;
    }else{
        return 90;
    }
}


- (NSMutableArray *)dataAry
{
    if (!_dataAry) {
        _dataAry = [NSMutableArray array];
    }
    return _dataAry;
}

- (NSMutableArray *)markAry
{
    if (!_markAry) {
        _markAry = [NSMutableArray array];
    }
    return _markAry;
}

@end
