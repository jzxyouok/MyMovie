//
//  PostCell.m
//  DyfTimeMovie
//
//  Created by mac on 15/8/26.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "PostCell.h"
#import "StarView.h"

@interface PostCell ()

@property (strong, nonatomic) IBOutlet UIImageView *bigImageView;
@property (strong, nonatomic) IBOutlet UIImageView *smallImageView;
@property (strong, nonatomic) IBOutlet StarView *starView;
@property (strong, nonatomic) IBOutlet UILabel *titleCnLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleEngLabel;
@property (strong, nonatomic) IBOutlet UILabel *yearLabel;

@end

@implementation PostCell

- (void)setMovie:(Movie *)movie
{
    _movie = movie;
    NSURL *url = [NSURL URLWithString:_movie.images[MovieImageLarge]];
    [_bigImageView sd_setImageWithURL:url];
    [_smallImageView sd_setImageWithURL:url];
    
    _titleCnLabel.text = [NSString stringWithFormat:@"中文名:%@",_movie.titleC];
    _titleEngLabel.text = [NSString stringWithFormat:@"原名:%@",_movie.titleE];
    _yearLabel.text = [NSString stringWithFormat:@"上映年份:%@",_movie.year];
    
    _starView.rating = _movie.rating;
    
}

//翻转单元格
- (void)filpCell
{
    [UIView transitionWithView:self duration:0.3 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        _bigImageView.hidden = !_bigImageView.hidden;
    } completion:nil];
}
//恢复单元格
- (void)backCell
{
    _bigImageView.hidden = NO;
}

- (void)awakeFromNib {
    // Initialization code
}

@end
