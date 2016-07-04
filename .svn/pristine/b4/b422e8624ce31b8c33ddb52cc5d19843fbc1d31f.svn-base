//
//  WYLNCell.m
//  wenyao
//
//  Created by Yan Qingyang on 15/4/2.
//  Copyright (c) 2015年 xiezhenghong. All rights reserved.
//

#import "WYLNCell.h"
@interface WYLNCell ()
{
    WYLocalNotifModel *modeData;
}
@end

@implementation WYLNCell

+ (CGFloat)getCellHeight:(id)obj{
    return 80;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    [self UIGlobal];
}

- (void)UIGlobal{
    
    

    CGRect frm=self.bounds;

    if (self.separatorLine==nil) {
        self.separatorLine=[[UIView alloc]init];
    }
    
    frm.origin.y=CGRectGetHeight(self.bounds)-0.5f;
    frm.size.height=.5f;
    self.separatorLine.frame=frm;
    self.separatorLine.backgroundColor = RGBAHex(qwColor10, 1);
    [self.contentView addSubview:self.separatorLine];
    [self.contentView bringSubviewToFront:self.separatorLine];
//    self.separatorLine.hidden=self.separatorHidden;
    
    self.contentView.clipsToBounds = NO;
    self.clipsToBounds = YES;
    
    self.contentView.backgroundColor=RGBAHex(qwColor4, 1);
    self.productUser.textColor=RGBHex(qwColor1);
    self.productName.textColor=RGBHex(qwColor6);
    self.drugCycle.textColor=RGBHex(qwColor8);
    self.day.textColor=RGBHex(qwColor8);
    self.time.textColor=RGBHex(qwColor2);
    self.swhClock.onTintColor=RGBHex(qwColor2);
}
//
- (void)setCell:(id)data{
    
    if ([data isKindOfClass:[WYLocalNotifModel class]]) {
        modeData=data;
        
        //获取下一次提醒时间
        NSDate *dt=[[QWLocalNotif instance] getNextLN:modeData];
        self.day.text=[[QWLocalNotif instance] dateToString:dt format:@"yyyy-M-d"];
        self.time.text=[[QWLocalNotif instance] dateToString:dt format:@"HH:mm"];
        
        NSString *day=modeData.drugCycle;
        self.drugCycle.text=[NSString stringWithFormat:@"%@%lu次",day,(unsigned long)modeData.listTimes.count];
        self.productUser.text=modeData.productUser;

        self.swhClock.on=modeData.clockEnabled;
        
        self.productName.text=modeData.productName;

    }
}

- (IBAction)clockAction:(id)sender{
    UISwitch *swh=(UISwitch*)sender;

    modeData.clockEnabled=swh.on;
    if ([self.delegate respondsToSelector:@selector(QWLocalNotifDelegate:)]) {
        [self.delegate QWLocalNotifDelegate:self];
    }
    
    
    

}
@end
