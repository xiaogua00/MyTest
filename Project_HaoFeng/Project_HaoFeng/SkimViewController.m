//
//  SkimViewController.m
//  Project_HaoFeng
//
//  Created by qianfeng001 on 16/1/23.
//  Copyright © 2016年 郝锋. All rights reserved.
//


#import "SkimViewController.h"
#import "UIImageView+WebCache.h"
@interface SkimViewController ()<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    NSMutableArray *_imageViews;
}
@end

@implementation SkimViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    self.view.backgroundColor = [UIColor grayColor];
    [self createScrollView];
    [self createImageViews];
    
    }
- (void)createScrollView
{
    _scrollView = [[UIScrollView alloc] init];
    CGSize size = self.view.frame.size;
    _scrollView.frame = CGRectMake(0, 0, size.width, size.height);
    self.automaticallyAdjustsScrollViewInsets = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(size.width * 3, size.height);
    _scrollView.contentOffset = CGPointMake(size.width, 0);
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
}
- (void)createImageViews
{
    _imageViews = [[NSMutableArray alloc] init];
    CGSize size = _scrollView.frame.size;
    NSInteger count = self.imageNames.count;
    for(NSInteger i = 0; i < 3; i++)
    {
        UIImageView * view = [[UIImageView alloc] init];
        view.frame = CGRectMake(size.width * i, 0, size.width, size.height);
        view.tag = (_index + i - 1 + count) % count;
        view.contentMode = UIViewContentModeScaleAspectFit;
        [self setImageToview:view];
        if(i != 1)
        {
            [_scrollView addSubview:view];
        }else
        {
            UIScrollView * sv = [[UIScrollView alloc] initWithFrame:view.frame];
            view.frame = CGRectMake(0, 0, size.width, size.height);
            //设置缩放
            sv.minimumZoomScale = 0.2;
            sv.maximumZoomScale = 2.0;
            
            sv.delegate = self;
            view.userInteractionEnabled = YES;
            //添加单击手势
            UITapGestureRecognizer * singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandle:)];
            [view addGestureRecognizer:singleTap];
            //添加双击手势
            UITapGestureRecognizer * doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandle:)];
            doubleTap.numberOfTapsRequired = 2;
            [view addGestureRecognizer:doubleTap];
            [singleTap requireGestureRecognizerToFail:doubleTap];
            [sv addSubview:view];
            [_scrollView addSubview:sv];
        }
        [_imageViews addObject:view];
          }
    [self refreshTitle];
}
- (BOOL)prefersStatusBarHidden
{
    return self.navigationController.navigationBarHidden;
}
- (void)tapHandle:(UITapGestureRecognizer *)tgr
{
    if(tgr.numberOfTapsRequired == 1)
    {
        //单击
        BOOL hidden = !self.navigationController.navigationBarHidden;
        [self.navigationController setNavigationBarHidden:hidden animated:YES];
        [self setNeedsStatusBarAppearanceUpdate];
    }else
    {
        //双击
        UIScrollView * sv = (UIScrollView *)[tgr.view superview];
        if(sv.zoomScale != 1.0)
        {
            [sv setZoomScale:1.0 animated:YES];
        }else
        {
            [sv setZoomScale:sv.maximumZoomScale animated:YES];
        }
    }
}
- (void)setImageToview:(UIImageView *)view
{
    NSString * name = _imageNames[view.tag];
    
    [view sd_setImageWithURL:[NSURL URLWithString:name] placeholderImage:[UIImage imageNamed:@"1.png"]];
}
- (void)cycleReuse
{
    
    CGFloat offset = _scrollView.contentOffset.x;
    CGFloat width = _scrollView.frame.size.width;
    NSInteger flag = 0;
    if(offset == 0)
    {
        //向右滑
        flag = -1;
    }
    else if (offset == 2 * width)
    {
        //向左滑
        flag = 1;
    }
    else
    {
        return;
    }
    NSInteger count = _imageNames.count;
       for(UIImageView * view in _imageViews)
    {
        view.tag = (view.tag + flag + count) % count;
             [self setImageToview:view];
    }
    //无动画的重置偏移量
    _scrollView.contentOffset = CGPointMake(width, 0);
    //刷新标题
    [self refreshTitle];
    //恢复中间滚动视图的比例为1.0
    UIScrollView * sv = (UIScrollView *)[_imageViews[1] superview];
    sv.zoomScale = 1.0;
}
- (void)refreshTitle
{
       self.navigationItem.title = [NSString stringWithFormat:@"%ld/%lu",[_imageViews[1] tag],_imageNames.count];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma mark - UIscrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self cycleReuse];
    [self refreshTitle];
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageViews[1];
}
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    if(scale < 0.5)
    {
        self.navigationController.navigationBarHidden = NO;
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
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

