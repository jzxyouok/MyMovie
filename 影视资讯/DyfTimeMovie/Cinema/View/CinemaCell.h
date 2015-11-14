//
//  CinemaCell.h
//  DyfTimeMovie
//
//  Created by mac on 15/8/26.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Cinema;

@interface CinemaCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UILabel *gradeLabel;
@property (strong, nonatomic) IBOutlet UILabel *lowPriceLabel;
@property (strong, nonatomic) IBOutlet UIImageView *isSeatView;
@property (strong, nonatomic) IBOutlet UIImageView *isCoup;
@property (strong, nonatomic) IBOutlet UIImageView *isGroupView;

@property (strong, nonatomic) IBOutlet UIImageView *isIMAXView;


@property (nonatomic,strong) Cinema *cinema;

@end
