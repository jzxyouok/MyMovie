//
//  District.h
//  DyfTimeMovie
//
//  Created by mac on 15/8/29.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "BaseModel.h"

@interface District : BaseModel

@property (nonatomic,copy) NSString *name;       //区名
@property (nonatomic,copy) NSString *districtID; //id

@property (nonatomic,strong) NSMutableArray *cinemas; //地区中所有的影院信息

@property (nonatomic,assign) BOOL isShow; //判断组的头视图的状态

@end
