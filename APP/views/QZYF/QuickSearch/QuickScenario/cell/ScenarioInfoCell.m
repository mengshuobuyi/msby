//
//  ScenarioInfoCell.m
//  APP
//
//  Created by caojing on 15-3-11.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "ScenarioInfoCell.h"
#import "DrugModel.h"
@implementation ScenarioInfoCell
@synthesize answer=answer;

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)UIGlobal{
     self.answer.textColor=RGBHex(qwColor6);
}


+ (CGFloat)getCellHeight:(id)data{
    HealthyScenarioDiseaseModel *mod=(HealthyScenarioDiseaseModel*)data;
    CGSize size=[GLOBALMANAGER sizeText:[QWGLOBALMANAGER replaceSpecialStringWith: mod.answer] font:fontSystem(kFontS4) limitWidth:APP_W-20];
    
    return size.height + 20;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setCell:(id)data{
    [super setCell:data];
    
    //添加其他执行代码
    HealthyScenarioDiseaseModel *mod = (HealthyScenarioDiseaseModel*)data;
    NSString *str=[QWGLOBALMANAGER replaceSpecialStringWith:mod.answer];
    [self.answer setLabelValue:str];
     CGSize size=[GLOBALMANAGER sizeText:str font:fontSystem(kFontS4) limitWidth:APP_W-20];
    [self setBackgroundColor:RGBHex(qwColor11)];
   [self.answer setFrame:CGRectMake(15, 10, self.answer.frame.size.width,size.height)];
    
}


@end
