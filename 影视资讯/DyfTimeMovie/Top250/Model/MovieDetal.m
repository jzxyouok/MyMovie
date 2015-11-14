//
//  MovieDetal.m
//  DyfTimeMovie
//
//  Created by mac on 15/8/25.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "MovieDetal.h"

@implementation MovieDetal


/*
 属性名与json字典中key的映射关系
 key:  json字典的key名
 value: model对象的属性名
 */
- (NSDictionary *)attributeMapDictionary:(NSDictionary *)jsonDic {
    
    NSMutableDictionary *mapDic = [NSMutableDictionary dictionary];
    
    for (id key in jsonDic) {
        [mapDic setObject:key forKey:key];
    }
    [mapDic setObject:@"releaseD" forKey:@"release"];
    return mapDic;
}

@end
