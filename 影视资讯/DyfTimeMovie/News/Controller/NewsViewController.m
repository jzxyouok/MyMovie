//
//  NewsViewController.m
//  DyfTimeMovie
//
//  Created by mac on 15/8/19.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "NewsViewController.h"
#import "News.h"
#import "NewsCell.h"
#import "PhotosViewController.h"
#import "WebViewController.h"

@interface NewsViewController ()
{
    NSMutableArray *_newsData;  //新闻数据
    UITableView *_newsTableView; //新闻表视图
    UIImageView *_imageView;  //新闻视图的第一个单元格视图
}

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"新闻";

    //读取数据
    [self loadData];
}

#pragma mark - newsTableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _newsData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    News *news = _newsData[indexPath.row];
    
    if (indexPath.row == 0) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TopViewCell"];
        _imageView = (UIImageView *)[cell.contentView viewWithTag:100];

        UILabel *label = (UILabel *)[cell.contentView viewWithTag:101];
        label.text = news.title;
        [_imageView sd_setImageWithURL:[NSURL URLWithString:news.image]];
        
        return cell;
        
    }
    else
    {
        NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCell"];
        cell.news = news;
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return 200;
    }
    else
    {
        return 60;
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    News *news = _newsData[indexPath.row];
    NSInteger index = [news.type integerValue];
    if (index == 1)
    {
        PhotosViewController *photo = [[PhotosViewController alloc] init];
        photo.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:photo animated:YES];
    }
    else if(index == 0)
    {
        [self.navigationController pushViewController:[[WebViewController alloc] init] animated:YES];
    }
}

#pragma mark - 下拉缩放第一个单元格图片
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //获取y方向的偏移量
    CGFloat offsety = scrollView.contentOffset.y;
    
    if (offsety < 0) {
        //缩放前图片的高度
        CGFloat oldImageHeight = 200;
        //缩放后图片的高度
        CGFloat newImageHeight = 200 - offsety;
        //设置缩放比例
        CGFloat scale = newImageHeight / oldImageHeight;
        //设置图片的拉伸模式
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        //拉伸图片
        CGAffineTransform transform = CGAffineTransformMakeScale(scale, scale);
        _imageView.transform = transform;
        //设置图片的拉伸中心
        _imageView.center = CGPointMake(kScreenWidth / 2, 0);
        //图片顶部与导航栏的距离
        _imageView.top = offsety;
        
    }
    else
    {
        _imageView.transform = CGAffineTransformIdentity;
    }
}

#pragma mark - 读取数据
- (void)loadData{
    
    NSArray *array = [MovieJSON readJSONFile:@"news_list"];
    
    _newsData = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in array) {
        
        News *news = [[News alloc] initContentWithDic:dic];
        [_newsData addObject:news];
    }
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
