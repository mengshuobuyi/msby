//
//  ServiceStyleTableViewCell.m
//  APP
//
//  Created by 李坚 on 16/1/4.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "ServiceStyleTableViewCell.h"

#define ShoConstant 12.0f
#define LonConstant 23.0f

@implementation ServiceStyleTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

+ (CGFloat)getCellHeight:(id)data{
    return 60.0f;
}

- (void)setCell:(PostTipVo *)data{
    self.lineWidthConstant.constant = 0.5f;
    if(StrIsEmpty(data.feeTip)){
        self.serviceLayout.constant = LonConstant;
    }else{
        self.serviceLayout.constant = ShoConstant;
    }
    
    if(StrIsEmpty(data.manTip)){
        self.styleLayout.constant = LonConstant;
    }else{
        self.styleLayout.constant = ShoConstant;
    }
    
    self.serviceLabel.text = data.title;
    self.moneyLabel.text = data.feeTip;
    
    self.styleLabel.text = data.timeSliceTip;
    self.styleMoneyLabel.text = data.manTip;
    
}

- (void)addSpeatorLine{
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, [ServiceStyleTableViewCell getCellHeight:nil] - 0.5, APP_W, 0.5)];
    line.backgroundColor = RGBHex(qwColor10);
    [self addSubview:line];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
