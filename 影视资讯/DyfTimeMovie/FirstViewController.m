//
//  FirstViewController.m
//  DyfTimeMovie
//
//  Created by mac on 15/8/31.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()
{
    UIImageView *_guideProgressImageView;  //进度视图
    UIButton *_enterButton;   //进入主界面按钮
    
}
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建滑动视图
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces = NO;
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(kScreenWidth * 5, 0);
    [self.view addSubview:scrollView];
    
    //创建图片视图
    for (int i = 1; i <= 5; i++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth * (i-1), 0, kScreenWidth, kScreenHeight)];
        NSString *imageString = [NSString stringWithFormat:@"guide%i",i];
        imageView.image = [UIImage imageNamed:imageString];
        [scrollView addSubview:imageView];
    }
    
    //创建进度视图
    _guideProgressImageView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth - 87) / 2, kScreenHeight - 50, 87, 23)];
    _guideProgressImageView.image = [UIImage imageNamed:@"guideProgress1.png"];
    [self.view addSubview:_guideProgressImageView];
    
    //添加按钮
    _enterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _enterButton.frame = CGRectMake((kScreenWidth - 150) / 2, kScreenHeight - 150, 150, 40);
    [_enterButton setTitle:@"马上体验电影世界" forState:UIControlStateNormal];
    _enterButton.hidden = YES;
    [_enterButton addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_enterButton];
    
}

//启动动画开始时 影藏状态栏
- (void)viewWillAppear:(BOOL)animated
{
    UIApplication *app = [UIApplication sharedApplication];
    [app setStatusBarHidden:YES];
}

//启动动结束时 显示状态栏
- (void)viewDidDisappear:(BOOL)animated
{
    UIApplication *app = [UIApplication sharedApplication];
    [app setStatusBarHidden:NO];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //获取视图停止之后的偏移量
    NSInteger offset = scrollView.contentOffset.x;
    //根据偏移量 计算视图所在的页码
    NSInteger index = offset / kScreenWidth;
    //改变图片
    NSString *proStr = [NSString stringWithFormat:@"guideProgress%ld",index + 1];
    _guideProgressImageView.image = [UIImage imageNamed:proStr];
    
    //使进入主界面按钮出现在最后一页
    _enterButton.hidden = !(index == 4);
}

#pragma mark - 进入按钮方法
- (void)buttonAction
{
    //储存一些用户配置
    NSUserDefaults *userDfaults = [NSUserDefaults standardUserDefaults];
    [userDfaults setBool:YES forKey:@"first"];
    
    //读取故事版 获取VIewController
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    //获取故事版中第一个ViewController
    UIViewController *vC = [storyBoard instantiateInitialViewController];
    //获取当前控制器的_view 所显示在哪个窗口上
    self.view.window.rootViewController = vC;
    
    //界面显示动画
    vC.view.transform = CGAffineTransformMakeScale(0.2, 0.2);
    
    [UIView animateWithDuration:0.3 animations:^{
        vC.view.transform = CGAffineTransformIdentity;
    }];

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
