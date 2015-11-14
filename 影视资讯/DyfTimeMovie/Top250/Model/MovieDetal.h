//
//  MovieDetal.h
//  DyfTimeMovie
//
//  Created by mac on 15/8/25.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "BaseModel.h"

/*
 "image" : "http://img31.mtime.cn/mt/2012/06/28/131128.94272291.jpg",
	"titleCn" : "摩尔庄园2海妖宝藏",
	"titleEn" : "Legend of The Moles-Treasure of Scylla",
	"rating" : "7.7",
	"year" : "2012",
	"content" : "摩尔庄园大电影系列第二部：《摩尔庄园海妖宝藏》继续讲述快乐、勇敢、热爱和平的小摩尔们战胜邪恶",
	"type" : [ "动画", "动作", "奇幻", "冒险" ],
	"url" : "http://movie.mtime.com/157836/",
	"directors" : [ "刘可欣" ],
	"actors" : ["阿黄","阿龟","阿宇","阿红","凤姐"],
	"release" : {
 "location" : "中国",
 "date" : "2012-7-5"
 */
/*
{
    "userImage" : "http://img2.mtime.com/images/default/head.gif",
    "nickname" : "yangna988",
    "rating" : "9.0",
    "content" : "儿子很喜欢 一直期盼上映"
}
*/

@interface MovieDetal : BaseModel

@property (nonatomic,copy) NSString *image;     //电影的图片
@property (nonatomic,copy) NSString *titleCn;   //中文名
@property (nonatomic,strong) NSArray *type;     //类型
@property (nonatomic,strong) NSArray *directors; //导演
@property (nonatomic,strong) NSArray *actors;    //主演
@property (nonatomic,strong) NSDictionary *releaseD; //上映年份
@property (nonatomic,strong) NSArray *images;       //图片浏览

@property (nonatomic,copy) NSString *userImage;  //用户头像
@property (nonatomic,copy) NSString *nickname;   //用户名
@property (nonatomic,copy) NSString* rating;    //评分
@property (nonatomic,copy) NSString *content;   //评论

@property (nonatomic,assign) BOOL isShow;

@end
