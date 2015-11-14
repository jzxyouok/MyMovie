//
//  MovieDetailCell.m
//  DyfTimeMovie
//
//  Created by mac on 15/8/27.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "MovieDetailCell.h"

@implementation MovieDetailCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setMovieDetail:(MovieDetal *)movieDetail
{
    _movieDetail = movieDetail;
    
    _userNameLabel.text = _movieDetail.nickname;
    _commentLabel.text = _movieDetail.content;
    _ratingLabel.text = _movieDetail.rating;
    
    NSURL *urlCom = [NSURL URLWithString:_movieDetail.userImage];
    [_userImageView sd_setImageWithURL:urlCom];
    
    //将用户头像设置成带圆角的
    _userImageView.layer.cornerRadius = 10;
    _userImageView.layer.masksToBounds = YES;
    
    //将评论背景设置成带圆角的
    _commentBgView.layer.cornerRadius = 10;
    _commentBgView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
