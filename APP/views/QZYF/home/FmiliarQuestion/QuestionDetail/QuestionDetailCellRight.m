//
//  QuestionDetailCellRight.m
//  APP
//
//  Created by qwfy0006 on 15/3/9.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "QuestionDetailCellRight.h"
#import "ProblemModel.h"

@implementation QuestionDetailCellRight
@synthesize content = content;

+ (CGFloat)getCellHeight:(id)data{
    
    if ([QWGLOBALMANAGER object:data isClass:[ProblemDetailModel class]]) {
        ProblemDetailModel *mod=(ProblemDetailModel*)data;
        

        NSString *str = mod.content;
        CGSize size = CGSizeZero;

        if (mod.role.integerValue==1) {
            size=[str sizeWithFont:fontSystem(kFontS1) constrainedToSize:CGSizeMake(APP_W-120, CGFLOAT_MAX)];
        }else if (mod.role.integerValue==2){
            size=[str sizeWithFont:fontSystem(kFontS4) constrainedToSize:CGSizeMake(APP_W-120, CGFLOAT_MAX)];
        }
        return 47.0+size.height;
        
        
    }
    return 0;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        if (self.bgView == nil) {
            self.bgView = [[UIImageView alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width -234, 15, 234, 42)];
            UIImage *image = [UIImage imageNamed:@"weChatBubble_Sending_Solid"];
            self.bgView.image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(25, 21, 25, 22) resizingMode:UIImageResizingModeStretch];
            [self.contentView addSubview:self.bgView];
        }
        
        if (self.content == nil) {
            self.content = [[QWLabel alloc] initWithFrame:CGRectMake(10, 0, 190, 34)];
            self.content.font = [UIFont systemFontOfSize:15];
            self.content.textColor = RGBHex(qwColor6);
            [self.bgView addSubview:self.content];
            self.content.tag = 2;
            self.bgView.tag = 3;
            self.content.backgroundColor = [UIColor clearColor];
            self.content.numberOfLines = 0;
        }
    }
    return self;
}

- (void)UIGlobal{
    
    [super UIGlobal];
    
    
    
    self.separatorLine.hidden = YES;
}

- (void)setCell:(id)data{
    [self UIGlobal];
    
    [super setCell:data];

    NSString *con;
    ProblemDetailModel *model = data;
    NSString *str = model.content;
    if (str.length > 0) {
        str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        con = str;
        if (str.length >= 100) {
            con = [str substringWithRange:NSMakeRange(0, 99)];
            con = [con stringByAppendingString:@"..."];
        }
    }
    
        //QUESTION
        CGSize size =[con sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(APP_W-120, CGFLOAT_MAX)];
        self.bgView.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width - size.width -27 - 10, self.bgView.frame.origin.y, size.width+30, 24+size.height);
        self.content.frame = CGRectMake(10, 5, size.width, size.height+10);
    
    
}


@end
