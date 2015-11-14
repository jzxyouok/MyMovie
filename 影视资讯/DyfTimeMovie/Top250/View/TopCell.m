//
//  TopCell.m
//  DyfTimeMovie
//
//  Created by mac on 15/8/23.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "TopCell.h"
#import "StarView.h"
#import "Movie.h"

@interface TopCell ()

@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;

@property (weak, nonatomic) IBOutlet StarView *starView;


@end

@implementation TopCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setMovie:(Movie *)movie
{
    _movie = movie;
    
    _titleLabel.text = _movie.titleC;
    _ratingLabel.text = [NSString stringWithFormat:@"%.1f",_movie.rating];
    
    //从网络获取图片
    NSString *urlString = _movie.images[@"large"];
    NSURL *url = [NSURL URLWithString:urlString];
    [_topImageView sd_setImageWithURL:url];
    
    _starView.rating = _movie.rating;
}

@end
