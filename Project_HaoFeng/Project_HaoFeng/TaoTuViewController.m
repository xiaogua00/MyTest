//
//  TaoTuViewController.m
//  Project_HaoFeng
//
//  Created by qianfeng001 on 16/1/21.
//  Copyright © 2016年 郝锋. All rights reserved.
//

#import "TaoTuViewController.h"
#import "UIImageView+WebCache.h"
@interface TaoTuViewController ()<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
}
@property (nonatomic)NSInteger a;
@end

@implementation TaoTuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createScrollView];
    [self createImageView];
    
}
- (void)createScrollView
{

    _scrollView = [[UIScrollView alloc] init];
    CGSize size = self.view.frame.size;
    _scrollView.frame = CGRectMake(0, 0, size.width, size.height);
    self.automaticallyAdjustsScrollViewInsets = NO;
    _scrollView.contentSize = CGSizeMake(size.width, _arr.count * 200 + 250);
    _scrollView.delegate = self;
    
    [self.view addSubview:_scrollView];
    
}
- (void)createImageView
{
    CGSize size = _scrollView.frame.size;
    NSArray * array = self.arr;
    UILabel * label = [[UILabel alloc] init];
    label.text = self.str2;
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = CGRectMake(0, 64, size.width, 100);
    label.font = [UIFont systemFontOfSize:20];
    [_scrollView addSubview:label];
      for(int i = 0; i < array.count; i++)
    {
        UIImageView * view = [[UIImageView alloc] init];
        [view sd_setImageWithURL:[NSURL URLWithString:array[i]] placeholderImage:[UIImage imageNamed:@"loading"]];
        view.frame = CGRectMake(5, (200 + 5) * i + 164, size.width - 10, 200);
        [_scrollView addSubview:view];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
