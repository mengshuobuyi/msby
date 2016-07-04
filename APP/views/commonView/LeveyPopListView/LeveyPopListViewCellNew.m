//
//  LeveyPopListViewCell.m
//  LeveyPopListViewDemo
//
//  Created by Levey on 2/21/12.
//  Copyright (c) 2012 Levey. All rights reserved.
//

#import "LeveyPopListViewCellNew.h"

@implementation LeveyPopListViewCellNew

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.textLabel.textColor = [UIColor whiteColor];
        self.textLabel.font = [UIFont systemFontOfSize:15];
        self.selectImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 30, 30)];
       
     
        [self addSubview:self.selectImg];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _bgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _bgBtn.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        [self addSubview:_bgBtn];
        
       _addMemberLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.selectImg.frame.origin.x+self.selectImg.frame.size.width+15, 15, 320, 19)];
        _addMemberLabel.textColor = RGBHex(qwColor6);
        [self addSubview:_addMemberLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = CGRectOffset(self.imageView.frame, 6, 0);
    self.textLabel.frame = CGRectOffset(self.textLabel.frame, 6, 0);
}


- (void)UIGlobal{
    [super UIGlobal];
    [self setSelectedBGColor:RGBHex(qwColor10)];
}
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated
//{
//    [super setSelected:selected animated:animated];
//}

@end
