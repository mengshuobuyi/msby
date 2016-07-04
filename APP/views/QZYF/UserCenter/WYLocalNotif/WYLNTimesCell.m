//
//  WYLNTimeCell.m
//  wenyao
//
//  Created by Yan Qingyang on 15/4/2.
//  Copyright (c) 2015年 xiezhenghong. All rights reserved.
//

#import "WYLNTimesCell.h"

@implementation WYLNTimesCell

+ (CGFloat)getCellHeight:(id)obj{
    return 50;
}
- (void)UIGlobal{
    [super UIGlobal];
    
    

    
    self.separatorLine.hidden=YES;//self.separatorHidden;
    self.contentView.backgroundColor=RGBAHex(qwColor4, 0);
}
- (void)setCell:(WYLocalNotifModel*)mode{
//    self.time.text=txt;
    self.separatorLine.hidden=self.separatorHidden;
    [self showTime:mode.listTimes];
}

- (void)showTime:(NSArray*  )arr{
//    for (id obj in vTimes.subviews) {
//        [obj removeFromSuperview];
//    }
    NSString *ss;
//    float xx=10,ww=46;
    int i = 0;
    for (id obj in arr) {
        if ([obj isKindOfClass:[NSString class]]) {
//            CGRect frm=CGRectMake(19+i*(xx+ww), 11, ww, 14);
//            UILabel *lbl=[[UILabel alloc]initWithFrame:frm];
//            lbl.font=fontSystem(kFontS5);
//            lbl.text=obj;
//            [vTimes addSubview:lbl];
            if (i==0) {
                ss=StrFromObj(obj);
            }
            else ss=[NSString stringWithFormat:@"%@  %@",ss,obj];
            i++;
        }
    }
    
    self.time.text=ss;
    
}
@end
