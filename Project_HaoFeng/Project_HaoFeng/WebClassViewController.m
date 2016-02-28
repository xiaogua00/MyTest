//
//  WebClassViewController.m
//  Project_HaoFeng
//
//  Created by qianfeng001 on 16/1/20.
//  Copyright © 2016年 郝锋. All rights reserved.
//

#import "WebClassViewController.h"

@interface WebClassViewController ()
{
    UIWebView *_webView;
    NSString *_url;
}
@end

@implementation WebClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _url = [[NSString alloc] initWithString:self.url];
    [self.view addSubview:_webView];
    //指定加载的链接
    NSString * str = [NSString stringWithFormat:@"http://mobileapi.to8to.com/smallapp.php?module=yibentong&action=detail&version=2.5&kid=%@",self.url];
    NSURL * URL = [NSURL URLWithString:str];
    NSURLRequest * request = [NSURLRequest requestWithURL:URL];
    //网页视图，加载对应的request
    [_webView loadRequest:request];
    //调整适应比例
    _webView.scalesPageToFit = YES;

    
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
