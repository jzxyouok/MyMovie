//
//  TabBarButton.m
//  DyfTimeMovie
//
//  Created by mac on 15/8/19.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "TabBarButton.h"

@implementation TabBarButton


- (id)initWithTitle:(NSString *)title imageName:(NSString *)imageName frmae:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - 20) / 2, 8, 20, 22)];
        imageView.image = [UIImage imageNamed:imageName];
        [self addSubview:imageView];
        
        //图片的拉伸模式
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 32, frame.size.width, 15)];
        label.text = title;
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:13];
        [self addSubview:label];
        
    }
    return self;
}


@end
