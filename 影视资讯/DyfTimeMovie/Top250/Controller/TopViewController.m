//
//  TopViewController.m
//  DyfTimeMovie
//
//  Created by mac on 15/8/19.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "TopViewController.h"
#import "Movie.h"
#import "TopCell.h"
#import "MovieDetailViewController.h"

@interface TopViewController ()
{
    NSMutableArray *_topData;
}

@end

@implementation TopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Top 250";
    
    //加载数据
    [self loadData];
    
    //创建集合视图
    [self creatView];
}
#pragma mark - 加载数据
- (void)loadData {
    
    NSDictionary *dic = [MovieJSON readJSONFile:@"top250"];
    NSArray *subjects = dic[@"subjects"];
    
    _topData = [[NSMutableArray alloc] init];
    for (NSDictionary *dictionary in subjects)
    {
        Movie *movie = [Movie movieWithContentsOfDictionary:dictionary];
        [_topData addObject:movie];
    }
    
}

#pragma mark - 创建UICollectionView
- (void)creatView {
    //创建一个布局对象
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //水平最小间隙
    flowLayout.minimumInteritemSpacing = 1;
    //竖直最小间隙
    flowLayout.minimumLineSpacing = 1;
    //单元格大小
    flowLayout.itemSize = CGSizeMake(104, 148);
    //滑动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //设置四周间隙
    flowLayout.sectionInset = UIEdgeInsetsMake(1, 1, 1, 1);
    
    //使用布局对象来创建UICollectionView
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:flowLayout];
    
    collection.dataSource = self;
    collection.delegate = self;
    
    [self.view addSubview:collection];
    
    //注册单元格
    UINib *nib = [UINib nibWithNibName:@"TopCell" bundle:[NSBundle mainBundle]];
    [collection registerNib:nib forCellWithReuseIdentifier:@"Cell"];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _topData.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TopCell *cell = (TopCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"Cell" owner:nil options:nil] lastObject];
    }
    
    cell.movie = _topData[indexPath.item];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //获取故事版对象
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    MovieDetailViewController *movieDetail = [storyBoard instantiateViewControllerWithIdentifier:@"MovieDetail"];
    movieDetail.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:movieDetail animated:YES];
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
