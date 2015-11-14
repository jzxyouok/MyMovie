//
//  PostCell.h
//  DyfTimeMovie
//
//  Created by mac on 15/8/26.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface PostCell : UICollectionViewCell

@property(nonatomic,strong) Movie *movie;

//翻转单元格
- (void)filpCell;
//恢复单元格
- (void)backCell;

@end
