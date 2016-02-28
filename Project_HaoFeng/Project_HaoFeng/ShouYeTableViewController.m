//
//  ShouYeTableViewController.m
//  练习——首页
//
//  Created by qianfeng001 on 16/1/17.
//  Copyright © 2016年 郝锋. All rights reserved.
//

#import "ShouYeTableViewController.h"
#import "ShouYeModel.h"
#import "UIImageView+WebCache.h"
#import "ZhuanTiTableViewCell.h"
#import "WebViewController.h"
#import "TaoTuModel.h"
#import "TitleModel.h"
#import "TuKuCell.h"
#import "TaoTuViewController.h"
#import "UIScrollView+MJRefresh.h"
#import "SDCycleScrollView.h"
#import "MYFactory.h"
#define URL1 (@"http://mobileapi.to8to.com/smallapp.php?")
#define PAPAMETER1 (@"model=homepage&page=1&imei=352204062246410&action=gjlist&appid=1&appversion=2.5.6&systemversion=18&appostype=1&to8to_token=&channel=sanliuling&version=2.5&")
#define URL2 (@"http://mobileapi.to8to.com/smallapp.php?")
#define PAPAMETER2 (@"model=imagesSets&page=1&imei=352204062246410&action=list&appid=16&perPage=2&paging=1&version=2.5&")
@interface ShouYeTableViewController ()<NSURLSessionDelegate,UICollectionViewDelegateFlowLayout>
{
    //滚动视图
    UIScrollView *_scrollView;
    UIView *_view;
    //声明一个会话对象
    NSURLSession *_urlSession;
    NSMutableArray *_dataArray;
    NSString *_str1;
    NSString *_str2;
    NSMutableArray *_likenum;
 }
@property (nonatomic)NSInteger i;
@property (nonatomic)NSInteger j;
@end

@implementation ShouYeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _likenum = [[NSMutableArray alloc] init];
    _dataArray = [[NSMutableArray alloc] init];
    NSLog(@"123456789");
    _i = 3;
    _j = 2;
    _str1 = @"model=homepage&page=10&imei=352204062246410&action=gjlist&appid=1&appversion=2.5.6&systemversion=18&appostype=1&to8to_token=&channel=sanliuling&version=2.5&";
    _str2 = @"model=imagesSets&page=1&imei=352204062246410&action=list&appid=16&perPage=2&paging=1&version=2.5&";
    NSURLSessionConfiguration * sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    //实例化session
    _urlSession = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:nil];
    //注册自定义cell
    [self.tableView registerNib:[UINib nibWithNibName:@"ZhuanTiTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellId"];
    [self.tableView registerNib:[UINib nibWithNibName:@"TuKuCell" bundle:nil] forCellReuseIdentifier:@"MycellId"];
    self.tableView.estimatedRowHeight = 228;
    
    [self getData];
    [self setRefreshaction];
    [self createScrollView];
    [self createImageView];
}
- (void)setRefreshaction
{
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
    
    _str1 = @"model=homepage&page=1&imei=352204062246410&action=gjlist&appid=1&appversion=2.5.6&systemversion=18&appostype=1&to8to_token=&channel=sanliuling&version=2.5&";
    _str2 =@"model=imagesSets&page=1&imei=352204062246410&action=list&appid=16&perPage=2&paging=1&version=2.5&";
  
    
    //移除所有数据
    
    [_dataArray removeAllObjects] ;
    
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
    
    _str1 = [NSString stringWithFormat:@"model=homepage&page=%ld&imei=352204062246410&action=gjlist&appid=1&appversion=2.5.6&systemversion=18&appostype=1&to8to_token=&channel=sanliuling&version=2.5&",_i];
    _str2 = [NSString stringWithFormat:@"model=imagesSets&page=%ld&imei=352204062246410&action=list&appid=16&perPage=2&paging=1&version=2.5&",_j];
    _i ++;
    _j ++;
    [self getData];
   
    //刷新界面
    [self.tableView reloadData];
    //结束界面刷新状态
    [self.tableView footerEndRefreshing];
}

- (void)getData
{
    __weak typeof(self) weakSelf = self;
    NSURL * url = [NSURL URLWithString:URL1];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    //设置请求方式
    request.HTTPMethod = @"POST";
    //设置请求体
    NSData * body = [_str1 dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPBody = body;
    NSURLSessionDataTask * dataTask = [_urlSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {


        NSMutableDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        NSArray * arr = dict[@"data"];
        NSArray * array = [arr valueForKey:@"info"];
        for(NSDictionary * dic in array[0])
        {
            ShouYeModel * oneModel = [[ShouYeModel alloc] init];
            [oneModel setValuesForKeysWithDictionary:dic];
            [_dataArray addObject:oneModel];
        }
             [weakSelf.tableView reloadData];
        [self getData2];
    }];
    [dataTask resume];

}
- (void)getData2
{
    __weak typeof(self) weakSelf = self;
    NSURL * URL = [NSURL URLWithString:URL2];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:URL];
    //设置请求方式
    request.HTTPMethod = @"POST";
    //设置请求体
    
    NSData * body = [_str2 dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPBody = body;
    NSURLSessionDataTask * dataTask = [_urlSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSMutableDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        NSArray * array = dict[@"data"];
        for(NSDictionary * dic in array)
        {
            TaoTuModel * m = [[TaoTuModel alloc] init];
            [m setValuesForKeysWithDictionary:dic];
            [_dataArray addObject:m];
        }
        [weakSelf.tableView reloadData];
    }];
    //调用resume方法开始执行下载
    [dataTask resume];
    

}

- (void)createScrollView
{
    _view = [[UIView alloc] init];
    _scrollView = [[UIScrollView alloc] init];
    CGSize size = self.view.frame.size;
    _view.frame = CGRectMake(0, 0, size.width, 250);
    
    _scrollView.frame = CGRectMake(0, 0, size.width, 200);
    _scrollView.contentSize = CGSizeMake(size.width * 3, 200);
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    [_view addSubview:_scrollView];
    self.tableView.tableHeaderView = _view;

}
- (void)createImageView
{
    NSArray * arr = @[[UIImage imageNamed:@"4.png"],
                      [UIImage imageNamed:@"2.png"],
                      [UIImage imageNamed:@"3.png"]
                     ];
    //录播图
    
    CGFloat w = self.view.frame.size.width;
    SDCycleScrollView * cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, w, 200) imagesGroup:arr];
    cycleScrollView.infiniteLoop = YES;
   // cycleScrollView.delegate = self;
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    [self.view addSubview:cycleScrollView];
    
    
    CGSize size = _scrollView.frame.size;
    UILabel * label = [[UILabel alloc] init];
    label.text = @"    灵感之泉";
    label.frame = CGRectMake(0, 200, size.width, 50);
    [_view addSubview:label];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row % 3 == 0)
    {
        ZhuanTiTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
        
        ShouYeModel * model = _dataArray[indexPath.row];
        [cell.imgV sd_setImageWithURL:[NSURL URLWithString:model.filename] placeholderImage:[UIImage imageNamed:@"1.png"]];
        cell.Lab1.text = model.title;
        cell.Lab2.text = model.summary;
        NSString * str = [NSString stringWithFormat:@"%@",model.puttime];
        cell.Lab3.text = str;
        cell.Lab4.text = model.click;
        return cell;
        
    }
    else
    {
        TuKuCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MycellId" forIndexPath:indexPath];
        TitleModel * model = _dataArray[indexPath.row];
        NSString * str = [[_dataArray[indexPath.row] valueForKey:@"info"] valueForKey:@"filename"][0];
        
        
        [cell.imgV sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"1.png"]];
        cell.Lab1.text = model.title;
         NSString * str3 = [[_dataArray[indexPath.row] valueForKey:@"info"] valueForKey:@"likenum"][0];
    
        NSString * str2 = [NSString stringWithFormat:@"%@",str3];
        cell.Lab2.text = str2;
        cell.Lab3.text = model.rows;
        return cell;
        
    }
    

  }
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 280;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row % 3 == 0)
    {
     WebViewController * web = [[WebViewController alloc] init];
     web.url = [_dataArray[indexPath.row] valueForKey:@"article_id"];
     [self.navigationController pushViewController:web animated:YES];
    }
    else
    {
        TaoTuViewController * TVC = [[TaoTuViewController alloc] init];
        TVC.arr = [[_dataArray[indexPath.row] valueForKey:@"info"] valueForKey:@"filename"];
        TVC.str = [[_dataArray[indexPath.row] valueForKey:@"info"] valueForKey:@"likenum"][0];
        TVC.str2 = [_dataArray[indexPath.row] valueForKey:@"title"];
        [self.navigationController pushViewController:TVC animated:YES];
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
