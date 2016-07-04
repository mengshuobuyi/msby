//
//  BYSelectNewBar.m
//  BYDailyNews
//
//  Created by bassamyan on 15/1/18.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "BYDeleteBar.h"
#import "QWGlobalManager.h"

@interface BYDeleteBar()

@end

@implementation BYDeleteBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self makeNewBar];
    }
    return self;
}
-(void)makeNewBar
{
    self.backgroundColor = [UIColor clearColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 60, 20)];
    label.font = fontSystem(kFontS1);
    label.textColor = RGBHex(qwColor6);
    label.text = @"我的频道";
    [self addSubview:label];
    
    if (!self.hitText) {
        self.hitText = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame)+10,2, 100, 15)];
        self.hitText.font = fontSystem(kFontS5);//[UIFont systemFontOfSize:11];
        self.hitText.text = @"拖拽可以排序";
        self.hitText.textColor = RGBHex(qwColor8);//[UIColor colorWithRed:(170.0)/255.0 green:(170.0)/255.0 blue:(170.0)/255.0 alpha:1.0];
        self.hitText.hidden = YES;
        [self addSubview:self.hitText];
    }
    
    if (!self.sortBtn) {
        self.sortBtn = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-15-30, 0, 30, 20)];
        [self.sortBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [self.sortBtn setTitleColor:RGBHex(qwColor3) forState:UIControlStateNormal];
        self.sortBtn.titleLabel.font = fontSystem(kFontS1);
//        self.sortBtn.layer.cornerRadius = 5;
//        self.sortBtn.layer.borderWidth = 0.5;
//        [self.sortBtn.layer setMasksToBounds:YES];
//        self.sortBtn.layer.borderColor = [[UIColor redColor] CGColor];
        [self.sortBtn addTarget:self
                         action:@selector(sortBtnClick:)
               forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.sortBtn];
    }
    
}

-(void)sortBtnClick:(UIButton *)sender{
    if (sender.selected) {
        [sender setTitle:@"编辑" forState:UIControlStateNormal];
        self.hitText.hidden = YES;
        NSMutableDictionary *tdParams = [NSMutableDictionary dictionary];
        [QWGLOBALMANAGER statisticsEventId:@"x_bjzx_wc" withLable:@"资讯" withParams:tdParams];
    }
    else{
        [sender setTitle:@"完成" forState:UIControlStateNormal];
        self.hitText.hidden = NO;
        NSMutableDictionary *tdParams = [NSMutableDictionary dictionary];
        [QWGLOBALMANAGER statisticsEventId:@"x_bjzx_bj" withLable:@"资讯" withParams:tdParams];
    }
    sender.selected = !sender.selected;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"sortBtnClick"
                                                        object:sender
                                                      userInfo:nil];
}

@end
