//
//  BaseViewController.m
//  DyfTimeMovie
//
//  Created by mac on 15/8/19.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "TabBarController.h"

@interface BaseViewController ()
{
    UILabel *_titlelabel; //导航栏标题
    BOOL _isHiddenTabBar; //是否影藏标签栏
}

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置标题label
    _titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 125, 44)];
    _titlelabel.text = @"title";
    _titlelabel.textAlignment = NSTextAlignmentCenter;
    _titlelabel.textColor = [UIColor whiteColor];
    _titlelabel.font = [UIFont boldSystemFontOfSize:20];
    self.navigationItem.titleView = _titlelabel;
    
    //设置背景
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main@2x"]];
    
}

- (void)setTitle:(NSString *)title{
    
    [super setTitle:title];
    _titlelabel.text = title;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    if (_isHiddenTabBar)
    {
        //影藏标签栏
        [UIView animateWithDuration:.35 animations:^{
            
            TabBarController *tab = (TabBarController *)self.tabBarController;
            [tab setTabBarHidden:YES];
        }];
    
    }
    else
    {
        //显示标签栏
        [UIView animateWithDuration:.35 animations:^{
            
            TabBarController *tab = (TabBarController *)self.tabBarController;
            [tab setTabBarHidden:NO];
        }];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    //显示标签栏
    [UIView animateWithDuration:.35 animations:^{
        
        TabBarController *tab = (TabBarController *)self.tabBarController;
        [tab setTabBarHidden:NO];
    }];
}

- (void)setHidesBottomBarWhenPushed:(BOOL)hidesBottomBarWhenPushed
{
    _isHiddenTabBar = hidesBottomBarWhenPushed;
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
