//
//  PhotosViewController.m
//  DyfTimeMovie
//
//  Created by mac on 15/8/23.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "PhotosViewController.h"
#import "BigImageViewController.h"

@interface PhotosViewController ()
{
    NSMutableArray *_photosData;  //图片数据
}

@end

@implementation PhotosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //加载数据
    [self loadData];
    
    //创建UICollectionView
    [self creatCollectionView];
    
    self.title = @"图片新闻";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

#pragma mark - 加载数据
- (void)loadData {

    NSArray *array = [MovieJSON readJSONFile:@"image_list"];
    
    _photosData = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in array) {
        
        [_photosData addObject:dic[@"image"]];
    }
}

#pragma mark - 创建UICollecyionView
- (void)creatCollectionView {
    
    //创建一个布局对象
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //设置布局规则
    //水平最小间隙
    flowLayout.minimumInteritemSpacing = 5;
    //竖直最小间隙
    flowLayout.minimumLineSpacing = 5;
    //单元格大小
    CGFloat itemWidth = (kScreenWidth - 5*5) / 4;
    flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth);
    //滑动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //设置四周间隙
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);

    //使用布局对象来创建UICollectionView
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    [self.view addSubview:collection];
    
    //设置背景颜色
    collection.backgroundColor = [UIColor darkGrayColor];
    
    collection.dataSource = self;
    collection.delegate = self;
    
    //使用一个类来注册单元格
    [collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _photosData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    //从网络读取图片
    NSURL *url = [NSURL URLWithString:_photosData[indexPath.item]];
    UIImageView *photoView = [[UIImageView alloc] init];
    [photoView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"loading"]];
    cell.backgroundView = photoView;
    
    //将单元格设置圆角
    cell.layer.cornerRadius = 10;
    cell.layer.masksToBounds = YES;
    
    return cell;
}

#pragma mark -单元格的选中事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    BigImageViewController *big = [[BigImageViewController alloc] init];
    
    //将图片数据传送给下一个控制器
    big.imageData = _photosData;
    
    big.hidesBottomBarWhenPushed = YES;
    
    //记录本次点击选中的单元格索引
    big.indexPath = indexPath;
    
    [self.navigationController pushViewController:big animated:YES];
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
