//
//  InformationTableViewCell.m
//  quanzhi
//
//  Created by xiezhenghong on 14-6-24.
//  Copyright (c) 2014年 xiezhenghong. All rights reserved.
//

#import "InformationTableViewCell.h"
#import "HealthinfoModel.h"

@implementation InformationTableViewCell
@synthesize iconUrl=iconUrl;
@synthesize introduction=introduction;
@synthesize pariseNum=pariseNum;
@synthesize publishTime=publishTime;
@synthesize readNum=readNum;
@synthesize title=title;

+ (CGFloat)getCellHeight:(id)data{
    return 81.0f;
}

- (void)UIGlobal{
//    [super UIGlobal];
    
//    self.contentView.backgroundColor=RGBHex(qwColor4);
//    self.separatorLine.backgroundColor=RGBHex(qwColor10);
    //self.introduction.textColor=RGBAHex(kColor3, 1);
    self.separatorHidden = YES;
    self.pariseNum.textColor = RGBHex(qwColor9);
    self.readNum.textColor = RGBHex(qwColor9);
    self.publishTime.textColor = RGBHex(qwColor8);
    [self setBackgroundColor:[UIColor whiteColor]];
    self.selectedBackgroundView = [[UIView alloc]init];
    self.selectedBackgroundView.backgroundColor = RGBHex(qwColor10);
}

- (void)setCell:(id)data{
    [super setCell:data];
    self.seperatorLine.frame = CGRectMake(self.seperatorLine.frame.origin.x, self.seperatorLine.frame.origin.y, self.seperatorLine.frame.size.width, 0.5);
    //添加其他执行代码
    HealthinfoAdvicel *mod = (HealthinfoAdvicel*)data;
    NSString *time = @"";
    if (mod.publishTime.length >= 10) {
         time=[mod.publishTime substringToIndex:10];
    }
    
    [self.publishTime setLabelValue:time];
    self.title.textColor = RGBHex(qwColor6);
    self.title.font = fontSystem(kFontS1);
    self.publishTime.font = fontSystem(kFontS5);
    self.readNum.font = self.pariseNum.font = fontSystem(kFontS5);
}
@end
