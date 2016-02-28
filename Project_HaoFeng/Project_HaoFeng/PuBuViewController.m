//
//  ViewController.m
//  瀑布流自己的
//
//  Created by dllo on 15/10/28.
//  Copyright © 2015年 zhaoqingwen. All rights reserved.
//

#import "PuBuViewController.h"
#import "WJY_WaterFallLayout.h"
#import "ZQW_AppTools.h"
#import "Model.h"
#import "CollectionViewCell.h"
#import "UIScrollView+MJRefresh.h"
#import "SkimViewController.h"
@interface PuBuViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,strong)UIRefreshControl *refreshControl;
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *pixclArray;
@property(nonatomic)NSInteger i;
@property(nonatomic,copy)NSString *url;

@end

@implementation PuBuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pixclArray = [NSMutableArray array];
    _i = 1;
    WJY_WaterFallLayout *waterFallLayout = [[WJY_WaterFallLayout alloc]init];
    waterFallLayout.lineCount = 2;
    waterFallLayout.verticalSpacing = 10;
    waterFallLayout.horizontalSpacing = 10;
    waterFallLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    _collectionView = [[UICollectionView alloc]initWithFrame:[[UIScreen mainScreen]bounds] collectionViewLayout:waterFallLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    

    [_collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
     [self setRefreshaction];
    [self getData];
    
}

- (void)setRefreshaction
{
    [self.collectionView addHeaderWithTarget:self action:@selector(headRefresh)];
    self.collectionView.headerPullToRefreshText = @"继续下拉，进行刷新";
    self.collectionView.headerRefreshingText = @"正在刷新中~~~~";
    self.collectionView.headerReleaseToRefreshText = @"松开，进行刷新";
    //添加地步响应事件
    [self.collectionView addFooterWithTarget:self action:@selector(footRefresh)];
    self.collectionView.footerPullToRefreshText = @"继续上拉，加载更多";
    self.collectionView.footerRefreshingText = @"正在加载更多数据";
    self.collectionView.footerReleaseToRefreshText = @"松开，加载更多";
}
- (void)headRefresh
{
       [self performSelector:@selector(refreshData) withObject:nil afterDelay:2.0];
}
- (void)refreshData
{
   
    _i = 1;
    for(NSInteger i = _pixclArray.count -1 ; i > 19; i--)
    {
        [_pixclArray removeObjectAtIndex:i];
    }
    //刷新界面
    [self.collectionView reloadData];
    //结束界面刷新状态
    [self.collectionView headerEndRefreshing];
    
}
- (void)footRefresh
{
      [self performSelector:@selector(getMoreData) withObject:nil afterDelay:2.0];
}
- (void)getMoreData
{
  
       _i ++;
       [self getData];
    //刷新界面
    [self.collectionView reloadData];
    //结束界面刷新状态
    [self.collectionView footerEndRefreshing];
}


-(void)getData
{
    _url = [NSString stringWithFormat:@"http://v5.owner.mjbang.cn/api/design/list?imei=352204062246410&app_version=2.1.7&user_token=b71956f272cc8c68aebe36bd3fa95f42-105323-App5CModels5CMember&page=%ld&app_channel=A360&phone_type=Android&limit=20&app_type=Owner&statistics_city_id=260",_i];

    [ZQW_AppTools getMessage:_url Block:^(id result) {
        
        NSArray * array = result[@"data"];
        for(NSDictionary * dic in array)
        {
            Model * oneModel = [[Model alloc] init];
            [oneModel setValuesForKeysWithDictionary:dic];
            [self.pixclArray addObject:oneModel];
        }

        [_collectionView reloadData];

        } and:^(id result1) {
        
        
    }];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return  _pixclArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    Model * model = _pixclArray[indexPath.item];
    cell.model = model;
    cell.layer.masksToBounds= YES;
    cell.layer.cornerRadius = 12;
  

    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((375 - 30) / 2, arc4random()%100 + 150);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    SkimViewController * svc = [[SkimViewController alloc] init];

    svc.index = indexPath.row;
    svc.imageNames = [self.pixclArray valueForKey:@"picture"];
    svc.hidesBottomBarWhenPushed = YES;

   [self.navigationController pushViewController:svc animated:YES];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
