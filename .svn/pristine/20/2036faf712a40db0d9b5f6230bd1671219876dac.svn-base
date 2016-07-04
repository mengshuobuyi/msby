//
//  SubmitAlertView.h
//  APP
//
//  Created by PerryChen on 8/25/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "QWBaseAlert.h"

@protocol SubmitAlertDelegate <NSObject>

- (void)actionSubmit;
- (void)actionFillup;

@end

@interface SubmitAlertView : QWBaseAlert
@property (nonatomic, weak) id<SubmitAlertDelegate> alertDelegate;
+ (id)instance;
//- (void)show;
@end
