//
//  StarView.m
//  DyfTimeMovie
//
//  Created by mac on 15/8/22.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "StarView.h"
#import "UIViewExt.h"

@interface StarView ()
{
    UIView *_yellowView;   //黄色星星视图
    UIView *_grayView;    //灰色星星视图
}

@end

@implementation StarView

//重写init
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createStarView];
    }
    return self;
}

//重新setRating
- (void)setRating:(CGFloat)rating
{
    _rating = rating;
    if (_rating >= 0 &&_rating <= 10) {
        _yellowView.width = _grayView.width * rating / 10;
    }
}

//从故事版创建视图时调用的方法
- (void)awakeFromNib
{
    [self createStarView];
}


- (void)createStarView{
    
    //星星的图片
    UIImage *yellowStarImage = [UIImage imageNamed:@"yellow@2x"];
    UIImage *grayStarImage = [UIImage imageNamed:@"gray@2x"];
    
    _yellowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 17.5 * 5, 17)];
    _grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5 * 17.5, 17)];
    
    _yellowView.backgroundColor = [UIColor colorWithPatternImage:yellowStarImage];
    _grayView.backgroundColor = [UIColor colorWithPatternImage:grayStarImage];
    
    //设置缩放比例
    CGAffineTransform transform = CGAffineTransformMakeScale(self.frame.size.width / 17.5 / 5, self.frame.size.height / 17);
    _yellowView.transform = transform;
    _grayView.transform = transform;
    
    //从新设置视图的中心点
    CGPoint selfCenterPoint = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    _yellowView.center = selfCenterPoint;
    _grayView.center = selfCenterPoint;
    
    
    //先添加灰色星星
    [self addSubview:_grayView];
    [self addSubview:_yellowView];

}


@end
