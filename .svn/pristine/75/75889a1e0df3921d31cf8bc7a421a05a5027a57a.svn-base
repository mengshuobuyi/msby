//
//  CustomInfoAlertView.h
//  APP
//
//  Created by PerryChen on 9/16/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "QWBaseAlert.h"
typedef void (^DirectBlock)(BOOL success);
typedef void (^CancelBlock)(BOOL success);

@interface ChangeProductAlertView : QWBaseAlert
//@property (weak, nonatomic) IBOutlet UILabel *alertTitle;
@property (nonatomic, strong) DirectBlock blockDirect;
@property (nonatomic, strong) CancelBlock blockCancel;
+ (id)instance;
@end
