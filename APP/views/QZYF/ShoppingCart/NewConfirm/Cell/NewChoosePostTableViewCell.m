//
//  NewChoosePostTableViewCell.m
//  APP
//
//  Created by qw_imac on 16/3/28.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "NewChoosePostTableViewCell.h"

@implementation NewChoosePostTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCell:(DeliveryTypeVoModel *)model with:(BOOL)haveAddress and:(BOOL)chooseSonghuo{
    self.quhuoView.hidden = YES;
    self.songhuoView.hidden = YES;
    self.kuaidiView.hidden = YES;
    switch (model.type) {
        case 1:
            self.quhuoView.hidden = NO;
            self.songhuoView.hidden = YES;
            self.kuaidiView.hidden = YES;
            self.serveTime.text = model.timeSliceTip;
            if (!model.available) {
                self.quhuoType.textColor = RGBHex(qwColor9);
                self.serveTime.textColor = RGBHex(qwColor9);
                self.cover.hidden = NO;
                self.userInteractionEnabled = NO;
            } else {
                self.quhuoType.textColor = RGBHex(qwColor6);
                self.serveTime.textColor = RGBHex(qwColor6);
                self.cover.hidden = YES;
                self.userInteractionEnabled = YES;
            }
            break;
        case 3:
            self.quhuoView.hidden = YES;
            self.songhuoView.hidden = YES;
            self.kuaidiView.hidden = NO;
            self.deliverTime.text = model.timeSliceTip;
            self.postFee.text = [NSString stringWithFormat:@"%@",model.feeTip];
            if (!model.manTip || [model.manTip isEqualToString:@""]) {
                self.manTip.hidden = YES;
                self.postHeight.constant = 16.0;
            }else {
                self.manTip.hidden = NO;
                self.postHeight.constant = 10.0;
                self.manTip.text = model.manTip;
            }
            
            if (!model.available) {
                self.postType.textColor = RGBHex(qwColor9);
                self.deliverTime.textColor = RGBHex(qwColor9);
                self.postFee.textColor = RGBHex(qwColor9);
                self.manTip.textColor = RGBHex(qwColor9);
                self.cover.hidden = NO;
                self.userInteractionEnabled = NO;
            } else {
                self.postType.textColor = RGBHex(qwColor6);
                self.deliverTime.textColor = RGBHex(qwColor6);
                self.postFee.textColor = RGBHex(qwColor8);
                self.manTip.textColor = RGBHex(qwColor8);
                self.cover.hidden = YES;
                self.userInteractionEnabled = YES;
            }
            
            break;
        case 2:
            self.quhuoView.hidden = YES;
            self.songhuoView.hidden = NO;
            self.kuaidiView.hidden = YES;
            self.peisongFe.text = model.feeTip;
            self.songhuoTime.text = model.timeSliceTip;
            if (StrIsEmpty(model.manTip)) {
                self.songhuoFreeTip.hidden = YES;
                self.songhuoHeight.constant = 16.0;
            }else {
                self.songhuoFreeTip.hidden = NO;
                self.songhuoHeight.constant = 10.0;
                self.songhuoFreeTip.text = model.manTip;
            }
            self.cover.hidden = YES;
            self.userInteractionEnabled = YES;
            if (haveAddress) {
                if (!model.available && chooseSonghuo) {
                    self.notManLabel.hidden = NO;
                    self.notManLabel.text = model.tip;
                    //                self.songhuoType.textColor = RGBHex(qwColor9);
                    //                self.songhuoTime.textColor = RGBHex(qwColor9);
                    //                self.peisongFe.textColor = RGBHex(qwColor9);
                    //                self.songhuoFreeTip.textColor = RGBHex(qwColor9);
                }else {
                    self.notManLabel.hidden = YES;
                    //                self.songhuoType.textColor = RGBHex(qwColor6);
                    //                self.songhuoTime.textColor = RGBHex(qwColor6);
                    //                self.peisongFe.textColor = RGBHex(qwColor8);
                    //                self.songhuoFreeTip.textColor = RGBHex(qwColor8);
                }
            }else {
                self.notManLabel.hidden = YES;
            }
            break;
    }
}

@end
