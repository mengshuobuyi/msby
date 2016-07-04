//
//  SelectView.h
//  APP
//
//  Created by 李坚 on 15/12/30.
//  Copyright © 2015年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectFlagModel.h"

typedef void (^conformCallback) (SelectFlagModel *model);
typedef void (^dismissCallback) (id obj);


@class SelectView;

@interface SelectView : UIView
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HC1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HC2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HC3;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HC4;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HC5;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HC6;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (weak, nonatomic) IBOutlet UISwitch *switchOne;
@property (weak, nonatomic) IBOutlet UISwitch *switchTwo;
@property (weak, nonatomic) IBOutlet UISwitch *switchThree;
@property (weak, nonatomic) IBOutlet UIButton *conformBtn;
@property (weak, nonatomic) IBOutlet UIButton *clearBtn;
@property (weak, nonatomic) IBOutlet UIView *BKView;
@property (weak, nonatomic) IBOutlet UILabel *startMoneyLabel;

@property (copy, nonatomic) conformCallback callback;
@property (copy, nonatomic) dismissCallback discallback;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *normalLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *startMoneyLayout;

+ (SelectView *)showSelectViewInView:(UIView *)aView andModel:(SelectFlagModel *)model withCallBack:(conformCallback)callback disMissCallBacl:(dismissCallback)disCallback;

- (void)viewRemove;

@end
