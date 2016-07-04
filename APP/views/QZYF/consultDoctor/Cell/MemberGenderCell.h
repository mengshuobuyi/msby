//
//  MemberGenderCell.h
//  APP
//
//  Created by PerryChen on 8/20/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "QWBaseCell.h"

@protocol ChangeGenderDelegate <NSObject>

- (void)changeGender:(BOOL)isMan;

@end

@interface MemberGenderCell : QWBaseCell
@property (weak, nonatomic) IBOutlet UIButton *btnMan;
@property (weak, nonatomic) IBOutlet UIButton *btnWoman;
@property (weak, nonatomic) id<ChangeGenderDelegate> cellDelegate;
- (IBAction)action_changeGender:(UIButton *)sender;

@end
