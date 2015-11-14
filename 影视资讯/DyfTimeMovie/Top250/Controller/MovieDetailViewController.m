//
//  MovieDetailViewController.m
//  DyfTimeMovie
//
//  Created by mac on 15/8/27.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "MovieDetailCell.h"
#import "MovieDetal.h"
#import "DetailHeadView.h"


@interface MovieDetailViewController ()
{
    NSMutableArray *_topData;
    NSMutableArray *_commentList;
}

@end

@implementation MovieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"电影详情";
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    //加载数据
    [self loadData];
    
    //加载头视图的xib
    DetailHeadView *head = [[[NSBundle mainBundle] loadNibNamed:@"DetailHeadView" owner:nil options:nil] lastObject];
    
    head.movieDetail = _topData[0];
    
    //设置视频播放的navigationController
    head.navigationController = self.navigationController;
    
    _tableView.tableHeaderView = head;
    
    //表视图的背景颜色
    _tableView.backgroundColor = [UIColor blackColor];
}

#pragma mark - 加载数据
- (void)loadData
{
    //读取头视图数据
    NSDictionary *dic = [MovieJSON readJSONFile:@"movie_detail"];
    _topData = [[NSMutableArray alloc] init];
    
    MovieDetal *movieD = [[MovieDetal alloc] initContentWithDic:dic];
    [_topData addObject:movieD];
    
    //读取评论相关数据
    NSDictionary *dictionary = [MovieJSON readJSONFile:@"movie_comment"];
    NSArray *dataCom = dictionary[@"list"];
    
    _commentList = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in dataCom) {
        MovieDetal *movieComment = [[MovieDetal alloc] initContentWithDic:dic];
        [_commentList addObject:movieComment];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _commentList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MovieDetal *movieDetail = _commentList[indexPath.row];
    MovieDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentCell"];
    
    cell.movieDetail = movieDetail;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //计算字符label的高度
    //拿到当前的评论对象
    MovieDetal *comment = _commentList[indexPath.row];
    if (comment.isShow)
    {
        //评论的内容
        NSString *string = comment.content;
        //根据字符串的长度，计算label 的大小
        CGSize maxSize = CGSizeMake(kScreenWidth - 80, CGFLOAT_MAX);
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:17]};
        CGRect rect = [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        return rect.size.height + 50;
    }
    else
    {
        return 60;
    }
}

#pragma mark - 单元格的选中事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MovieDetal *comment = _commentList[indexPath.row];
    comment.isShow = !comment.isShow;
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
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
