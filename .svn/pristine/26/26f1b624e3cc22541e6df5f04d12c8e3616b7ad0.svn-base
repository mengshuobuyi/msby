//
//  NewUserCenterFooterView.m
//  APP
//
//  Created by qw_imac on 16/6/13.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "NewUserCenterFooterView.h"

@implementation NewUserCenterFooterView

- (void)awakeFromNib {
    // Initialization code
}

-(void)setView:(NSString *)tel {
    [_telBtn removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
    NSString *telStr = [NSString stringWithFormat:@"联系客服 %@",tel];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:telStr];
    NSRange strRange = {0,[str length]};
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
    [_telBtn setAttributedTitle:str forState:UIControlStateNormal];
}
@end
