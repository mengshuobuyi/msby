//
//  ProjectTemplateForthTableViewCell.m
//  APP
//
//  Created by garfield on 15/11/9.
//  Copyright © 2015年 carret. All rights reserved.
//

#import "ProjectTemplateForthTableViewCell.h"
#import "UIButton+WebCache.h"

@implementation ProjectTemplateForthTableViewCell

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
        }
    }
    self.button1.tag = 0 + 400;
    self.button2.tag = 1 + 400;
    [self.button1 addTarget:target action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.button2 addTarget:target action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)UIGlobal{
    self.contentView.backgroundColor=RGBHex(qwColor11);
}
- (void)prepareForReuse
{
    [self.button1 setBackgroundImage:nil forState:UIControlStateNormal];
    [self.button2 setBackgroundImage:nil forState:UIControlStateNormal];
}


@end
