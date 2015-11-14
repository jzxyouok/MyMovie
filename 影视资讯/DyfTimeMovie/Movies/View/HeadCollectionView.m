//
//  HeadCollectionView.m
//  DyfTimeMovie
//
//  Created by mac on 15/8/26.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "HeadCollectionView.h"
#import "Movie.h"

@interface HeadCollectionView ()

@end

@implementation HeadCollectionView

#pragma mark - UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor purpleColor];
    
    //背景图片视图
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:cell.bounds];
    cell.backgroundView = imageView;
    
    //读取图片
    Movie *movie = self.movieData[indexPath.row];
    NSURL *url = [NSURL URLWithString:movie.images[MovieImageSmall]];
    [imageView sd_setImageWithURL:url];
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    
    self.index = indexPath.item;
}

@end
