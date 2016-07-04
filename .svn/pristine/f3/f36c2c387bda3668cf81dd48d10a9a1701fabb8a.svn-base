//
//  QWLNActionSheet.h
//  wenyao
//
//  Created by Yan Qingyang on 15/4/11.
//  Copyright (c) 2015年 xiezhenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol QWLNActionSheetDelegate;

@protocol QWLNActionSheetDelegate <NSObject>
@optional
- (void)QWLNActionSheetDelegate:(NSMutableArray*)list;
@end

@interface QWLNActionSheet : UIView
@property (nonatomic, assign) id delegate;
@property (nonatomic, strong) NSMutableArray    *listTimes;
@property (nonatomic, strong) UIView *curView;
+(QWLNActionSheet *)instance;
+(QWLNActionSheet *)instanceWithDelegate:(id)delegate timeList:(NSMutableArray*)list showInView:(UIView *)aView;
- (void)show;
@end
