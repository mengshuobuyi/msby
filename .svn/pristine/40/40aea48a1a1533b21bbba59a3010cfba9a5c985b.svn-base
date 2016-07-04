//
//  PharmacistCollectionCell.m
//  APP
//
//  Created by Martin.Liu on 15/12/30.
//  Copyright © 2015年 carret. All rights reserved.
//

#import "PharmacistCollectionCell.h"
#import "Forum.h"
#import "UIImageView+WebCache.h"
#import "Constant.h"
@interface PharmacistCollectionCell()
@property (strong, nonatomic) IBOutlet UIView *backgoundView;
@property (strong, nonatomic) IBOutlet UIImageView *pharmacistImageView;
@property (strong, nonatomic) IBOutlet UILabel *pharmacistNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *pharmacyNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *praiseCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *postCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *skillLabelOne;
@property (strong, nonatomic) IBOutlet UILabel *skillLabelTwo;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *constraint_careBtnTop;  // default is 9
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *constraint_leading;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *constraint_trailing;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *constraint_careBtnWidth;     // default is 35


@end

@implementation PharmacistCollectionCell

- (void)awakeFromNib {
    // Initialization code
    [self setup];
    
    if (APP_W > 320) {
        self.constraint_careBtnWidth.constant = AutoValue(35);
        if (IS_IPHONE_6P) {
            self.constraint_careBtnTop.constant = 40;
        }
        else
            self.constraint_careBtnTop.constant = 30;
    }
}

- (void)setup
{
    self.pharmacistImageView.layer.masksToBounds = YES;
    self.pharmacistImageView.layer.cornerRadius = CGRectGetHeight(self.pharmacistImageView.frame)/2;
    
    self.careBtn.layer.masksToBounds = YES;
    self.careBtn.layer.cornerRadius = 3;
    self.careBtn.backgroundColor = RGBHex(qwColor1);
    
    self.skillLabelOne.layer.masksToBounds = YES;
    self.skillLabelOne.layer.cornerRadius = 3;
    self.skillLabelOne.layer.borderColor = RGBHex(qwColor10).CGColor;
    self.skillLabelOne.layer.borderWidth = 1;
    self.skillLabelTwo.layer.masksToBounds = YES;
    self.skillLabelTwo.layer.cornerRadius = 3;
    self.skillLabelTwo.layer.borderColor = RGBHex(qwColor10).CGColor;
    self.skillLabelTwo.layer.borderWidth = 1;
    
//    self.layer.masksToBounds = YES;
//    self.layer.cornerRadius = 4;
    self.backgoundView.layer.masksToBounds = YES;
    self.backgoundView.layer.cornerRadius = 4;
    
    self.backgroundColor = RGBHex(qwColor4);
}

/**
 *  3.1.0 UI优化
 */
- (void)hiddenCareBtn:(BOOL)hidden
{
    self.careBtn.hidden = hidden;
    if (APP_W == 320) {
        if (hidden) {
            self.constraint_careBtnTop.constant = -2;
        }
        else
        {
            self.constraint_careBtnTop.constant = 11;
        }
    }
}

- (void)setIndexPath:(NSIndexPath*)indexPath
{
    /**
     *  3.1.0 UI优化
     */
//    if (indexPath.section == 0) {
//        self.backgroundColor = [UIColor whiteColor];
//        self.backgoundView.backgroundColor = RGBHex(qwColor11);
//    }
//    else
//    {
//        self.backgroundColor = RGBHex(qwColor11);
//        self.backgoundView.backgroundColor = [UIColor whiteColor];
//    }

    self.backgroundColor = RGBHex(qwColor11);
    self.backgoundView.backgroundColor = [UIColor whiteColor];
    
    if (indexPath.row % 2 == 0) {
        self.constraint_leading.constant = 15;
        self.constraint_trailing.constant = 7;
    }
    else
    {
        self.constraint_leading.constant = 7;
        self.constraint_trailing.constant = 15;
    }
}

- (void)setCell:(id)obj
{
    if ([obj isKindOfClass:[QWExpertInfoModel class]]) {
        QWExpertInfoModel* expertInfo = obj;
        [self.pharmacistImageView setImageWithURL:[NSURL URLWithString:expertInfo.headImageUrl] placeholderImage:ForumDefaultImage];
        self.pharmacistNameLabel.text = expertInfo.nickName;
        if (expertInfo.userType == PosterType_YingYangShi) {
            self.pharmacyNameLabel.text = @"营养师";
        }
        else
        {
            self.pharmacyNameLabel.text = StrDFString(expertInfo.groupName, @"专业药师");
        }
        
        self.praiseCountLabel.text = [NSString stringWithFormat:@"%ld", expertInfo.upVoteCount];
        self.postCountLabel.text = [NSString stringWithFormat:@"%ld", expertInfo.postCount];
        if (expertInfo.isAttnFlag) {
            self.careBtn.enabled = YES;
            [self.careBtn setTitle:@"取消关注" forState:UIControlStateNormal];
            self.careBtn.backgroundColor = RGBHex(qwColor9);
        }
        else
        {
            self.careBtn.enabled = YES;
            [self.careBtn setTitle:@"关注" forState:UIControlStateNormal];
            self.careBtn.backgroundColor = RGBHex(qwColor1);
        }
        NSArray* expertiseArray = nil;
        if (!StrIsEmpty(expertInfo.expertise)) {
            expertiseArray = [expertInfo.expertise componentsSeparatedByString:SeparateStr];
        }
        switch (MIN(expertiseArray.count, 2)) {
            case 0:
                self.skillLabelOne.hidden = NO;
                self.skillLabelTwo.hidden = NO;
                self.skillLabelOne.text = @"营养保健";
                self.skillLabelTwo.text = @"疾病调养";
                break;
            case 1:
                self.skillLabelOne.hidden = NO;
                self.skillLabelTwo.hidden = YES;
                self.skillLabelOne.text = expertiseArray[0];
                break;
            case 2:
                self.skillLabelOne.hidden = NO;
                self.skillLabelTwo.hidden = NO;
                self.skillLabelOne.text = expertiseArray[0];
                self.skillLabelTwo.text = expertiseArray[1];
                break;
        }
    }
}

@end
