//
//  BigImageCell.h
//  DyfTimeMovie
//
//  Created by mac on 15/8/25.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BigImageCell : UICollectionViewCell <UIScrollViewDelegate>

@property(nonatomic,strong) NSURL *imageURL;

- (void)backImageZoomingScale;

@end
