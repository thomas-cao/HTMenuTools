//
//  ViewController.m
//  HTMenuTool
//
//  Created by emppu－cao on 17/2/10.
//  Copyright © 2017年 emppu－cao. All rights reserved.
//

#import "ViewController.h"
#import "HTDetailActionView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 120, 45)];
    [btn setTitle:@"ActionAlert" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor redColor];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(ActionAlertClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
    
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(100, 170, 120, 45)];
    [btn1 setTitle:@"Actionsheet" forState:UIControlStateNormal];
    btn1.backgroundColor = [UIColor purpleColor];
    btn1.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(ActionsheetClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn1];
    
    
}


- (void)ActionAlertClick
{
        HTDetailActionView *alertView = [[HTDetailActionView alloc]init];
        alertView.actionStyle = HTDetailActionAlert;
    
        NSDictionary *dict1 = @{ @"name" : @"购买单张数码照片", @"price" : @"￥59", @"detail" : @"机动车女司机的度假村京东商城的是的基础上是的基础上是的基础上的山地车家山东济南四大皆空陈女士的"};
        NSDictionary *dict2 = @{@"name" : @"购买迪斯尼来拍拖一卡通" , @"price" : @"￥199", @"detail" : @"2222222222222222手动测试大城市的出生地吃三大城市的三大城市的是三大城市的上档次到位"};
        NSDictionary *dict3 = @{@"name" : @"使用已有的迪斯尼拉拍拖一卡通", @"price" : @"", @"detail" : @"3333333333333333完成调查组的传闻问问财务的山地车为vdcsdc色彩外侧上次单纯的上次"};
    
        NSArray *ary = @[dict1, dict2, dict3];
        [alertView setActionAlertWithItems:ary];
    
        alertView.OKBtnClickWithIdx = ^(NSInteger idx)
        {
            switch (idx) {
                case 0: // 购买单张照片
                    NSLog(@"购买单张数码照片");
                    break;
                case 1: // 购买一卡通
                    NSLog(@"购买迪斯尼来拍拖一卡通");

                    break;
                case 2: // 使用已有的
                    NSLog(@"使用已有的迪斯尼拉拍拖一卡通");

                    break;
                default:
                    break;
            }
        };
        alertView.didCancelClick = ^()
        {
            NSLog(@"取消选择");
        };
        [alertView showView];
 
    
}


- (void)ActionsheetClick
{
    HTDetailActionView *actionView = [HTDetailActionView action];
    [actionView setActionWithTitles:@[@"分享",@"编辑", @"保存", @"购买"] selectedIndex:^(NSInteger idx) {
        NSLog(@"-------");
        
    }];
    
    [actionView showView];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
