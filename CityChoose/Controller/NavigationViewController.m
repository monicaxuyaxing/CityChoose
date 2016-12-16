//
//  NavigationViewController.m
//  QJdouguoView
//
//  Created by Justin on 16/3/19.
//  Copyright © 2016年 Justin. All rights reserved.
//

#import "NavigationViewController.h"

@interface NavigationViewController ()

@end

@implementation NavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationBar setBarTintColor:[UIColor orangeColor]];
    [self.navigationBar setTranslucent:NO];//设置透明度
    self.hidesBarsOnSwipe = NO;

    // 去掉导航分割线
    [self.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
   // [self.navigationBar setShadowImage:[[UIImage alloc] init]];
    NSDictionary  *textAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:22]};
         // 设置导航栏的字体大小  颜色
    [self.navigationBar setTitleTextAttributes:textAttributes];


}

- (UIStatusBarStyle)preferredStatusBarStyle
{
         // UIStatusBarStyleLightContent 白色
         // UIStatusBarStyleDefault      黑色
         return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
