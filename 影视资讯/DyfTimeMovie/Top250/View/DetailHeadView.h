//
//  DetailView.h
//  DyfTimeMovie
//
//  Created by mac on 15/8/28.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieDetal.h"

@interface DetailHeadView : UIView

//电影图片视图
@property (strong, nonatomic) IBOutlet UIImageView *movieImageView;
//电影中文名
@property (strong, nonatomic) IBOutlet UILabel *titleCnLabel;
//主演
@property (strong, nonatomic) IBOutlet UILabel *mainActorLabel;
//导演
@property (strong, nonatomic) IBOutlet UILabel *diretorLabel;
//类型
@property (strong, nonatomic) IBOutlet UILabel *typeLabel;
//上映年份
@property (strong, nonatomic) IBOutlet UILabel *yearLabel;
//图片简介


@property (strong, nonatomic) IBOutlet UIScrollView *topScrollView;

@property (nonatomic,strong) MovieDetal *movieDetail;


@property (nonatomic,weak) UINavigationController *navigationController;
- (IBAction)imageButtonAction:(id)sender;


@end
