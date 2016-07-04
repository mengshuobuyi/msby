//
//  LocationLoadingView.h
//  APP
//
//  Created by garfield on 16/1/13.
//  Copyright © 2016年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationLoadingView : UIView



- (void)showInView:(UIView *)aView animated:(BOOL)animated;

- (void)showSuccessHint;
- (void)showFailureHint;

@end
