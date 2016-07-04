//
//  ShowBranchChooseView.h
//  APP
//
//  Created by garfield on 16/6/20.
//  Copyright © 2016年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowBranchChooseView : UIView

@property (weak, nonatomic) IBOutlet UIButton *chooseButton;

- (void)showInView:(UIView *)aView animated:(BOOL)animated;
- (IBAction)dismiss:(id)sender;
@end
