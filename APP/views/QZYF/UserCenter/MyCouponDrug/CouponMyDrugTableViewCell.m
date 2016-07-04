//
//  
//  APP
//
//  Created by 李坚 on 15/8/23.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "CouponMyDrugTableViewCell.h"
#import "CouponModel.h"
#import "UIImageView+WebCache.h"
#import "MyMutableMorePromotionTableViewCell.h"
#import "QWGlobalManager.h"
@implementation CouponMyDrugTableViewCell

- (void)awakeFromNib {
    // Initialization code
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, self.seperator.frame.size.height - 0.5, APP_W, 0.5)];
    line1.backgroundColor = RGBHex(qwColor10);
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APP_W, 0.5)];
    line2.backgroundColor = RGBHex(qwColor10);
    
    self.seperator.backgroundColor = RGBHex(qwColor11);
    
    [self.seperator addSubview:line1];
    [self.seperator addSubview:line2];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)getCellHeight:(id)data{
    return 103.0f;
}

- (void)setCell:(id)data{
    
    MyDrugVo *model = data;
    
    self.proName.text = model.proName;
    self.spec.text = model.spec;
    [self.img setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholderImage:[UIImage imageNamed:@"药品默认图片"]];
    self.dateLabel.text = [NSString stringWithFormat:@"%@ - %@",model.beginTime,model.endTime];
    self.label.text = model.label;
    
    //已领取UI--->
    if(self.drugStatus == 1){
        
        self.proName.textColor = RGBHex(qwColor6);
        self.spec.textColor = RGBHex(qwColor7);
        self.dateLabel.textColor = RGBHex(qwColor7);
        self.label.textColor = RGBHex(qwColor2);
//        self.expiredSoonImageView.image = [UIImage imageNamed:@"img_bg_receive"];
        self.expiredSoonImageView.hidden = YES;
        //快过期Image-->
        if([model.expiredSoon intValue] == 1){
            self.expiredSoonImageView.hidden = NO;
            self.expiredSoonImageView.image = FastExpired;
        }
    }
    
    //已使用UI--->
    if(self.drugStatus == 2){
//        self.dateLabel.text = model.useTime;
        //待评价Image-->
        if([model.comment intValue] == 0){
            self.proName.textColor = RGBHex(qwColor6);
            self.spec.textColor = RGBHex(qwColor7);
            self.dateLabel.textColor = RGBHex(qwColor7);
            self.label.textColor = RGBHex(qwColor2);
         
            self.expiredSoonImageView.hidden = NO;
            self.expiredSoonImageView.image = DisEvaluated;
    
        }else{//已评价
            self.proName.textColor = RGBHex(qwColor9);
            self.spec.textColor = RGBHex(qwColor9);
            self.dateLabel.textColor = RGBHex(qwColor9);
            self.label.textColor = RGBHex(qwColor9);
            
            self.expiredSoonImageView.hidden = NO;
            self.expiredSoonImageView.image = Evaluated;
           
        }
    }
    
    //已过期UI--->
    if(self.drugStatus == 3){
        
        self.proName.textColor = RGBHex(qwColor9);
        self.spec.textColor = RGBHex(qwColor9);
        self.dateLabel.textColor = RGBHex(qwColor9);
        self.label.textColor = RGBHex(qwColor9);
        //已过期Image-->
        self.expiredSoonImageView.hidden = NO;
        self.expiredSoonImageView.image = Expired;
    }
}

@end
