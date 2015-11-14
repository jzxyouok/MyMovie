//
//  NovieCollectionView.m
//  DyfTimeMovie
//
//  Created by mac on 15/8/28.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "MovieCollectionView.h"

@implementation MovieCollectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    //创建布局对象
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //单元格大小
    _itemSize = CGSizeMake(frame.size.height * 0.6, frame.size.height * 0.84);
    layout.itemSize = _itemSize;
    
    layout.minimumInteritemSpacing = 10;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //设置四周间隙
    CGFloat x = (frame.size.width - _itemSize.width) / 2;
    layout.sectionInset = UIEdgeInsetsMake(0, x, 0, x);
    
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        
        self.dataSource = self;
        self.delegate = self;
        self.showsHorizontalScrollIndicator = NO;
        
        //注册单元格
        UINib *nib = [UINib nibWithNibName:@"PostCell" bundle:[NSBundle mainBundle]];
        [self registerNib:nib forCellWithReuseIdentifier:@"PostCell"];
        
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
        self.index = 0;
        
    }
    return self;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _movieData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark - 设置单元格的分页效果
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    //1,获取视图停止之后的偏移量
    CGFloat xoffset = targetContentOffset->x;
    xoffset -= _itemSize.width / 2;
    
    //2,根据偏移量，计算停止之后，所在的页码
    NSInteger index = xoffset / (_itemSize.width + 10);
    if (xoffset > 0)
    {
        index += 1;
    }
    
    self.index = index;
    
    //3,计算此页显示在正中间时，滑动视图的偏移量
    xoffset = index * (_itemSize.width +10);
    
    //4,讲计算所得的偏移量，设置给滑动视图
    targetContentOffset->x = xoffset;
    
}

@end
