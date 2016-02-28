//
//  MYFactory.m
//  net_day10_o5_代码添加约束
//
//  Created by qianfeng001 on 16/1/9.
//  Copyright © 2016年 郝锋. All rights reserved.
//

#import "MYFactory.h"

@implementation MYFactory

+ (UIView *)viewWithFrame:(CGRect)frame bgColor:(UIColor *)bgcolor superView:(UIView *)superView
{
    //创建对象
    UIView * view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = bgcolor;
    if(superView)
    {
        [superView addSubview:view];
    }
    return view;
}
+ (UIButton *)btnWithFrame:(CGRect)frame title:(NSString *)title target:(id)target sel:(SEL)sel superView:(UIView *)superView
{
    //创建按钮对象
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = frame;
    [btn setTitle:title forState:0];
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor cyanColor];
    if(superView)
    {
        [superView addSubview:btn];
    }
    return btn;
}

@end
