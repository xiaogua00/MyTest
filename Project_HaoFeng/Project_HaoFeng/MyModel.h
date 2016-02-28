//
//  MyModel.h
//  练习——一本通
//
//  Created by qianfeng001 on 16/1/19.
//  Copyright © 2016年 郝锋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyModel :NSObject



@property (nonatomic, copy) NSString *puttime;

@property (nonatomic, copy) NSString *page_description;

@property (nonatomic, strong) NSURL *imgurl;

@property (nonatomic, copy) NSString *collection_num;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *kid;

@property (nonatomic, copy) NSString *view_nums;

@end
