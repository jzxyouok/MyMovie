//
//  TabBarController.m
//  DyfTimeMovie
//
//  Created by mac on 15/8/19.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "TabBarController.h"
#import "TabBarButton.h"

@interface TabBarController ()
{
    UIView *_tabBarView;  //创建TabBar
    UIImageView *_selectedImageView; //选中视图
}

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //自定义标签栏
    [self creatTabBar];
    
}

//标签栏影藏
- (void)setTabBarHidden:(BOOL)isHidden
{
    _tabBarView.hidden = isHidden;
}

#pragma mark - 创建TabBar
- (void)creatTabBar{
    
    //影藏系统自带的标签栏
    self.tabBar.hidden = YES;

    //创建自定义标签栏
    _tabBarView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 49, kScreenWidth, 49)];
    _tabBarView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tab_bg_all"]];
    [self.view addSubview:_tabBarView];
    
    //创建按钮
    //1,计算按钮宽
    CGFloat buttonWidth = kScreenWidth / self.viewControllers.count;
    
    //设置选中图片
    _selectedImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, buttonWidth, 49)];
    _selectedImageView.image = [UIImage imageNamed:@"selectTabbar_bg_all1"];
    [_tabBarView addSubview:_selectedImageView];
    
    NSArray *titles = @[@"电影",
                        @"新闻",
                        @"Top",
                        @"影院",
                        @"更多"];
    NSArray *imageName = @[@"movie_home",
                           @"msg_new",
                           @"start_top250@2x",
                           @"icon_cinema",
                           @"more_setting"];
    
    for (int i = 0; i < self.viewControllers.count; i ++)
    {
        TabBarButton *button = [[TabBarButton alloc] initWithTitle:titles[i] imageName:imageName[i] frmae:CGRectMake(i * buttonWidth, 0, buttonWidth, 49)];
        
        button.tag = i + 100;
        
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [_tabBarView addSubview:button];
    
    }
}

#pragma mark - TabBarButton方法
- (void)buttonAction:(TabBarButton *)sender{
    
    NSInteger index = sender.tag - 100;
    //切换到对应的子控制器
    self.selectedIndex = index;
    
    //设置滑动选中图片视图
    [UIView animateWithDuration:.2 animations:^{
        
        _selectedImageView.center = sender.center;
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
