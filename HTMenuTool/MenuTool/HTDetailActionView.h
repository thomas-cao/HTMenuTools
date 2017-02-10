//
//  HTDetailActionView.h
//  首页滑动页面
//
//  Created by emppu－cao on 16/4/27.
//  Copyright © 2016年 emppu－cao. All rights reserved.
//
// 自定义弹框工具。
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HTDetailActionStyle) {
    HTDetailActionSheet,
    HTDetailActionAlert
};

@interface HTDetailActionView : UIView
/** 弹框样式 */
@property (nonatomic, assign) HTDetailActionStyle actionStyle;
/** 点击确认按钮的回调 */
@property (nonatomic, copy) void(^OKBtnClickWithIdx)(NSInteger idx);
/** 点击了取消 */
@property (nonatomic, copy) void(^didCancelClick)();
+ (instancetype)action;
/** 底部弹框样式 */
- (void)setActionWithTitles:(NSArray  *)titles selectedIndex:(void(^)(NSInteger))index
;

/** 展示alert中间弹框样式 */
- (void)setActionAlertWithItems:(NSArray<NSDictionary *> *)AlertItems;


- (void)showView;
@end
