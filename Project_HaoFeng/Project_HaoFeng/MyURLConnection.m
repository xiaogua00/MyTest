//
//  MyURLConnection.m
//  net_day1_03_urlconnection_package
//
//  Created by 张广洋 on 15/12/28.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import "MyURLConnection.h"

@interface MyURLConnection()
<NSURLConnectionDataDelegate>
{
    //接收加载的数据
    NSMutableData * _data;
    //预期长度
    long long _expectedContentLength;
}
//加载过程回调的block对象
@property (nonatomic,copy) NetProgress progress;
//加载完成后回调的block对象
@property (nonatomic,copy) NetHandle handle;

@end

@implementation MyURLConnection

//
+(void)accessServerWithURLStr:(NSString *)urlStr
                     progress:(NetProgress)progress
                       handle:(NetHandle)handle{
    //创建NSURL
    NSURL * URL=[NSURL URLWithString:urlStr];
    //创建URLRequest
    NSURLRequest * request=[NSURLRequest requestWithURL:URL];
    //要先有一个当前类的某个对象，它充当代理者
    MyURLConnection * myUrlConnection=[[MyURLConnection alloc]init];
    myUrlConnection.progress=progress;
    myUrlConnection.handle=handle;
    //创建链接
    [NSURLConnection connectionWithRequest:request delegate:myUrlConnection];
}

#pragma mark - connection代理方法 -

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    //实例化
    _data=[[NSMutableData alloc]init];
    //保存长度
    _expectedContentLength=response.expectedContentLength;
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    //追加数据
    [_data appendData:data];
    //回调加载过程
    if (self.progress) {
        self.progress(_data.length,_expectedContentLength);
    }
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    //回调
    if (self.handle) {
        self.handle(_data,nil);
    }
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    //回调
    if (self.handle) {
        self.handle(nil,error);
    }
}

@end









