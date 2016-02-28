//
//  MYFactory.h
//  net_day10_o5_代码添加约束
//
//  Created by qianfeng001 on 16/1/9.
//  Copyright © 2016年 郝锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface MYFactory : NSObject
/*
 创建一个视图对象
 frame    位置大小
 bgcolor  背景色
 superView  父视图
 
 return   视图对象
 */
+ (UIView *)viewWithFrame:(CGRect)frame bgColor:(UIColor *)bgcolor superView:(UIView *)superView;

/*
 创建一个按钮
 frame   位置大小
 title   标题
 tagert        响应事件的对象
 sel       响应方法
 superView       父视图
    
  return      按钮对象
 */
+ (UIButton *)btnWithFrame:(CGRect)frame title:(NSString *)title target:(id)target sel:(SEL)sel superView:(UIView *)superView;
@end
