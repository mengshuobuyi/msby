//
//  NewWinInfoTableViewCell.m
//  APP
//
//  Created by qw_imac on 16/4/20.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "NewWinInfoTableViewCell.h"

@implementation NewWinInfoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setCell:(LuckdrWonAwardVo *)vo {
    self.name.text = vo.title;
    self.source.text = vo.desc;
    self.time.text = vo.date;
    self.remark.text=[NSString stringWithFormat:@"%@",vo.remark?vo.remark:@""];
    self.topSpace.constant = - 8.0f;
    self.eventShowInfo.hidden = YES;
    self.gotoFillView.hidden = YES;
    [self.eventBtn removeTarget:nil action:NULL forControlEvents:UIControlEventTouchUpInside];
    switch (vo.objType) {
        case 3://实物（填写地址）
            self.topSpace.constant = 8.0f;
            if(vo.postAddrEmpty){//未填写
                self.gotoFillView.hidden = NO;
                self.event.text = @"收货地址：";
            }else {
                self.eventShowInfo.hidden = NO;
                self.eventShowInfo.text = [NSString stringWithFormat:@"收货地址:  %@,%@,%@",vo.postNick?vo.postNick:@"",vo.postMobile?vo.postMobile:@"",vo.postAddr?vo.postAddr:@""];
            }
            break;
        case 5://虚拟（填号码）
            self.topSpace.constant = 8.0f;
            if(vo.chargeNoEmpty){//未填写
                self.gotoFillView.hidden = NO;
                self.event.text = @"充值手机：";
            }else {
                self.eventShowInfo.hidden = NO;
                self.eventShowInfo.text = [NSString stringWithFormat:@"充值手机：%@",vo.chargeNo?vo.chargeNo:@""];
            }
            break;
        default:
            break;
    }
}
@end
