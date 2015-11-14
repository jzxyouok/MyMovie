//
//  Cinema.h
//  DyfTimeMovie
//
//  Created by mac on 15/8/26.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "BaseModel.h"

@interface Cinema : BaseModel

@property (nonatomic,copy) NSString *name;  //影院名
@property (nonatomic,copy) NSString *address; //影院地址
@property (nonatomic,copy) NSString *lowPrice; //最低价格
@property (nonatomic,copy) NSString *grade;    //评价
@property (nonatomic,copy) NSString *districtId; //影院id
@property (nonatomic,copy) NSString *isSeatSupport; //是否提供座位
@property (nonatomic,copy) NSString *isCouponSupport;
@property (nonatomic,copy) NSString *isImaxSupport;
@property (nonatomic,copy) NSString *isGroupBuySupport;

@end
