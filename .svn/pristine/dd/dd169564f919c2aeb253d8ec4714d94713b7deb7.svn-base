//
//  SlowDiseaseListCell.m
//  APP
//
//  Created by PerryChen on 8/22/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "SlowDiseaseListCell.h"

@implementation SlowDiseaseListCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)action_diseaseSelect:(UIButton *)sender {
    sender.selected = !sender.selected;
    if ([self.cellDelegate respondsToSelector:@selector(selectDiseaseCell:withIndex:)]) {
        if (sender.selected == YES) {
            [self.cellDelegate selectDiseaseCell:YES withIndex:self.intSelectedIndex];
        } else {
            [self.cellDelegate selectDiseaseCell:NO withIndex:self.intSelectedIndex];
        }
    }
}
@end
