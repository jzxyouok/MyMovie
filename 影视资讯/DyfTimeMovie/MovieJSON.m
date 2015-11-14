//
//  MovieJSON.m
//  DyfTimeMovie
//
//  Created by mac on 15/8/22.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "MovieJSON.h"

@implementation MovieJSON

+ (id)readJSONFile:(NSString *)fileName
{
    //1,获取文件路径
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    
    //2,读取文件
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    //3,文件解析
    id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    
    return json;
}

@end
