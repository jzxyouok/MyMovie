//
//  NovieCollectionView.h
//  DyfTimeMovie
//
//  Created by mac on 15/8/28.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCollectionView : UICollectionView
<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) NSArray *movieData;
@property (nonatomic,assign) CGSize itemSize;
@property (nonatomic,assign) NSInteger index;

@end
