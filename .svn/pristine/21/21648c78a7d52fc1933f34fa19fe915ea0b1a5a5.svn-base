//
//  ComboProductCell.m
//  APP
//
//  Created by garfield on 16/6/15.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "ComboProductCell.h"

@implementation ComboProductCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"PackageScrollView" owner:self options:nil];
    self.packageScrollView = [nibView objectAtIndex:0];
    self.packageScrollView.clipsToBounds = YES;
    self.packageScrollView.frame = CGRectMake(0.0f, 38.5, self.bounds.size.width - 16.0f, self.frame.size.height - 46.0f);
    
    [self.backgroundConatiner addSubview:self.packageScrollView];
    [self.packageScrollView initCycleScrollView];
}

+ (CGFloat)getCellHeight:(id)data
{
    return 407.0f;
}

- (void)setCell:(id)data
{
    if([data objectAtIndex:0] != nil){
        self.packageScrollView.combo = data[0];
        [self.packageScrollView reloadData];
    }
}

@end
