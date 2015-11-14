//
//  NewsCell.m
//  DyfTimeMovie
//
//  Created by mac on 15/8/22.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "NewsCell.h"
#import "News.h"
#import "UIImageView+WebCache.h"

@implementation NewsCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setNews:(News *)news
{
    _news = news;
    
    _titleLabel.text = _news.title;
    _summaryLabel.text = _news.summary;
    
    //从网络读取图片
    NSString *urlString = _news.image;
    NSURL *url = [NSURL URLWithString:urlString];
    [_newsImage sd_setImageWithURL:url];
    
    //新闻的类型，0普通 1图片 2视屏
    NSInteger index = [news.type integerValue];
    if (index == 1)
    {
        _summaryLabel.transform = CGAffineTransformIdentity;
        _typeImage.hidden = NO;
        _typeImage.image = [UIImage imageNamed:@"sctpxw"];
    }
    else if (index == 2)
    {
        _summaryLabel.transform = CGAffineTransformIdentity;
        _typeImage.hidden = NO;
        _typeImage.image = [UIImage imageNamed:@"scspxw"];
    }
    else
    {
        _typeImage.hidden = YES;
        _summaryLabel.transform = CGAffineTransformMakeTranslation(-_typeImage.frame.size.width, 0);
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
