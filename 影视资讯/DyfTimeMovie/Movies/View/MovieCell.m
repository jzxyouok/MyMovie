//
//  MovieCell.m
//  DyfTimeMovie
//
//  Created by mac on 15/8/21.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "MovieCell.h"
#import "Movie.h"
#import "StarView.h"

@interface MovieCell ()

@property (weak, nonatomic) IBOutlet UIImageView *movieImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet StarView *starView;


@end

@implementation MovieCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setMovie:(Movie *)movie
{
    _movie = movie;
    
    _titleLabel.text = _movie.titleC;
    _yearLabel.text = [NSString stringWithFormat:@"上映年份:%@",_movie.year];
    _ratingLabel.text = [NSString stringWithFormat:@"%.1f",_movie.rating];
   
    //从网络读取图片
    NSString *urlString = _movie.images[MovieImageLarge];
    NSURL *url = [NSURL URLWithString:urlString];
    [_movieImageView sd_setImageWithURL:url];
    
    _starView.rating = _movie.rating;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
