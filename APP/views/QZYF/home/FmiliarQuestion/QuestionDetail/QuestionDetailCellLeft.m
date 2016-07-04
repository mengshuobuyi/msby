//
//  QuestionDetailCellLeft.m
//  APP
//
//  Created by qwfy0006 on 15/3/9.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "QuestionDetailCellLeft.h"
#import "UIImageView+WebCache.h"
#import "ProblemModel.h"

@implementation QuestionDetailCellLeft
@synthesize imgUrl = imhUrl;
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

- (instancetype)initWithStyle:(UITableViewCellStyle)Style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:Style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        //白色气泡背景
        if (self.bgView == nil) {
            self.bgView = [[UIImageView alloc] initWithFrame:CGRectMake( 55, 15, 234, 42)];
            UIImage *image = [UIImage imageNamed:@"weChatBubble_Receiving_Solid"];
            self.bgView.image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(25, 21, 25, 22) resizingMode:UIImageResizingModeStretch];
            [self.contentView addSubview:self.bgView];
        }
        
        //content
        if (self.content == nil) {
            self.content = [[QWLabel alloc] initWithFrame:CGRectMake(18, 0, 190, 34)];
            self.content.font = [UIFont systemFontOfSize:14];
            self.content.textColor = RGBHex(qwColor6);
            self.content.tag = 2;
            self.content.tag = 3;
            self.content.backgroundColor = [UIColor clearColor];
            self.content.numberOfLines = 0;
            [self.bgView addSubview:self.content];
        }
        
        //头像
        if (self.imgUrl == nil) {
            self.imgUrl = [[UIImageView alloc]initWithFrame:CGRectMake(10, 16, 40, 40)];
            self.imgUrl.layer.cornerRadius = 4.0;
            self.imgUrl.layer.masksToBounds = YES;
            
            [self addSubview:self.imgUrl];
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
    
    //ANSWER
    CGSize size = [con sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(APP_W-120, CGFLOAT_MAX)];
    self.bgView.frame = CGRectMake(self.bgView.frame.origin.x, self.bgView.frame.origin.y, size.width+32, 25+size.height);
    self.content.frame = CGRectMake(self.content.frame.origin.x, 5, size.width, size.height +10);
}

@end
