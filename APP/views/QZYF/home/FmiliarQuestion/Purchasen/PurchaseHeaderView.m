//
//  PurchaseHeaderView.m
//  APP
//
//  Created by qw_imac on 15/11/9.
//  Copyright © 2015年 carret. All rights reserved.
//

#import "PurchaseHeaderView.h"
#import "ActivityModel.h"


@implementation PurchaseHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (PurchaseHeaderView *)instancePurchaseHeaderView  {
    NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"PurchaseHeaderView" owner:nil options:nil];
    PurchaseHeaderView *view = [array objectAtIndex:0];
    view.frame = CGRectMake(0, 0, APP_W, 40) ;
    view.dayTime.adjustsFontSizeToFitWidth = YES;
    view.dayTime.layer.cornerRadius = 3.0;
    view.dayTime.layer.masksToBounds = YES;
    view.hourTime.layer.cornerRadius = 3.0;
    view.hourTime.layer.masksToBounds = YES;
    view.minuteTime.layer.cornerRadius = 3.0;
    view.minuteTime.layer.masksToBounds = YES;
    view.secTime.layer.cornerRadius = 3.0;
    view.secTime.layer.masksToBounds = YES;
    return view;
}

-(void)setupPurchaseHeaderView:(PurchaseStatusType)type WithTime:(long long)time{
    switch (type) {
        case PurchaseStatusNotBegin:
            self.endLabel.text = @"距开始还有";
            [self updateUI:time];
            break;
        case PurchaseStatusBegin:
            self.endLabel.text = @"距结束还有";
            [self updateUI:time];
            break;
        case PurchaseStatusEnd:
            self.endLabel.text = @"抢购已结束";
            [self updateUI:0];
            break;
    }
}

-(void)updateUI:(long long)time {
    if(time > 0) {
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat = @"dd:HH:mm:ss";
        [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        
        NSString *dateString = [formatter stringFromDate:date];
        NSArray *dateArray = [dateString componentsSeparatedByString:@":"];
        NSTimeInterval timeStamp = [date timeIntervalSince1970];
        NSInteger day = floor(timeStamp / 3600.0 / 24.0);
        if (day < 10) {
            self.dayTime.text = [NSString stringWithFormat:@"%02d",day];
        }else {
            self.dayTime.text = [NSString stringWithFormat:@"%d",day];
        }
        
        self.hourTime.text = dateArray[1];
        self.minuteTime.text = dateArray[2];
        self.secTime.text = dateArray[3];
    }else{
        self.dayTime.text = @"00";
        self.hourTime.text = @"00";
        self.minuteTime.text = @"00";
        self.secTime.text = @"00";
    }
}
@end
