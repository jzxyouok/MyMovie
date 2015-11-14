//
//  MoviesViewController.m
//  DyfTimeMovie
//
//  Created by mac on 15/8/19.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "MoviesViewController.h"
#import "Movie.h"
#import "MovieCell.h"
#import "PostCollectionView.h"
#import "HeadCollectionView.h"

@interface MoviesViewController ()
{
    UIButton *_rightButton; //导航栏右侧按钮
    
    //中间视图
    UITableView *_listView; //列表视图
    UIView *_postView; //翻转视图
    
    NSMutableArray *_movieData; //电影数据
    
    UIView *_headView; //顶部视图
    UIButton *_upDownButton; //下拉按钮
    UIView *_maskView; //遮罩视图
    
    //海报视图
    PostCollectionView *_postCollectionView;
    //顶部小海报视图
    HeadCollectionView *_headCollectionView;
    
}

@end

@implementation MoviesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置标题
    self.title = @"北美榜";
    
    //加载数据
    [self loadData];
    
    //创建导航栏右侧按钮
    [self creatRightButton];
    
    //创建View
    [self creatViews];
    
    //创建顶部视图
    [self creatTopHeadView];
    
    //addKVO
    [self addKVO];
}

#pragma mark - 加载数据
- (void)loadData {
    
    //3,文件解析
    NSDictionary *dic = [MovieJSON readJSONFile:@"us_box"];

    //4,数据处理和储存
    NSArray *subjects = dic[@"subjects"];
    
    _movieData = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dictionary in subjects) {
        
        Movie *movie = [Movie movieWithContentsOfDictionary:dictionary[@"subject"]];
        [_movieData addObject:movie];
    }
    
}

#pragma mark - creatView
//创建中间视图
- (void)creatViews {
    
    //创建列表视图
    _listView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _listView.backgroundColor = [UIColor clearColor];
    _listView.showsVerticalScrollIndicator = NO;
    
    _listView.dataSource = self;
    _listView.delegate = self;
    
    [self.view addSubview:_listView];
    
    //创建翻转视图
    _postView = [[UIView alloc] initWithFrame:self.view.bounds];
    _postView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_postView];
    _postView.hidden = YES;
    
    //将_postCollectionView加到_postView上
    _postCollectionView = [[PostCollectionView alloc] initWithFrame:CGRectMake(0, 120, kScreenWidth, 380)];
    _postCollectionView.backgroundColor = [UIColor clearColor];
    
    //将数据传到_postCollectionView
    _postCollectionView.movieData = _movieData;
    [_postView addSubview:_postCollectionView];
}

//创建顶部视图
- (void)creatTopHeadView
{
    
    //创建遮罩视图
    _maskView = [[UIView alloc] initWithFrame:_postView.bounds];
    _maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    _maskView.hidden = YES;
    [_postView addSubview:_maskView];
    
    //给遮罩视图 添加单击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headViewMoveUp)];
    [_maskView addGestureRecognizer:tap];
    
    //向下滑动手势
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(headViewMoveDown)];
    swipe.direction = UISwipeGestureRecognizerDirectionDown;
    [_postView addGestureRecognizer:swipe];
    
    //向上滑动手势
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(headViewMoveUp)];
    swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    [_maskView addGestureRecognizer:swipeUp];
    
    //创建顶部视图
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0,64 - 100, kScreenWidth, 130)];
    _headView.backgroundColor = [UIColor clearColor];
    [_postView addSubview:_headView];
    
    //读取图片并且拉伸
    UIImage *indexBG = [UIImage imageNamed:@"indexBG_home"];
    indexBG = [indexBG stretchableImageWithLeftCapWidth:0 topCapHeight:5];
    //创建一个背景视图
    UIImageView *BGImageView = [[UIImageView alloc] initWithFrame:_headView.bounds];
    BGImageView.image = indexBG;
    [_headView addSubview:BGImageView];
    
#pragma mark - 创建HeadCollectionView
    _headCollectionView = [[HeadCollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    _headCollectionView.movieData = _movieData;
    _headCollectionView.backgroundColor = [UIColor clearColor];
    _headCollectionView.movieData = _movieData;
    [_headView addSubview:_headCollectionView];
    
#pragma mark - 创建左右灯
    //创建左右灯
    UIImage *leftImage = [UIImage imageNamed:@"light"];
    leftImage = [leftImage stretchableImageWithLeftCapWidth:10 topCapHeight:20];
    UIImageView *left = [[UIImageView alloc] initWithFrame:CGRectMake(20, 3, 124, 130)];
    left.image = leftImage;
    [_headView addSubview:left];
    
    UIImage *rightImage = [UIImage imageNamed:@"light"];
    rightImage = [rightImage stretchableImageWithLeftCapWidth:10 topCapHeight:20];
    UIImageView *right = [[UIImageView alloc] initWithFrame:CGRectMake(170, 3, 124, 130)];
    right.image = rightImage;
    [_headView addSubview:right];
    
    //创建下拉按钮
    _upDownButton = [UIButton buttonWithType:UIButtonTypeCustom ];
    _upDownButton.frame = CGRectMake(0, 0, 30, 20);
    _upDownButton.center = CGPointMake(kScreenWidth / 2 + 3, 120);
    [_upDownButton setImage:[UIImage imageNamed:@"down_home"] forState:UIControlStateNormal];
    [_upDownButton setImage:[UIImage imageNamed:@"up_home"] forState:UIControlStateSelected];
    [_headView addSubview:_upDownButton];
    
    [_upDownButton addTarget:self action:@selector(upDownButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 下拉按钮的方法
- (void)upDownButtonAction:(UIButton *)button
{
    if (button.selected) {
        
        [self headViewMoveUp];
    }
    else
    {
        [self headViewMoveDown];
    }
}

#pragma mark - 头部视图上下移动控制方法
//上移
- (void)headViewMoveUp
{
    [UIView animateWithDuration:0.4 animations:^{
        
        _headView.top = -36;
        _upDownButton.selected = NO;
        _maskView.hidden = YES;
    }];
}
//下移
- (void)headViewMoveDown
{
    [UIView animateWithDuration:0.4 animations:^{
        
        _headView.top = 64;
        _upDownButton.selected = YES;
        _maskView.hidden = NO;
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _movieData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MovieCell" owner:nil options:nil] lastObject];
        
    }
    cell.movie = _movieData[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

#pragma mark - 创建导航栏右侧按钮
- (void)creatRightButton {
    //创建按钮
    _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightButton.frame = CGRectMake(0, 0, 49, 25);
    
    //设置背景和标题
    [_rightButton setBackgroundImage:[UIImage imageNamed:@"exchange_bg_home@2x"] forState:UIControlStateNormal];
    [_rightButton setImage:[UIImage imageNamed:@"list_home"] forState:UIControlStateNormal];
    [_rightButton setImage:[UIImage imageNamed:@"poster_home"] forState:UIControlStateSelected];
    
    //给按钮添加方法
    [_rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    //转换成UIBarButton类型
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:_rightButton];
    //添加到导航栏上
    self.navigationItem.rightBarButtonItem = right;
    
}

#pragma mark - 导航栏右侧按钮方法
- (void)rightButtonAction:(UIButton *)button {
    
    //翻转动画
    UIViewAnimationOptions option = button.selected?UIViewAnimationOptionTransitionFlipFromLeft : UIViewAnimationOptionTransitionFlipFromRight;
    
    //按钮的翻转
    [self filpView:_rightButton options:option];
    _rightButton.selected = !_rightButton.selected;
    
    //视图的翻转
    [self filpView:self.view options:option];
    _postView.hidden = !_postView.hidden;
    _listView.hidden = !_listView.hidden;
}

#pragma mark - 翻转视图
- (void)filpView:(UIView *)view options:(UIViewAnimationOptions)options {
    
    [UIView transitionWithView:view duration:0.35 options:options animations:^{
        
    } completion:nil];
}

#pragma mark - addKVO
- (void)addKVO
{
    [_headCollectionView addObserver:self forKeyPath:@"index" options:NSKeyValueObservingOptionNew context:nil];
    
    [_postCollectionView addObserver:self forKeyPath:@"index" options:NSKeyValueObservingOptionNew context:nil];
}

#pragma mark - 观察者方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    //获取变化后的index值
    NSNumber *itemNumber = change[@"new"];
    NSInteger itemIndex = [itemNumber integerValue];
    
    //创建indexPath
    NSIndexPath *indexPath  = [NSIndexPath indexPathForItem:itemIndex inSection:0];
    
    //判断被观察对象是哪个collectionView
    if (object == _postCollectionView && indexPath.item != _headCollectionView.index)
    {
        //滑动小的
        [_headCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        _headCollectionView.index = indexPath.item;
    }
    else if(object == _headCollectionView && indexPath.item != _postCollectionView.index)
    {
        //滑动大的
        [_postCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        _postCollectionView.index = indexPath.item;
    }
}

//移除通知
- (void)dealloc
{
    [_postCollectionView removeObserver:self forKeyPath:@"index"];
    [_headCollectionView removeObserver:self forKeyPath:@"index"];
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
