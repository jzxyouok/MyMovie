//
//  DetailView.m
//  DyfTimeMovie
//
//  Created by mac on 15/8/28.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "DetailHeadView.h"
#import <MediaPlayer/MediaPlayer.h>
#import "UIButton+WebCache.h"

@implementation DetailHeadView

- (void) setMovieDetail:(MovieDetal *)movieDetail
{
    _movieDetail =movieDetail;
    
    
    NSURL *url = [NSURL URLWithString:_movieDetail.image];
    [_movieImageView sd_setImageWithURL:url];
    
    _titleCnLabel.text = _movieDetail.titleCn;
    NSString *directorStr = [_movieDetail.directors componentsJoinedByString:@""];
    _diretorLabel.text = [NSString stringWithFormat:@"导演：%@",directorStr];

    NSString *strAD = _movieDetail.releaseD[@"location"];
    NSString *strY = _movieDetail.releaseD[@"date"];
    _yearLabel.text = [NSString stringWithFormat:@"%@ %@",strAD,strY];

    NSString *actorStr = [_movieDetail.actors componentsJoinedByString:@","];
    _mainActorLabel.text = [NSString stringWithFormat:@"主演：%@,",actorStr];

    NSString *typeStr = [_movieDetail.type componentsJoinedByString:@","];
    _typeLabel.text = [NSString stringWithFormat:@"类型：%@",typeStr];
    
    //设置滑动视图的边角
    _topScrollView.layer.cornerRadius = 5;
    _topScrollView.layer.masksToBounds = YES;
    _topScrollView.layer.borderColor = [UIColor grayColor].CGColor;
    _topScrollView.layer.borderWidth = 2;
    
    //滑动视图的内容尺寸
    _topScrollView.contentSize = CGSizeMake(70 * _movieDetail.images.count + 8 * _movieDetail.images.count, 84);
    //加载滑动视图上的图片视图
    UIImageView *skimImageView;
    for (int i = 0; i < [_movieDetail.images count]; i ++)
    {
        skimImageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * 70 + (i + 1) * 8, 7, 70, 70)];
        
        skimImageView.layer.cornerRadius = 5;
        skimImageView.layer.masksToBounds = YES;

        NSURL *url = [NSURL URLWithString:_movieDetail.images[i]];
        [skimImageView sd_setImageWithURL:url];
        [_topScrollView addSubview:skimImageView];
    }
}

- (IBAction)imageButtonAction:(id)sender
{
    MPMoviePlayerViewController *moviePlayer = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:@"http://vf1.mtime.cn/Video/2012/06/21/mp4/120621104820876931.mp4"]];
    [self.navigationController pushViewController:moviePlayer animated:YES];
}
@end
