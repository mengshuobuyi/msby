//
//  ExpertCollectionCell.m
//  APP
//
//  Created by Martin.Liu on 16/4/7.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "ExpertCollectionCell.h"
#import "Forum.h"
#import "UIImageView+WebCache.h"
#import "Constant.h"

@interface ExpertCollectionCell()
@property (strong, nonatomic) IBOutlet UIView *backgoundView;
@property (strong, nonatomic) IBOutlet UILabel *pharmacyNameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *pharmacistImageView;
@property (strong, nonatomic) IBOutlet UILabel *pharmacistNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *expertTypeLabel;
@property (strong, nonatomic) IBOutlet UILabel *expertiseLabel;

@property (strong, nonatomic) IBOutlet UILabel *praiseCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *postCountLabel;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *constraint_leading;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *constraint_trailing;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *constraint_headImageTop;     // 9
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *constraint_nameViewTop;      // 10
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *constraint_expertiseTop;        //7
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *constraint_countsViewTop;    //6
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *constraint_careBtnTop;   // 6


@end

@implementation ExpertCollectionCell

- (void)awakeFromNib {
    // Initialization code
    [self setup];
}

- (void)setup
{
    // 所属药房、认证药师
    self.pharmacyNameLabel.font = [UIFont systemFontOfSize:kFontS4];
    self.pharmacyNameLabel.textColor = RGBHex(qwColor4);
    // 专家昵称
    self.pharmacistNameLabel.font = [UIFont systemFontOfSize:kFontS3];
    self.pharmacistNameLabel.textColor = RGBHex(qwColor6);
    // 药师、营养师
    self.expertTypeLabel.font = [UIFont systemFontOfSize:kFontS4];
    self.expertTypeLabel.textColor = RGBHex(qwColor3);
    // 擅长
    self.expertiseLabel.font = [UIFont systemFontOfSize:kFontS5];
    self.expertiseLabel.textColor = RGBHex(qwColor8);
    // 头像
    self.pharmacistImageView.layer.masksToBounds = YES;
    self.pharmacistImageView.layer.cornerRadius = CGRectGetHeight(self.pharmacistImageView.frame)/2;
    // 送花数量
    self.praiseCountLabel.font = [UIFont systemFontOfSize:kFontS5];
    self.praiseCountLabel.textColor = RGBHex(qwColor8);
    // 发表文章数
    self.postCountLabel.font = [UIFont systemFontOfSize:kFontS5];
    self.postCountLabel.textColor = RGBHex(qwColor8);
    // 关注按钮
    self.careBtn.titleLabel.font = [UIFont systemFontOfSize:kFontS1];
    [self.careBtn setTitleColor:RGBHex(qwColor1) forState:UIControlStateNormal];
    self.careBtn.layer.masksToBounds = YES;
    self.careBtn.layer.cornerRadius = 4;
    self.careBtn.layer.borderWidth = 1.0 / [UIScreen mainScreen].scale;
    self.careBtn.layer.borderColor = RGBHex(qwColor1).CGColor;
    self.careBtn.backgroundColor = [UIColor clearColor];
    
    self.backgoundView.layer.masksToBounds = YES;
    self.backgoundView.layer.cornerRadius = 4;
    
    self.backgroundColor = RGBHex(qwColor4);
    // 王娟老大不喜欢这种的
//    if (IS_IPHONE_6P || IS_IPHONE_6) {
//        self.constraint_headImageTop.constant = AutoValue(9) + AutoValue(20);
//        self.constraint_nameViewTop.constant = AutoValue(10);
//        self.constraint_expertiseTop.constant = AutoValue(7);
//        self.constraint_countsViewTop.constant = AutoValue(6);
//        self.constraint_careBtnTop.constant = AutoValue(6);
//    }
}

/**
 *  3.1.0 UI优化
 */
- (void)hiddenCareBtn:(BOOL)hidden
{
    self.careBtn.hidden = hidden;
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
    
    if ([OS_VERSION floatValue]< 8) {
        self.constraint_leading.constant = self.constraint_trailing.constant = 10;
    }
    else
    {
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
}

- (void)setCell:(id)obj
{
    if ([obj isKindOfClass:[QWExpertInfoModel class]]) {
        QWExpertInfoModel* expertInfo = obj;
        [self.pharmacistImageView setImageWithURL:[NSURL URLWithString:expertInfo.headImageUrl] placeholderImage:ForumDefaultImage];
        self.pharmacistNameLabel.text = expertInfo.nickName;
        if (expertInfo.userType == PosterType_YaoShi) {
            self.expertTypeLabel.text = @"药师";
            self.pharmacyNameLabel.text = StrDFString(expertInfo.groupName, @"认证药师");
        }
        else
        {
            self.expertTypeLabel.text = @"营养师";
            self.pharmacyNameLabel.text = nil;
        }
        
        self.praiseCountLabel.text = [NSString stringWithFormat:@"%ld", expertInfo.upVoteCount];
        self.postCountLabel.text = [NSString stringWithFormat:@"%ld", expertInfo.postCount];
        if (expertInfo.isAttnFlag) {
            self.careBtn.enabled = YES;
            [self.careBtn setTitle:@"取消关注" forState:UIControlStateNormal];
        }
        else
        {
            self.careBtn.enabled = YES;
            [self.careBtn setTitle:@"关注" forState:UIControlStateNormal];
        }
        // 如果是空字符串
        if (StrIsEmpty(expertInfo.expertise)) {
            self.expertiseLabel.text = @"擅长 : 营养保健/疾病调养";
        }
        else
        {
            NSArray* expertiseArray = [expertInfo.expertise componentsSeparatedByString:SeparateStr];
            if (expertiseArray.count == 0) {
                self.expertiseLabel.text = @"擅长 : 营养保健/疾病调养";
            }
            else
            {
                if (expertiseArray.count > 2) {
                    expertiseArray = [expertiseArray subarrayWithRange:NSMakeRange(0, 2)];
                }
                self.expertiseLabel.text = [NSString stringWithFormat:@"擅长 : %@", [expertiseArray componentsJoinedByString:@"/"]];
            }
        }
//        self.expertiseLabel.text = [NSString stringWithFormat:@"擅长 : %@", StrDFString([expertInfo.expertise stringByReplacingOccurrencesOfString:SeparateStr withString:@"/"], @"营养保健/疾病调养")];
    }
}


@end
