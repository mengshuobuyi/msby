//
//  WYLNInfoCell.m
//  wenyao
//
//  Created by Yan Qingyang on 15/4/2.
//  Copyright (c) 2015年 xiezhenghong. All rights reserved.
//

#import "WYLNInfoCell.h"

@implementation WYLNInfoCell
+ (CGFloat)getCellHeight:(id)obj{
    return 107;
}

//  颜色转换为背景图片
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)UIGlobal{
    [super UIGlobal];
    
    btnDrug.layer.cornerRadius = 3;
    btnDrug.layer.borderWidth = 1;
    btnDrug.layer.borderColor=RGBHex(qwColor2).CGColor;
    
    btnUser.layer.cornerRadius = 3;
    btnUser.layer.borderWidth = 1;
    btnUser.layer.borderColor=RGBHex(qwColor2).CGColor;
    
    
    [btnDrug setTitleColor:RGBHex(qwColor4) forState:UIControlStateNormal];
    [btnDrug setTitleColor:RGBHex(qwColor4) forState:UIControlStateHighlighted];
    [btnDrug setBackgroundImage:[self imageWithColor:RGBHex(qwColor2)] forState:UIControlStateNormal];
    [btnDrug setBackgroundImage:[self imageWithColor:RGBHex(qwColor2)] forState:UIControlStateHighlighted];
    btnDrug.clipsToBounds   = YES;
    
    [btnUser setTitleColor:RGBHex(qwColor2) forState:UIControlStateNormal];
    [btnUser setTitleColor:RGBHex(qwColor2) forState:UIControlStateHighlighted];
    [btnUser setBackgroundImage:[self imageWithColor:RGBHex(qwColor4)] forState:UIControlStateNormal];
    [btnUser setBackgroundImage:[self imageWithColor:RGBHex(qwColor4)] forState:UIControlStateHighlighted];
    btnUser.clipsToBounds   = YES;
    
    self.separatorLine.hidden=YES;
    self.contentView.backgroundColor=RGBAHex(qwColor4, 0);
    
}
- (void)setCell:(id)data{
    [super setCell:data];
    if ([data isKindOfClass:[WYLocalNotifModel class]]) {
        WYLocalNotifModel *mode=data;
        NSString *day=mode.drugCycle;
        self.drugCycleTitle.text=[NSString stringWithFormat:@"%@%lu次",day,(unsigned long)mode.listTimes.count];

        
        _txtProductName.textColor=RGBHex(qwColor6);
        _txtProductUser.textColor=RGBHex(qwColor6);
        
        _txtProductName.placeholder=kWarningN5;
        _txtProductUser.placeholder=kWarningN6;

    }
}
@end
