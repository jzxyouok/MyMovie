//
//  BigImageViewController.h
//  DyfTimeMovie
//
//  Created by mac on 15/8/25.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "BaseViewController.h"

@interface BigImageViewController : BaseViewController
<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,strong) NSArray *imageData; //接受Photos里面传过来的数据
@property(nonatomic,strong) NSIndexPath *indexPath; //记录前一个页面点中的单元格

@end
