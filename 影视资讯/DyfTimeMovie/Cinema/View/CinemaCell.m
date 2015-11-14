//
//  CinemaCell.m
//  DyfTimeMovie
//
//  Created by mac on 15/8/26.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "CinemaCell.h"
#import "Cinema.h"

@implementation CinemaCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setCinema:(Cinema *)cinema
{
    _cinema = cinema;
    
    _nameLabel.text = _cinema.name;
    _addressLabel.text = _cinema.address;
    _gradeLabel.text = _cinema.grade;
    if (_cinema.lowPrice.length == 0) {
        
        _lowPriceLabel.text = [NSString stringWithFormat:@"暂无报价"];
    }
    else
    {
    _lowPriceLabel.text = [NSString stringWithFormat:@"￥%@",_cinema.lowPrice];
    }
    
    _isSeatView.hidden = [_cinema.isSeatSupport isEqualToString:@"0"];
    _isCoup.hidden = [_cinema.isCouponSupport isEqualToString:@"0"];
    _isGroupView.hidden = [_cinema.isCouponSupport isEqualToString:@"0"];
    _isIMAXView.hidden = [_cinema.isImaxSupport isEqualToString:@"0"];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
