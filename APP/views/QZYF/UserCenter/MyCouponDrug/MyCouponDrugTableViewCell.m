//
//  CouponDrugTableViewCell.m
//  APP
//
//  Created by 李坚 on 15/8/23.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "MyCouponDrugTableViewCell.h"
#import "CouponModel.h"
#import "UIImageView+WebCache.h"

@implementation MyCouponDrugTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (float)getCellHeight:(id)data{
    return 100.0f;
}

- (void)setCell:(id)data{
    
    MyDrugVo *model = data;
    
    self.proName.text = model.proName;
    self.spec.text = model.spec;
    [self.img setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholderImage:[UIImage imageNamed:@"药品默认图片"]];
    self.dateLabel.text = [NSString stringWithFormat:@"%@ - %@",model.beginTime,model.endTime];
    self.label.text = model.label;

    
    
    //已领取UI--->
    if(self.type == 0){
        
        self.proName.textColor = RGBHex(kColor5);
        self.spec.textColor = RGBHex(kColor6);
        self.dateLabel.textColor = RGBHex(kColor6);
        self.label.textColor = RGBHex(kColor15);
        
        //快过期Image-->
        if([model.expiredSoon isEqualToString:@"1"]){
            
            self.expiredSoonImageView.hidden = NO;
            //    self.expiredSoonImageView.image = [UIImage imageNamed:@""];
        }else{
            self.expiredSoonImageView.hidden = YES;
        }
    }
    
    //已使用UI--->
    if(self.type == 1){
        
        self.proName.textColor = RGBHex(kColor5);
        self.spec.textColor = RGBHex(kColor6);
        self.dateLabel.textColor = RGBHex(kColor6);
        self.label.textColor = RGBHex(kColor15);
        //待评价Image-->
        if([model.commentId isEqualToString:@""]){
            self.expiredSoonImageView.hidden = YES;
        }else{
            
            self.expiredSoonImageView.hidden = NO;
            //    self.expiredSoonImageView.image = [UIImage imageNamed:@""];
        }
    }
    
    //已过期UI--->
    if(self.type == 2){
        
        self.proName.textColor = RGBHex(kColor8);
        self.spec.textColor = RGBHex(kColor8);
        self.dateLabel.textColor = RGBHex(kColor8);
        self.label.textColor = RGBHex(kColor8);
        //已过期Image-->
        self.expiredSoonImageView.hidden = NO;
    //    self.expiredSoonImageView.image = [UIImage imageNamed:@""];
    }
}

@end
