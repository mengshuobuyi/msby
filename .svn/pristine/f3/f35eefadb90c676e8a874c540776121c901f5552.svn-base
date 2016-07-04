//
//  MemberAllergyCell.h
//  APP
//
//  Created by PerryChen on 8/20/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "QWBaseCell.h"
@protocol ChangeAllergyDelegate <NSObject>

- (void)changeAllergy:(BOOL)isAllergy;

@end
@interface MemberAllergyCell : QWBaseCell
@property (weak, nonatomic) IBOutlet UIButton *btnTrue;
@property (weak, nonatomic) IBOutlet UIButton *btnFalse;
@property (weak, nonatomic) id<ChangeAllergyDelegate> cellDelegate;
- (IBAction)action_selectAllergy:(UIButton *)sender;

@end
