//
//  MyPharmacyTableViewCell.m
//  wenyao
//
//  Created by Pan@QW on 14-9-22.
//  Copyright (c) 2014年 xiezhenghong. All rights reserved.
//

#import "MyPharmacyTableViewCell.h"
#import "QueryMyBoxModel.h"
#import "UIImageView+WebCache.h"


@implementation MyPharmacyTableViewCell

@synthesize avatar;
@synthesize uncompleteImage;
@synthesize productName;
@synthesize medicineUsage;
@synthesize createTime;
@synthesize alarmClockImage;

- (void)UIGlobal{
    [super UIGlobal];

    //    self.contentView.backgroundColor=RGBHex(qwColor4);
    //    self.separatorLine.backgroundColor=RGBHex(qwColor10);
    //self.introduction.textColor=RGBAHex(kColor3, 1);
}

- (void)setCell:(id)data
{
    [super setCell:data];
    QueryMyBoxModel *boxModel = (QueryMyBoxModel *)data;
//    self.uncompleteImage.image = [UIImage imageNamed:@"未完善.png"];
    [self.avatar setImage:nil];
//    [self.avatar setImageWithURL:[NSURL URLWithString:PORID_IMAGE(boxModel.proId)] placeholderImage:[UIImage imageNamed:@"默认药品图片_V2.png"]];
    [self.avatar setImageWithURL:[NSURL URLWithString:boxModel.imgUrl] placeholderImage:[UIImage imageNamed:@"img_medical-notice-brand_nomal"]];
    
    
//    if(boxModel.useName && ![boxModel.useName isEqualToString:@""]) {
        NSString *str1 = nil;//用法
        NSString *str2 = nil;//用量
        NSString *str3 = nil;//次数
        if(boxModel.useMethod){
            str1 = boxModel.useMethod;
            if([str1 isEqualToString:@""]) {
                str1 = nil;
            }
        }
        //第二行填满
       // if(boxModel.perCount && ![boxModel.perCount isEqualToString:@""] && [boxModel.perCount integerValue] != -99 && boxModel.unit && ![boxModel.unit isEqualToString:@""]){
        if(!StrIsEmpty(boxModel.perCount) && [boxModel.perCount integerValue] != -99 && !StrIsEmpty(boxModel.unit)){
            str2 = [NSString stringWithFormat:@"一次%@%@",boxModel.perCount,boxModel.unit];
            if([str2 isEqualToString:@""]) {
                str2 = nil;
            }
        }
        //第三行填满
        if(boxModel.intervalDay && [boxModel.intervalDay integerValue] != -99 && boxModel.drugTime && [boxModel.drugTime integerValue] != -99){
            NSUInteger intervalDay = [boxModel.intervalDay integerValue];
            if(intervalDay == 0) {
//                str3 = @"即需即用";
            }else{
                str3 = [NSString stringWithFormat:@"%@日%@次",boxModel.intervalDay,boxModel.drugTime];
                if([str3 isEqualToString:@""]) {
                    str3 = nil;
                }
            }
        }

        if(str1)
            self.medicineUsage.text = [NSString stringWithFormat:@"%@",str1];
        if(str2)
            self.medicineUsage.text = [NSString stringWithFormat:@"%@",str2];
        if(str3)
            self.medicineUsage.text = [NSString stringWithFormat:@"%@",str3];
        if(str1 && str2)
            self.medicineUsage.text = [NSString stringWithFormat:@"%@，%@",str1,str2];
        if(str1 && str3)
            self.medicineUsage.text = [NSString stringWithFormat:@"%@，%@",str1,str3];
        if(str2 && str3)
            self.medicineUsage.text = [NSString stringWithFormat:@"%@，%@",str2,str3];
        if(str1 && str2 && str3)
            self.medicineUsage.text = [NSString stringWithFormat:@"%@，%@，%@",str1,str2,str3];
        if([self.medicineUsage.text isEqualToString:@""]) {
            self.medicineUsage.text = @"请完善用法用量";
        }
        if(!str1 && !str2 && !str3) {
            self.medicineUsage.text = @"请完善用法用量";
        }
//    }else{
//        self.medicineUsage.text = @"用法用量请参考药品详情";
//    }
    
    //if(boxModel.useName && ![boxModel.useName isEqualToString:@""]){
    if(!StrIsEmpty(boxModel.useName)) {
        self.uncompleteImage.hidden = YES;
    }else{
        self.uncompleteImage.hidden = NO;
    }
    if(!boxModel.createTime) {
        self.createTime.text = @"";
    }
}

- (void)awakeFromNib
{
//    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 97, APP_W, 0.5)];
//    line.backgroundColor = RGBHex(qwColor10);
//    [self addSubview:line];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}


@end
