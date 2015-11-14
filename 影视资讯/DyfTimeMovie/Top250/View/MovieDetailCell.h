//
//  MovieDetailCell.h
//  DyfTimeMovie
//
//  Created by mac on 15/8/27.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieDetal.h"

@interface MovieDetailCell : UITableViewCell

@property (nonatomic,strong) MovieDetal *movieDetail;

//用户头像
@property (strong, nonatomic) IBOutlet UIImageView *userImageView;
//用户名
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
//评分
@property (strong, nonatomic) IBOutlet UILabel *ratingLabel;
//评论的内容
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@property (strong, nonatomic) IBOutlet UIView *commentBgView;



@end
