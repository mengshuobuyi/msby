//
//  NewUserCenterCell.m
//  APP
//
//  Created by qw_imac on 16/6/13.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "NewUserCenterCell.h"

@implementation NewUserCenterCell

- (void)awakeFromNib {
    
}

-(void)setCellWith:(NSString *)title And:(NSString *)img {
    if(StrIsEmpty(title)){
        _title.hidden = YES;
        _img.hidden = YES;
    }else {
        _title.hidden = NO;
        _img.hidden = NO;
        _title.text = title;
        _img.image = [UIImage imageNamed:img];
    }
}

@end
