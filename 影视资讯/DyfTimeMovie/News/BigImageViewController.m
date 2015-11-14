//
//  BigImageViewController.m
//  DyfTimeMovie
//
//  Created by mac on 15/8/25.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "BigImageViewController.h"
#import "BigImageCell.h"

@interface BigImageViewController ()
{
    UICollectionView *_imageCollectionView;  //集合视图
    BOOL _isHide;  //是否影藏导航栏
}

@end

@implementation BigImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"图片浏览";
 
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    //创建view
    [self creatView];
    
    //点击进入对应的图片
    [_imageCollectionView scrollToItemAtIndexPath:_indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
    //接收通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showOrDisappear:) name:@"singleTap" object:nil];

}

//通知调用的方法
- (void)showOrDisappear:(NSNotification *)notification
{
    _isHide = !_isHide;
    //影藏导航栏
    [self.navigationController setNavigationBarHidden:_isHide animated:YES];
    
    //影藏状态栏
    UIApplication *app = [UIApplication sharedApplication];
    [app setStatusBarHidden:_isHide];
}

#pragma mark - 创建View
- (void)creatView
{
    //创建布局对象
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(kScreenWidth, kScreenHeight - 64);
    layout.minimumInteritemSpacing = 10;
    //设置滚动方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //设置四周间隙
    layout.sectionInset = UIEdgeInsetsMake(-15, 0, 0, 0);
    
    _imageCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth + 10, kScreenHeight + 64) collectionViewLayout:layout];
    
    _imageCollectionView.delegate = self;
    _imageCollectionView.dataSource = self;
    
    _imageCollectionView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_imageCollectionView];
    
    
    //影藏滑块
    _imageCollectionView.showsHorizontalScrollIndicator = NO;
    //设置分页效果
    _imageCollectionView.pagingEnabled = YES;
    //注册单元格
    [_imageCollectionView registerClass:[BigImageCell class] forCellWithReuseIdentifier:@"BigImageCell"];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _imageData.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BigImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BigImageCell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor blackColor];
    
    cell.imageURL = _imageData[indexPath.item];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    //获取单元格，强制类型转换
    BigImageCell *big = (BigImageCell *)cell;
    //还原
    [big backImageZoomingScale];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
