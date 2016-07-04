//
//  MemberPregnancyCell.m
//  APP
//
//  Created by PerryChen on 8/20/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "MemberPregnancyCell.h"

@implementation MemberPregnancyCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)action_choosePregnancy:(id)sender {
    if ([self.cellDelegate respondsToSelector:@selector(changePregnancy:)]) {
        if (sender == self.btnTrue) {
            [self.cellDelegate changePregnancy:YES];
        } else {
            [self.cellDelegate changePregnancy:NO];
        }
    }
}
@end
