//
//  ProjectTemplateSecondTableViewCell.m
//  APP
//
//  Created by garfield on 15/8/25.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "ProjectTemplateSecondTableViewCell.h"
#import "UIButton+WebCache.h"
#import "ConfigInfo.h"

@implementation ProjectTemplateSecondTableViewCell


- (void)awakeFromNib
{
    [super awakeFromNib];
    _buttonWidth.constant = APP_W / 2.0;
}

- (void)setCell:(id)data withTarget:(id)target
{
    TemplateVoModel *area = (TemplateVoModel *)data;
    for(NSInteger index = 0; index < area.pos.count ; ++index)
    {
        TemplatePosVoModel *model = area.pos[index];
        if(index == 0) {
            [self.button1 setBackgroundImageWithURL:[NSURL URLWithString:model.imgUrl] forState:UIControlStateNormal placeholderImage:nil];
            self.button1.obj = model;
        }else if (index == 1) {
            [self.button2 setBackgroundImageWithURL:[NSURL URLWithString:model.imgUrl] forState:UIControlStateNormal placeholderImage:nil];
            self.button2.obj = model;
        }else if (index == 2) {
            [self.button3 setBackgroundImageWithURL:[NSURL URLWithString:model.imgUrl] forState:UIControlStateNormal placeholderImage:nil];
            self.button3.obj = model;
        }else if (index == 3) {
            [self.button4 setBackgroundImageWithURL:[NSURL URLWithString:model.imgUrl] forState:UIControlStateNormal placeholderImage:nil];
            self.button4.obj = model;
        }
    }
    self.button1.tag = 0 + 200;
    self.button2.tag = 1 + 200;
    self.button3.tag = 2 + 200;
    self.button4.tag = 3 + 200;
    
    [self.button1 addTarget:target action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.button2 addTarget:target action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.button3 addTarget:target action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.button4 addTarget:target action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)prepareForReuse
{
    [self.button1 setBackgroundImage:nil forState:UIControlStateNormal];
    [self.button2 setBackgroundImage:nil forState:UIControlStateNormal];
    [self.button3 setBackgroundImage:nil forState:UIControlStateNormal];
    [self.button4 setBackgroundImage:nil forState:UIControlStateNormal];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _buttonHeight.constant  = (self.frame.size.height-7.0)/ 2.0;
}

@end
