//
//  BigImageCell.m
//  DyfTimeMovie
//
//  Created by mac on 15/8/25.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "BigImageCell.h"

@interface BigImageCell ()
{
    UIScrollView *_scrollView;  //底层的滑动视图
    UIImageView *_imageView;  //图片视图
    
    NSTimer *_timer;
}

@end

@implementation BigImageCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self creatViews];
    }
    return self;
}

- (void)creatViews
{
    //创建滑动视图
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.contentSize = self.frame.size;
    //设置缩放倍数
    _scrollView.maximumZoomScale = 3;
    _scrollView.minimumZoomScale = 0.3;
    
    _scrollView.delegate = self;
    
    [self.contentView addSubview:_scrollView];
    
    //创建图片视图
    _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.image = [UIImage imageNamed:@"loading"];
    [_scrollView addSubview:_imageView];
    
    //让_imageView接受点击事件
    _imageView.userInteractionEnabled = YES;
    
    //为图片添加手势
    //单击
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction:)];
    //点击次数
    singleTap.numberOfTapsRequired = 1;
    //一根手指
    singleTap.numberOfTouchesRequired = 1;
    [_imageView addGestureRecognizer:singleTap];
    
    //双击
    //给手势初始化的同时添加方法
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapAction)];
    //点击次数
    doubleTap.numberOfTapsRequired = 2;
    //一根手指
    doubleTap.numberOfTouchesRequired = 1;
    [_imageView addGestureRecognizer:doubleTap];
}

//单击事件
- (void)singleTapAction:(UITapGestureRecognizer *)tap
{
    _timer =[NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(afterSingleTap:) userInfo:nil repeats:NO];
}

//单击之后延迟调用的方法
- (void)afterSingleTap:(NSTimer *)timer
{
    //发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"singleTap" object:self userInfo:nil];
}

//双击事件
- (void)doubleTapAction
{
    //取消定时器，取消单击
    [_timer invalidate];
    
    if (_scrollView.zoomScale >= 2)
    {
        [_scrollView setZoomScale:1 animated:YES];
    }
    else
    {
        [_scrollView setZoomScale:3 animated:YES];
    }
}

//UIScrollViewDelegate 返回值为捏合手势缩放的视图
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView;
}

- (void)setImageURL:(NSURL *)imageURL
{
    _imageURL = imageURL;
    [_imageView sd_setImageWithURL:_imageURL];
}

//还原
- (void)backImageZoomingScale
{
    [_scrollView setZoomScale:1];
}

@end
