//
//  PostCollectionView.m
//  DyfTimeMovie
//
//  Created by mac on 15/8/26.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "PostCollectionView.h"
#import "PostCell.h"

@interface PostCollectionView () <UICollectionViewDataSource,UICollectionViewDelegate>


@end

@implementation PostCollectionView

#pragma mark - UICollectionViewDtata
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PostCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PostCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor grayColor];
    cell.movie = self.movieData[indexPath.item];
    return cell;
}

#pragma mark - 单元格的翻转与恢复
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    //根据偏移量计算正中间单元格的索引
    NSInteger index = collectionView.contentOffset.x / (collectionView.width * 0.7 + 10);
    //判断选中的单元格是不是正中间单元格
    if (indexPath.item == index)
    {
        // YES翻转这个单元格
        //获取单元格
        PostCell *cell = (PostCell *)[collectionView cellForItemAtIndexPath:indexPath];
        //翻转单元格
        [cell filpCell];
    }
    else
    {
        //No 将这个单元格移到正中间
        [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        
        self.index = indexPath.item;
        
        //将已经翻转的单元格翻转回来
        //获取单元格
        PostCell *cell = (PostCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
        //翻转单元格
        [cell backCell];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    PostCell *postCell = (PostCell *)cell;
    [postCell backCell];
}



@end
