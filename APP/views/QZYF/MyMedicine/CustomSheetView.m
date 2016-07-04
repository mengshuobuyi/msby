//
//  CustomSheetView.m
//  APP
//
//  Created by carret on 15/8/30.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "CustomSheetView.h"
#define CUS_SCREENINSET 0
#define CUS_HEADER_HEIGHT 0
#define CUSRADIUS 0.
#define FOOTERHIGHT 176
@implementation CustomSheetView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)awakeFromNib
{
    [super awakeFromNib];
    CGRect rect = [[UIScreen mainScreen] bounds];
    rect.size.height -= 64;
//    _footerView.frame =  CGRectMake(0,
//                                                               rect.size.height - FOOTERHIGHT,
//                                                               rect.size.width - 2 * CUS_HEADER_HEIGHT,
//                                                               FOOTERHIGHT);
    [self.one addTarget:self action:@selector(didslevt:) forControlEvents:UIControlEventTouchUpInside];
      [self.two addTarget:self action:@selector(didslevt:) forControlEvents:UIControlEventTouchUpInside];
      [self.three addTarget:self action:@selector(didslevt:) forControlEvents:UIControlEventTouchUpInside];
      [self.four addTarget:self action:@selector(didslevt:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)fadeIn
{
    __block CGRect rect = _footerView.frame;
    rect.origin.y += rect.size.height;
    _footerView.frame = rect;
    self.alpha = 0;
    [UIView animateWithDuration:.35 animations:^{
        self.alpha = 1;
        rect = _footerView.frame;
        rect.origin.y -= rect.size.height;
        _footerView.frame = rect;
    }];
}

- (void)fadeOut
{
    [UIView animateWithDuration:.35 animations:^{
        self.alpha = 0.0;
        CGRect rect = _footerView.frame;
        rect.origin.y += rect.size.height;
        _footerView.frame = rect;
        
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

- (void)didslevt:(id)sender {
    UIButton *btn = (UIButton *)sender;
        if (self.delegate && [self.delegate respondsToSelector:@selector(customSheetView:didSelectedIndex:)]) {
    [self.delegate customSheetView:self didSelectedIndex:btn.tag];
        }
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    // tell the delegate the cancellation
    if (self.delegate && [self.delegate respondsToSelector:@selector(customSheetViewDidCancel)]) {
        [self.delegate customSheetViewDidCancel];
    }
    
    // dismiss self
    [self fadeOut];
}
@end
