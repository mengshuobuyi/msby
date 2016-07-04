//
//  SelectView.m
//  APP
//
//  Created by 李坚 on 15/12/30.
//  Copyright © 2015年 carret. All rights reserved.
//

#import "SelectView.h"

@implementation SelectView


+ (SelectView *)showSelectViewInView:(UIView *)aView andModel:(SelectFlagModel *)model withCallBack:(conformCallback)callback disMissCallBacl:(dismissCallback)disCallback{
    
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"SelectView" owner:nil options:nil];
    SelectView *selectView = [nibView objectAtIndex:0];
    selectView.frame = CGRectMake(0, 104, APP_W, APP_H - 84.0f);
    selectView.callback = callback;
    selectView.discallback = disCallback;
    selectView.alpha = 0.0f;
    selectView.segmentControl.selectedSegmentIndex = model.transportType;
    selectView.switchOne.on = model.transCostEnable;
    selectView.switchTwo.on = model.startCostEnable;
    selectView.switchThree.on = model.couponEnable;
    if(selectView.segmentControl.selectedSegmentIndex == 2){
        selectView.startMoneyLabel.hidden = YES;
        selectView.switchTwo.hidden = YES;
        selectView.normalLayout.constant = - 32.5f;
    }else{
        selectView.startMoneyLabel.hidden = NO;
        selectView.switchTwo.hidden = NO;
        selectView.normalLayout.constant = 12.0f;
    }
    
    [[[UIApplication sharedApplication] keyWindow] addSubview:selectView];
    [[[UIApplication sharedApplication] keyWindow] bringSubviewToFront:selectView];
    [UIView animateWithDuration:0.25 animations:^{
        selectView.alpha = 1.0;
    }];
    return selectView;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.clearBtn.layer.masksToBounds = YES;
    self.clearBtn.layer.borderColor = RGBHex(qwColor9).CGColor;
    self.clearBtn.layer.borderWidth = 0.5f;
    self.clearBtn.layer.cornerRadius = 2.5f;
    
    self.conformBtn.layer.cornerRadius = 2.5f;
    
    [self.conformBtn addTarget:self action:@selector(sure:) forControlEvents:UIControlEventTouchUpInside];
    [self.clearBtn addTarget:self action:@selector(clear:) forControlEvents:UIControlEventTouchUpInside];
    self.BKView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.75];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewRemove)];
    [self.BKView addGestureRecognizer:tap];
    
    _segmentControl.segmentedControlStyle= UISegmentedControlStyleBar;//设置
    _segmentControl.tintColor= RGBHex(qwColor1);
    _segmentControl.selectedSegmentIndex = 0;
    
    NSDictionary *dicNormal = [NSDictionary dictionaryWithObjectsAndKeys:RGBHex(qwColor1),UITextAttributeTextColor,  [UIFont systemFontOfSize:kFontS6],UITextAttributeFont ,[UIColor clearColor],UITextAttributeTextShadowColor ,nil];
    [_segmentControl setTitleTextAttributes:dicNormal forState:UIControlStateNormal];
    
    NSDictionary *dicSelected = [NSDictionary dictionaryWithObjectsAndKeys:RGBHex(qwColor4),UITextAttributeTextColor,  [UIFont systemFontOfSize:kFontS6],UITextAttributeFont ,[UIColor clearColor],UITextAttributeTextShadowColor ,nil];
    [_segmentControl setTitleTextAttributes:dicSelected forState:UIControlStateSelected];
    
    _HC1.constant = 0.5f;
    _HC2.constant = 0.5f;
    _HC3.constant = 0.5f;
    _HC4.constant = 0.5f;
    _HC5.constant = 0.5f;
    _HC6.constant = 0.5f;
    
    
    
    [_segmentControl addTarget:self action:@selector(segementAction:) forControlEvents:UIControlEventValueChanged];
}

- (void)segementAction:(UISegmentedControl *)control{
    
    if(control.selectedSegmentIndex == 2){
        self.startMoneyLabel.hidden = YES;
        self.switchTwo.hidden = YES;
        self.normalLayout.constant = - 32.5f;
    }else{
        self.startMoneyLabel.hidden = NO;
        self.switchTwo.hidden = NO;
        self.normalLayout.constant = 12.0f;
    }
}

- (void)sure:(id)sender{
    
    [self viewRemove];

    if(self.callback){
        
        SelectFlagModel *model = [SelectFlagModel new];
        switch (_segmentControl.selectedSegmentIndex) {
            case 0:
                model.transportType = Enum_Default;
                break;
            case 1:
                model.transportType = Enum_GetDoor;
                break;
            case 2:
                model.transportType = Enum_SameCity;
                break;
        }
        model.transCostEnable = _switchOne.on;
        if(_segmentControl.selectedSegmentIndex == 2){
            model.startCostEnable = NO;
        }else{
            model.startCostEnable = _switchTwo.on;
        }
        model.couponEnable = _switchThree.on;
        self.callback(model);
    }
}

- (void)clear:(id)sender{
    
    _segmentControl.selectedSegmentIndex = 0;
    self.startMoneyLabel.hidden = NO;
    self.switchTwo.hidden = NO;
    self.normalLayout.constant = 12.0f;
    _switchOne.on = NO;
    _switchTwo.on = NO;
    _switchThree.on = NO;
}

- (void)viewRemove{
    
    if(self.discallback){
        self.discallback(nil);
    }
    
    [UIView animateWithDuration:0.25f animations:^{
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
    
    
}

@end
