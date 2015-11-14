//
//  District.m
//  DyfTimeMovie
//
//  Created by mac on 15/8/29.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "District.h"

@implementation District

//复写初始化方法
- (id)initContentWithDic:(NSDictionary *)jsonDic
{
    //调用父类的初始化方法，来加载属性名和key相同的数据
    self = [super initContentWithDic:jsonDic];
    if (self)
    {
        //手动加载名字不相同的数据
        self.districtID = jsonDic[@"id"];
        
        //初始化影院数组
        _cinemas = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
