//
//  LocationPermissionView.h
//  APP
//
//  Created by garfield on 16/1/13.
//  Copyright © 2016年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationPermissionView : UIView

@property (weak, nonatomic) IBOutlet UIView *containerCover;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *settingButton;

- (void)showInView:(UIView *)aView animated:(BOOL)animated;
- (void)fadeOut;

@end
