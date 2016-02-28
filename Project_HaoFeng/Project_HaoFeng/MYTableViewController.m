//
//  MYTableViewController.m
//  练习——美家帮
//
//  Created by qianfeng001 on 16/1/9.
//  Copyright © 2016年 郝锋. All rights reserved.
//

#import "MYTableViewController.h"
#import "MyURLConnection.h"
#import "MYCell.h"
#import "AnLiModel.h"
#import "UIImageView+WebCache.h"
#import "UIScrollView+MJRefresh.h"
#import "AnLiViewController.h"

#define URL (@"http://v5.owner.mjbang.cn/api/design/list?imei=352204062246410&app_version=2.1.7&user_token=b71956f272cc8c68aebe36bd3fa95f42-105323-App%5CModels%5CMember&page=5&app_channel=A360&phone_type=Android&limit=10&app_type=Owner&statistics_city_id=260")
@interface MYTableViewController ()<UICollectionViewDelegateFlowLayout>
{
    NSMutableArray *_dataArrray;
    NSMutableArray *_userModel;
    NSString *_url;

}
@property (nonatomic)NSInteger i;
@end

@implementation MYTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArrray = [[NSMutableArray alloc] init];
    _url = @"http://v5.owner.mjbang.cn/api/design/list?imei=352204062246410&app_version=2.1.7&user_token=b71956f272cc8c68aebe36bd3fa95f42-105323-App%5CModels%5CMember&page=1&app_channel=A360&phone_type=Android&limit=10&app_type=Owner&statistics_city_id=260";
    //注册自定义cell
    [self.tableView registerNib:[UINib nibWithNibName:@"MYCell" bundle:nil] forCellReuseIdentifier:@"cellId"];
    self.tableView.estimatedRowHeight = 200;
    [self getData];
    [self setRefreshaction];
}
- (void)setRefreshaction
{
    //添加头部响应事件
    [self.tableView addHeaderWithTarget:self action:@selector(headRefresh)];
    self.tableView.headerPullToRefreshText = @"继续下拉，进行刷新";
    self.tableView.headerRefreshingText = @"正在刷新中~~~~";
    self.tableView.headerReleaseToRefreshText = @"松开，进行刷新";
    //添加地步响应事件
    [self.tableView addFooterWithTarget:self action:@selector(footRefresh)];
    self.tableView.footerPullToRefreshText = @"继续上拉，加载更多";
    self.tableView.footerRefreshingText = @"正在加载更多数据";
    self.tableView.footerReleaseToRefreshText = @"松开，加载更多";
}
- (void)headRefresh
{
       [self performSelector:@selector(refreshData) withObject:nil afterDelay:2.0];
}
- (void)refreshData
{
    _i = 1;
    _url = @"http://v5.owner.mjbang.cn/api/design/list?imei=352204062246410&app_version=2.1.7&user_token=b71956f272cc8c68aebe36bd3fa95f42-105323-App%5CModels%5CMember&page=2&app_channel=A360&phone_type=Android&limit=10&app_type=Owner&statistics_city_id=260";
    
    //移除所有数据
    
    [_dataArrray removeAllObjects] ;
    
    [self getData];
    //刷新界面
    [self.tableView reloadData];
    //结束界面刷新状态
    [self.tableView headerEndRefreshing];
}
- (void)footRefresh
{
    [self performSelector:@selector(getMoreData) withObject:nil afterDelay:2.0];
}
- (void)getMoreData
{
    _i = 3;
    _url = [NSString stringWithFormat:@"http://v5.owner.mjbang.cn/api/design/list?imei=352204062246410&app_version=2.1.7&user_token=b71956f272cc8c68aebe36bd3fa95f42-105323-App5CModels5CMember&page=%hu&app_channel=A360&phone_type=Android&limit=10&app_type=Owner&statistics_city_id=260",(unichar)_i];
    _i ++;
       [self getData];
    //刷新界面
    [self.tableView reloadData];
    //结束界面刷新状态
    [self.tableView footerEndRefreshing];
}
- (void)getData
{
    __weak typeof(self) weakSelf= self;
    [MyURLConnection accessServerWithURLStr:_url progress:nil handle:^(id result, NSError * error) {
        if(!error)
        {
            //进行json解析
            NSError * error1 = nil;
            NSMutableDictionary * resultDic = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:&error1];
            if(!error1)
            {
               // NSLog(@"解析完成：%@",resultDic);
                //遍历数组，获取每个用户
                NSArray * data = resultDic[@"data"];
                for(NSDictionary * oneUserDic in data)
                {
                    AnLiModel * oneModel = [[AnLiModel alloc] init];
                
                    [oneModel setValuesForKeysWithDictionary:oneUserDic];
                    [_dataArrray addObject:oneModel];
                    // NSLog(@"%@",oneModel.picture);
                }
                [weakSelf.tableView reloadData];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return _dataArrray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MYCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    AnLiModel * model = _dataArrray[indexPath.row];
    [cell.imgV sd_setImageWithURL:[NSURL URLWithString:model.picture] placeholderImage:[UIImage imageNamed:@"1.png"]];
    cell.Lab1.text = model.design_name;
    NSString * str = [NSString stringWithFormat:@"%@         %@         %@         %@",model.city,model.design_style_title,model.rooms_title,model.area];
    cell.Lab2.text = str;
    [cell.Btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    cell.Btn.tag = indexPath.row + 1;
     return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300;
}
- (void)click:(UIButton *)sender
{
    AnLiViewController * avc = [[AnLiViewController alloc] init];
    avc.hidesBottomBarWhenPushed = YES;
    avc.url = [_dataArrray[sender.tag - 1] valueForKey:@"Id"];
    
    [self.navigationController pushViewController:avc animated:YES];
}




@end
