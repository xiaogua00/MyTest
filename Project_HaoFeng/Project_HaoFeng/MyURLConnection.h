//
//  MyURLConnection.h
//  net_day1_03_urlconnection_package
//
//  Created by 张广洋 on 15/12/28.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import <Foundation/Foundation.h>

//加载数据过程中的block回调
typedef void (^NetProgress)(long,long long);

//最终结果的block回调类型
typedef void (^NetHandle)(id,NSError *);

@interface MyURLConnection : NSObject

/**
 *  访问网络
 *
 *  @param urlStr   url链接字符串
 *  @param progress 加载过程中的回调
 *  @param handle   加载完成的回调
 */
+(void)accessServerWithURLStr:(NSString *)urlStr
                     progress:(NetProgress)progress
                       handle:(NetHandle)handle;

@end









