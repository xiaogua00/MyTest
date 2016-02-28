//
//  ClassViewController.m
//  练习——一本通
//
//  Created by qianfeng001 on 16/1/18.
//  Copyright © 2016年 郝锋. All rights reserved.
//

#import "ClassViewController.h"
#import "ClassCollectionViewCell.h"
#import "ClassTableViewController.h"
@interface ClassViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSArray *_dataArray;
}
@end

@implementation ClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
      //读取文件
    NSString * ClassInfoPath = [[NSBundle mainBundle] pathForResource:@"Class" ofType:@"plist"];
    NSArray * array = [NSArray arrayWithContentsOfFile:ClassInfoPath];
    //实例化数据源
    _dataArray = [[NSArray alloc] initWithArray:array];
     }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark —— collection 代理方法——
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    ClassCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ClassCellId" forIndexPath:indexPath];
    //获取数据
    NSDictionary * dic = _dataArray[indexPath.row];
  
    //更新显示
    UIImage * image = [[UIImage imageNamed:dic[@"img"]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
       [cell.Button setBackgroundImage:image forState:0];
    //设置tag值，区分点击事件
    cell.Button.tag =indexPath.row + 1;
    cell.Label.text = dic[@"title"];
    
    return cell;
}
- (IBAction)click:(UIButton *)sender
{
    ClassTableViewController * MTC = [[ClassTableViewController alloc] init];
    MTC.num = sender.tag;
    MTC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:MTC animated:YES];
   
}

//#pragma mark - Navigation
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
