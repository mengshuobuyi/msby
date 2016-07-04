//
//  MallBranchHeaderView.m
//  APP
//
//  Created by 李坚 on 16/5/4.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "MallBranchHeaderView.h"

@implementation MallBranchHeaderView

+ (MallBranchHeaderView *)getView{
    
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"MallBranchHeaderView" owner:self options:nil];
    MallBranchHeaderView *headView = [nibView objectAtIndex:0];
    
    return headView;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.backgroundColor = RGBHex(qwColor1);
    
    self.branchImageView.layer.masksToBounds = YES;
    self.branchImageView.layer.cornerRadius = 40.0f;
    
    self.noticeView.backgroundColor = RGBHex(qwColor19);
}

@end
