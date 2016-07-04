//
//  MemberAllergyCell.m
//  APP
//
//  Created by PerryChen on 8/20/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "MemberAllergyCell.h"

@implementation MemberAllergyCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)action_selectAllergy:(UIButton *)sender {
    if ([self.cellDelegate respondsToSelector:@selector(changeAllergy:)]) {
        if (sender == self.btnTrue) {
            [self.cellDelegate changeAllergy:YES];
        } else {
            [self.cellDelegate changeAllergy:NO];
        }
    }
}
@end
