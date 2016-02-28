//
//  WebViewController.m
//  练习——首页
//
//  Created by qianfeng001 on 16/1/17.
//  Copyright © 2016年 郝锋. All rights reserved.
//

#import "WebViewController.h"
#import "AFNetworking.h"
@interface WebViewController ()<UIWebViewDelegate>
{
    AFHTTPRequestOperationManager *_manager;
}
@property (nonatomic,strong)UIWebView * webView;
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.webView.delegate= self;
    [self.view addSubview:self.webView];
   NSString * urlStr = [NSString stringWithFormat:@"http://mobileapi.to8to.com/smallapp.php?module=Album&action=Detail&version=2.5&android=1&id=%@&ptag=30032_1_3_1&to8to_from=sanliuling&uid=null&channel=sanliuling&appversion=2.5.6&systemversion=18&to8to_token=null&appostype=1&imei=352204062246410&fromnewapp=1",self.url];
    _manager = [AFHTTPRequestOperationManager manager];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [_manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString * newStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        newStr = [newStr stringByReplacingOccurrencesOfString:@"查看更多专题" withString:@"结束"];
        [self.webView loadHTMLString:newStr baseURL:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"下载失败");
    }];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
