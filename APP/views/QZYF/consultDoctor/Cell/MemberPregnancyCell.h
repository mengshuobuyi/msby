//
//  MemberPregnancyCell.h
//  APP
//
//  Created by PerryChen on 8/20/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "QWBaseCell.h"
@protocol ChangePregnancyDelegate <NSObject>

- (void)changePregnancy:(BOOL)isPregnancy;

@end
@interface MemberPregnancyCell : QWBaseCell
@property (weak, nonatomic) IBOutlet UIButton *btnTrue;
@property (weak, nonatomic) IBOutlet UIButton *btnFalse;
@property (weak, nonatomic) id<ChangePregnancyDelegate> cellDelegate;
- (IBAction)action_choosePregnancy:(id)sender;

@end
