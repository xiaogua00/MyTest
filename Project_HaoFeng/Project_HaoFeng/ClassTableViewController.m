//
//  ClassTableViewController.m
//  Project_HaoFeng
//
//  Created by qianfeng001 on 16/1/20.
//  Copyright © 2016年 郝锋. All rights reserved.
//

#import "ClassTableViewController.h"
#import "ClassModel.h"
#import "MuluCell.h"
#import "UIImageView+WebCache.h"
#import "WebClassViewController.h"
#import "UIScrollView+MJRefresh.h"
#define PAPAMETER (@"action=list&perPage=60&page=1&btype=1&stype=2&model=yibentong&version=2.5")
#define URL10 (@"http://mobileapi.to8to.com/smallapp.php")
@interface ClassTableViewController ()<NSURLSessionDelegate>
{
    //声明一个会话对象
    NSURLSession *_urlSession;
    NSMutableArray *_dataArray;
    NSString *_url;
}
@property (nonatomic)NSInteger i;
@end

@implementation ClassTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [[NSMutableArray alloc] init];
    _url = [NSString stringWithFormat:@"action=list&perPage=20&page=1&btype=%ld&stype=2&model=yibentong&version=2.5",self.num];
      NSURLSessionConfiguration * sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    //实例化session
    _urlSession = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:nil];
    
    //注册自定义cell
    [self.tableView registerNib:[UINib nibWithNibName:@"MuluCell" bundle:nil] forCellReuseIdentifier:@"cellId"];
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
    _i = 20;
    _url = [NSString stringWithFormat:@"action=list&perPage=%ld&page=1&btype=%ld&stype=2&model=yibentong&version=2.5",_i,self.num];
    
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
    
    _url = [NSString stringWithFormat:@"action=list&perPage=%ld&page=1&btype=%ld&stype=2&model=yibentong&version=2.5",_i,self.num];
    _i +=10;
    [self getData];
    //刷新界面
    [self.tableView reloadData];
    //结束界面刷新状态
    [self.tableView footerEndRefreshing];
}

- (void)getData
{
    NSURL * URL = [NSURL URLWithString:URL10];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:URL];
    //设置请求方式
    request.HTTPMethod = @"POST";
    //设置请求体
    NSData * body = [_url dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPBody = body;
    __weak typeof(self) weakSelf = self;
    NSURLSessionDataTask * dataTask = [_urlSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSError * error1 = nil;
        NSMutableDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
             if(!error1)
        {
            NSArray * array = dict[@"data"];
            
            for(NSDictionary * dic in array)
            {
                ClassModel * oneModel = [[ClassModel alloc] init];
                [oneModel setValuesForKeysWithDictionary:dic];
                [_dataArray addObject:oneModel];
            }
            
            [weakSelf.tableView reloadData];
        }
        
    }];
    //调用resume方法开始执行下载
    [dataTask resume];
    
    
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
    return _dataArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MuluCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    
    ClassModel * model = _dataArray[indexPath.row];
    [cell.ImgV sd_setImageWithURL:model.imgurl placeholderImage:[UIImage imageNamed:@"1.png"]];
    cell.Lab1.text = model.puttime;
    cell.Lab2.text = model.title;
    NSString * str = [NSString stringWithFormat:@"%@",model.view_nums];
    cell.Lab3.text = str;
    cell.Lab4.text = model.collection_num;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 122;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WebClassViewController * web = [[WebClassViewController alloc] init];
    web.url = [_dataArray[indexPath.row] valueForKey:@"kid"];
    [self.navigationController pushViewController:web animated:YES];
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
