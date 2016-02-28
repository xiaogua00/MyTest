
//
//  RootTabBarViewController.m
//  练习——首页
//
//  Created by qianfeng001 on 16/1/17.
//  Copyright © 2016年 郝锋. All rights reserved.
//

#import "RootTabBarViewController.h"

@interface RootTabBarViewController ()

@end

@implementation RootTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 调整tabBar图片显示
    UITabBarItem * item0 = self.tabBar.items[0];
    item0.image = [[UIImage imageNamed:@"iconfont-home"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item0.selectedImage = [[UIImage imageNamed:@"iconfont-home (1)"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem * item1 = self.tabBar.items[1];
    item1.image = [[UIImage imageNamed:@"iconfont-iconfonttupian"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item1.selectedImage = [[UIImage imageNamed:@"iconfont-iconfonttupian (1)"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem * item2 = self.tabBar.items[2];
    item2.image = [[UIImage imageNamed:@"iconfont-dengpao"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item2.selectedImage = [[UIImage imageNamed:@"iconfont-dengpao (1)"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem * item3 = self.tabBar.items[3];
    item3.image = [[UIImage imageNamed:@"iconfont-book"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item3.selectedImage = [[UIImage imageNamed:@"iconfont-book (1)"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
   
    UIColor * color = [UIColor colorWithRed:28/255.0 green:199/255.0 blue:91/255.0 alpha:1.0];
    [item0 setTitleTextAttributes:@{NSForegroundColorAttributeName:color} forState:UIControlStateSelected];
  
    [item1 setTitleTextAttributes:@{NSForegroundColorAttributeName:color} forState:UIControlStateSelected];
 
    [item2 setTitleTextAttributes:@{NSForegroundColorAttributeName:color} forState:UIControlStateSelected];
  
    [item3 setTitleTextAttributes:@{NSForegroundColorAttributeName:color} forState:UIControlStateSelected];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
