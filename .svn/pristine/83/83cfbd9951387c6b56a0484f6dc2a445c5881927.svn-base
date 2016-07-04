//
//  OutOfDateTableCell.m
//  APP
//
//  Created by garfield on 15/6/12.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "OutOfDateTableCell.h"
#import "Consult.h"
@implementation OutOfDateTableCell

- (void)setCell:(id)data
{
    CustomerConsultVoModel *modelConsult = (CustomerConsultVoModel *)data;
    HistoryMessages *msgModel = [HistoryMessages getObjFromDBWithKey:modelConsult.consultId];
    self.sendIndicateImage.hidden = YES;
    [self.activityIndicator stopAnimating];
    if (msgModel) {
        msgModel.issend = @"3";
        switch ([msgModel.issend intValue]) {
            case 1:
            {
                // 正在发送
                self.sendIndicateImage.hidden = YES;
                [self.activityIndicator startAnimating];
            }
                break;
            case 2:
            {
                // 发送成功
                self.sendIndicateImage.hidden = YES;
                [self.activityIndicator stopAnimating];
            }
                break;
            case 3:
            {
                // 发送失败
                self.sendIndicateImage.hidden = NO;
                [self.activityIndicator stopAnimating];
            }
                break;
            default:
                break;
        }

    }
    
    self.consultFormatShowTime.text = modelConsult.consultFormatShowTime;
    self.consultTitle.text = modelConsult.consultTitle;
}

@end
