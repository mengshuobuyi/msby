//
//  MemberGenderCell.m
//  APP
//
//  Created by PerryChen on 8/20/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "MemberGenderCell.h"

@implementation MemberGenderCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)action_changeGender:(UIButton *)sender {
    if ([self.cellDelegate respondsToSelector:@selector(changeGender:)]) {
        if (sender == self.btnMan) {
            [self.cellDelegate changeGender:YES];
        } else {
            [self.cellDelegate changeGender:NO];
        }
    }
}
@end
