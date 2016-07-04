//
//  StoreExpertTableCell.m
//  APP
//
//  Created by Martin.Liu on 16/6/20.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "StoreExpertTableCell.h"
#import "MAHrLineWithOnePix.h"
#import "cssex.h"
#import "Forum.h"
#import "UIImageView+WebCache.h"
#import "Constant.h"

#define QWLabelStyle(_label,_font,_color) {_label.font = [UIFont systemFontOfSize:kFontS##_font];_label.textColor = RGBHex(qwColor##_color);}
#define QWButtonStyle(_btn,_font,_color) QWSetButtonStyleState(_btn,UIControlStateNormal,_font,_color)
#define QWButtonStateStyle(_btn,_state,_font,_color) {_btn.titleLabel.font = [UIFont systemFontOfSize:kFontS##_font];[_btn setTitleColor:RGBHex(qwColor##_color) forState:_state];}

@interface StoreExpertTableCell()

@property (strong, nonatomic) IBOutlet UIImageView *expertImageView;
@property (strong, nonatomic) IBOutlet UILabel *expertNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *expertTypeLabel;
@property (strong, nonatomic) IBOutlet UILabel *expertSkillLabel;

@property (strong, nonatomic) IBOutlet UIView *topLineView;
@property (strong, nonatomic) IBOutlet UIView *leftLineView;
@property (strong, nonatomic) IBOutlet UIView *rightLineView;
@property (strong, nonatomic) IBOutlet UIView *bottomLineView;
@property (strong, nonatomic) IBOutlet UIView *bottomBlueLineView;
@property (strong, nonatomic) IBOutlet MAHrLineWithOnePix *bottomSeparatorLine;

@end

@implementation StoreExpertTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.expertImageView.image = ForumDefaultImage;
    self.expertImageView.layer.masksToBounds = YES;
    self.expertImageView.layer.cornerRadius = CGRectGetHeight(self.expertImageView.frame)/2;
    QWCSS(self.expertNameLabel, 3, 6);
    QWCSS(self.expertTypeLabel, 4, 2);
    QWCSS(self.expertSkillLabel, 4, 8);
}

- (void)setCell:(id)obj location:(MARCellLocation)locations
{
    self.topLineView.hidden = !(MARCellLocationTop & locations);
    BOOL isBottom = (MARCellLocationBottom & locations);
    self.bottomLineView.hidden = self.bottomBlueLineView.hidden = !isBottom;
    self.bottomSeparatorLine.hidden = isBottom;
    
    if ([obj isKindOfClass:[QWMbrInfoModel class]]) {
        QWMbrInfoModel* model = obj;
        [self.expertImageView setImageWithURL:[NSURL URLWithString:model.headImageUrl] placeholderImage:ForumDefaultImage];
        self.expertNameLabel.text = model.nickName;
        if (model.userType == PosterType_YaoShi) {
            self.expertTypeLabel.text = @"药师";
        }
        else
        {
            self.expertTypeLabel.text = nil;
        }
        NSArray* expertiseArray = [model.expertise componentsSeparatedByString:SeparateStr];
        if (expertiseArray.count == 0) {
            self.expertSkillLabel.text = @"擅长 : 营养保健/疾病调养";
        }
        else
        {
            if (expertiseArray.count > 2) {
                expertiseArray = [expertiseArray subarrayWithRange:NSMakeRange(0, 2)];
            }
            self.expertSkillLabel.text = [NSString stringWithFormat:@"擅长 : %@", [expertiseArray componentsJoinedByString:@"/"]];
        }
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
