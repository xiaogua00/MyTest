//
//  AnLiViewController.m
//  Project_HaoFeng
//
//  Created by qianfeng001 on 16/1/20.
//  Copyright © 2016年 郝锋. All rights reserved.
//

#import "AnLiViewController.h"
#import "MyURLConnection.h"
#import "UIImageView+WebCache.h"
#import "DetailModel.h"
#define URL (@"http://v5.owner.mjbang.cn/api/design/detail?imei=352204062246410&app_version=2.1.7&user_token=b71956f272cc8c68aebe36bd3fa95f42-105323-App%5CModels%5CMember&id=164&app_channel=A360&phone_type=Android&app_type=Owner&statistics_city_id=260")
@interface AnLiViewController ()<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    NSMutableArray *_imageViews;
    NSMutableArray *_dataarray;
    NSMutableArray *_height;
    NSMutableArray *_urlArr;
    NSString *_LianJie;
}
@property (nonatomic)NSInteger i;
@property (nonatomic)NSInteger a;
@end

@implementation AnLiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _LianJie = [NSString stringWithFormat:@"http://v5.owner.mjbang.cn/api/design/detail?imei=352204062246410&app_version=2.1.7&user_token=b71956f272cc8c68aebe36bd3fa95f42-105323-App5CModels5CMember&id=%@&app_channel=A360&phone_type=Android&app_type=Owner&statistics_city_id=260",self.url];
       _dataarray = [[NSMutableArray alloc] init];
    _height = [[NSMutableArray alloc] init];
    _urlArr = [[NSMutableArray alloc] init];
    [self getData];
  
    
    
}
- (void)getData
{
    
    //__weak typeof(self) weakSelf = self;
    [MyURLConnection accessServerWithURLStr:_LianJie progress:nil handle:^(id result, NSError *error) {
        if(!error)
        {
                      //进行json解析
            NSError * error1 = nil;
            NSMutableDictionary * resultDic = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:&error1];
                        if(!error1)
            {
                //NSArray * data = resultDic[@"data"];
                NSDictionary * dict = resultDic[@"data"];
                NSArray * data = [dict valueForKey:@"design_picture"];
                NSDictionary * dic = [dict valueForKey:@"design_data"];
                NSString * str1 = [dic valueForKey:@"huxingtu"];
                [_urlArr addObject:str1];
                //NSLog(@"!!!!!!!!!!!!!%@",_urlArr);
                NSString * str2 = [dic valueForKey:@"description"];
                [_dataarray addObject:str2];
                NSString * str3 = [NSString stringWithFormat:@"%d",600];
                [_height addObject:str3];
                // NSLog(@"%@",str3);
                for(NSDictionary * oneUserDic in data)
                {
                    DetailModel * oneModel = [[DetailModel alloc] init];
                    [oneModel setValuesForKeysWithDictionary:oneUserDic];
                    [_urlArr addObject:oneModel.picture_url];
                    
                    [_dataarray addObject:oneModel.Description];
               
                    [_height addObject:[oneModel.picture_storage valueForKey:@"height"]];
                }
                
                
                for(int i = 0; i <_height.count; i++)
                {
                    _a += [_height[i] integerValue] /2 + 100;
                    
                }
             
                  [self createScrollView];
                [self createImageViews];
            }else
            {
                NSLog(@"解析失败：%@",error1);
            }
            
        }else
        {
            NSLog(@"访问服务器失败：%@",error);
        }
    }];
}
- (void)createScrollView {

    _scrollView = [[UIScrollView alloc] init];
    CGSize size = self.view.frame.size;
    _scrollView.frame = CGRectMake(0, 64, size.width, size.height);
    self.automaticallyAdjustsScrollViewInsets = NO;
    _scrollView.contentSize = CGSizeMake(size.width, _a +100);
    _scrollView.delegate = self;
    
    
    [self.view addSubview:_scrollView];
}

- (void)createImageViews
{
    CGSize size = _scrollView.frame.size;
    CGFloat height = 0;
    for (int i = 0; i < _dataarray.count; i++)
    {
        
        
        UIImageView * view1 = [[UIImageView alloc] init];
        [view1 sd_setImageWithURL:[NSURL URLWithString:_urlArr[i]] placeholderImage:[UIImage imageNamed:@"1.png"]];
              view1.frame = CGRectMake(0, height, size.width, [_height[i] integerValue] / 2);
        CGFloat y = view1.frame.origin.y +[_height[i] integerValue] /2;
        
        UILabel * label = [[UILabel alloc] init];
        label.frame = CGRectMake(50, y, size.width- 100, 100);
      
        CGFloat yy = label.frame.origin.y;
        height =  yy + label.frame.size.height;
        label.text = _dataarray[i] ;
         label.numberOfLines = 0;
              UILabel * label1 = [[UILabel alloc] init];
        label1.frame = CGRectMake(20, y + 25, 30, 30);
        label1.font = [UIFont systemFontOfSize:27];
        label1.text = [NSString stringWithFormat:@"%d",i + 1];
        [_scrollView addSubview:label1];
        [_scrollView addSubview:label];
        [_scrollView addSubview:view1];
    }
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end

