//
//  FamiliarQuestionListCell.m
//  APP
//
//  Created by qwfy0006 on 15/3/6.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "FamiliarQuestionListCell.h"
#import "ProblemModel.h"
#import "UIImageView+WebCache.h"

@implementation FamiliarQuestionListCell

@synthesize imgUrl = imgUrl;
@synthesize question = question;
@synthesize answer = answer;
@synthesize answerBgView = answerBgView;
@synthesize answerImageView = answerImageView;

+ (CGFloat)getCellHeight:(id)data{
    if ([QWGLOBALMANAGER object:data isClass:[ProblemListModel class]]) {
        ProblemListModel *mod=(ProblemListModel*)data;
        
        NSString *question = mod.question;
        NSString *answer = mod.answer;
        
        if (mod.question.length > 0) {
            mod.question = [mod.question stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            if (mod.question.length >= 50) {
                question = [mod.question substringWithRange:NSMakeRange(0, 50)];
            }
        }
        
        if (mod.answer.length > 0) {
            mod.answer = [mod.answer stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            if (mod.answer.length >= 40) {
                answer = [mod.answer substringWithRange:NSMakeRange(0, 40)];
            }
            
        }
       
        //改变title视图
        CGSize titleSize = [QWGLOBALMANAGER sizeText:question font:fontSystem(kFontS1) limitWidth:APP_W-31];
        
        //改变content视图
        CGSize contentSize = [QWGLOBALMANAGER sizeText:answer font:fontSystem(kFontS4) limitWidth:APP_W-104];
        
        return 65 + titleSize.height + contentSize.height;
    }
    return 0;
}

- (void)UIGlobal{
    [super UIGlobal];
    
    self.imgUrl.layer.cornerRadius = 4.0;
    self.imgUrl.layer.masksToBounds = YES;
    self.answerBgView.layer.cornerRadius = 5.0;
    self.answerBgView.layer.masksToBounds = YES;
    self.question.textColor = RGBHex(qwColor6);
    self.answer.textColor = RGBHex(qwColor6);
    self.answerBgView.layer.cornerRadius = 4.0;
    self.answerBgView.layer.masksToBounds = YES;
    self.contentView.backgroundColor = [UIColor clearColor];
    self.separatorLine.backgroundColor = RGBHex(qwColor10);
    self.contentView.backgroundColor = RGBHex(qwColor4);
    self.answerBgView.hidden = YES;
    
    
}

- (void)awakeFromNib
{
    UIImage *image = [UIImage imageNamed:@"weChatBubble_Receiving_Solid"];
    self.answerImageView.image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(25, 21, 25, 22) resizingMode:UIImageResizingModeStretch];
}
- (void)setCell:(id)data{
    
    [self assignByModel:data];
    
    ProblemListModel *list = (ProblemListModel *)data;
    [self.imgUrl setImageWithURL:[NSURL URLWithString:list.imgUr] placeholderImage:[UIImage imageNamed:@"大家都在问-默认图片"]];
    
        NSString *titleStr = self.question.text;
        NSString *contentStr = self.answer.text;
        NSString *title;
        NSString *content;
    
        if (titleStr.length > 0) {
            titleStr = [titleStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            title = titleStr;
            if (titleStr.length >= 50) {
                title = [titleStr substringWithRange:NSMakeRange(0, 50)];
                title = [title stringByAppendingString:@"..."];
            }
        }
    
        if (contentStr.length > 0) {
            contentStr = [contentStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            content = contentStr;
            if (contentStr.length >= 40) {
                content = [contentStr substringWithRange:NSMakeRange(0, 40)];
                content = [content stringByAppendingString:@"..."];
            }
        }
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 3;
    NSDictionary *attributes = @{NSFontAttributeName:fontSystem(kFontS4),NSParagraphStyleAttributeName:paragraphStyle};
    self.answer.attributedText = [[NSAttributedString alloc] initWithString:self.answer.text attributes:attributes];
    
        //改变title和logo视图
    CGSize titleSize =[GLOBALMANAGER sizeText:title font:fontSystem(kFontS1) constrainedToSize:CGSizeMake(APP_W-31, CGFLOAT_MAX)];
    titleSize.height += 1;
        self.question.frame = CGRectMake(self.question.frame.origin.x, self.question.frame.origin.y, titleSize.width, titleSize.height);
        self.imgUrl.frame = CGRectMake(self.imgUrl.frame.origin.x, self.question.frame.origin.y+self.question.frame.size.height+14, self.imgUrl.frame.size.width, self.imgUrl.frame.size.height);
    
        //改变content视图
    CGSize contentSize =[GLOBALMANAGER sizeText:content font:fontSystem(kFontS4) constrainedToSize:CGSizeMake(APP_W-104, CGFLOAT_MAX)];
        float singleLabelHeight = 15.5;
        int line = contentSize.height/singleLabelHeight;
    
    contentSize.height += 1;
        self.answer.frame = CGRectMake(self.answer.frame.origin.x, self.question.frame.origin.y+self.question.frame.size.height+21, contentSize.width, contentSize.height+(line-1)*3);
    
//        self.answerBgView.frame = CGRectMake(self.answer.frame.origin.x-10, self.answer.frame.origin.y-11, self.answer.frame.size.width+30, self.answer.frame.size.height+21);
    
    DDLogVerbose(@"======%f",self.answer.frame.size.height+21);
   // 气泡 frame
    self.answerImageView.frame = CGRectMake(self.answer.frame.origin.x-15, self.answer.frame.origin.y-11, self.answer.frame.size.width+30, self.answer.frame.size.height+21);
    [self.contentView layoutSubviews];
    
    }


@end
