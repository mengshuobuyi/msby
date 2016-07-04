//
//  TitleCollectionReusableView.m
//  APP
//
//  Created by Martin.Liu on 15/12/30.
//  Copyright © 2015年 carret. All rights reserved.
//

#import "TitleCollectionReusableView.h"

@implementation TitleCollectionReusableView

- (void)awakeFromNib {
    // Initialization code
    self.titleTextLabel.font = [UIFont systemFontOfSize:kFontS4];
    self.titleTextLabel.textColor = RGBHex(qwColor7);
}

@end
