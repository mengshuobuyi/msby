//
//  CreditRuleDetailViewController.m
//  APP
//
//  Created by Martin.Liu on 15/12/1.
//  Copyright © 2015年 carret. All rights reserved.
//

#import "CreditRuleDetailViewController.h"
#import "ConstraintsUtility.h"
@interface CreditRuleDetailViewController ()
@property (strong, nonatomic) IBOutlet UILabel *ruleIntroTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *signinTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *shareTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *shopTitleLabel;

@property (strong, nonatomic) IBOutlet UIView *creditRuleScrollView;
@property (strong, nonatomic) IBOutlet UIView *creditRuleContainerView;
@property (strong, nonatomic) IBOutlet UILabel *shareContentLabel;
@property (strong, nonatomic) IBOutlet UILabel *shopContentLabel;

@end

@implementation CreditRuleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"规则说明";
}

- (void)UIGlobal
{
    self.view.backgroundColor = RGBHex(qwColor11);
    
    self.ruleIntroTitleLabel.font = [UIFont systemFontOfSize:kFontS4];
    self.ruleIntroTitleLabel.textColor = RGBHex(qwColor8);
    
    self.signinTitleLabel.font = [UIFont systemFontOfSize:kFontS1];
    self.signinTitleLabel.textColor = RGBHex(qwColor6);
    
    self.shareTitleLabel.font = [UIFont systemFontOfSize:kFontS1];
    self.shareTitleLabel.textColor = RGBHex(qwColor6);
    
    self.shopTitleLabel.font = [UIFont systemFontOfSize:kFontS1];
    self.shopTitleLabel.textColor = RGBHex(qwColor6);
    
    self.shareContentLabel.font = [UIFont systemFontOfSize:kFontS5];
    self.shareContentLabel.textColor = RGBHex(qwColor8);
    
    self.shopContentLabel.font = [UIFont systemFontOfSize:kFontS5];
    self.shopContentLabel.textColor = RGBHex(qwColor8);
    
    [self setCreditRuleViewWithDays:@[@1,@2,@3,@4,@5,@6,@7] credits:@[@4, @8, @12, @16, @20, @20, @20]];
}

- (void)setCreditRuleViewWithDays:(NSArray*)days credits:(NSArray*)credits
{
    for (UIView* view in self.creditRuleContainerView.subviews) {
        [view removeFromSuperview];
    }
    
    UIImage* cycleImage = [UIImage imageNamed:@"ic_rule"];
    CGFloat lineMargin = 4;
    CGFloat lineSpace = 22;
    CGFloat iconWidth = cycleImage.size.width;
    NSInteger maxCount = MAX(days.count, credits.count);
    if (maxCount == 0) {
        return;
    }
    UIView* lineView = [[UIView alloc] init];
    lineView.backgroundColor = RGBHex(qwColor1);
    
    [self.creditRuleContainerView addSubview:lineView];
    
    PREPCONSTRAINTS(lineView);
    CENTER_V(lineView);
    ALIGN_LEADING(lineView, 0);
    CONSTRAIN_HEIGHT(lineView, 1.5);
    CONSTRAIN_WIDTH(lineView, lineMargin*2 + lineSpace * (maxCount - 1) + iconWidth * maxCount);
    
    CGFloat spaceVLabelAndLine = 2;
    
    UIImageView* preImageView;
    UIImageView* nextImageView;
//    UIImageView* lastImageView;
    for (int i = 0; i < maxCount ; i++) {
        if (i == 0 && preImageView == nil) {
            preImageView = [[UIImageView alloc] init];
            preImageView.image = cycleImage;
            [self.creditRuleContainerView addSubview:preImageView];
            PREPCONSTRAINTS(preImageView);
            CENTER_V(preImageView);
            ALIGN_LEADING(preImageView, lineMargin);
            
        }
        else
        {
            nextImageView = [[UIImageView alloc] init];
            nextImageView.image = cycleImage;
            [self.creditRuleContainerView addSubview:nextImageView];
            PREPCONSTRAINTS(nextImageView);
            CENTER_V(nextImageView);
            LAYOUT_H_WITHOUTCENTER(preImageView, lineSpace, nextImageView);
        }
        
        if (maxCount == 0) {
//            lastImageView = preImageView;
        }
        else
        {
            if (i == maxCount - 1) {
                preImageView = nextImageView;
//                lastImageView = preImageView;
                nextImageView = nil;
            }
            else
            {
                if (i != 0) {
                    preImageView = nextImageView;
                    nextImageView = nil;
                }
            }
        }
        
        if (days.count > i) {
            // 添加天数
            UILabel* dayLabel = [[UILabel alloc] init];
            dayLabel.font = [UIFont systemFontOfSize:kFontS5];
            dayLabel.textColor = RGBHex(qwColor8);
            dayLabel.text = [NSString stringWithFormat:@"%@", days[i]];
            [self.creditRuleContainerView addSubview:dayLabel
             ];
            PREPCONSTRAINTS(dayLabel);
//            LAYOUT_V(dayLabel, 2, preImageView);
            NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:dayLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:dayLabel.superview attribute:NSLayoutAttributeTop multiplier:1 constant:0];
            [topConstraint install:UILayoutPriorityRequired];
            
            [CONSTRAINT_STACKING_V(dayLabel, preImageView, spaceVLabelAndLine) install:200];
            [CONSTRAINT_ALIGNING_PAIR_CENTERX(dayLabel, preImageView, 0) install];
        }
        
        if (credits.count > i) {
            // 添加积分
            UILabel* creditLabel = [[UILabel alloc] init];
            creditLabel.font = [UIFont systemFontOfSize:kFontS5];
            creditLabel.textColor = RGBHex(qwColor3);
            creditLabel.text = [NSString stringWithFormat:@"%@", credits[i]];
            [self.creditRuleContainerView addSubview:creditLabel
             ];
            PREPCONSTRAINTS(creditLabel);
//            LAYOUT_V(preImageView, 2, creditLabel);
            NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:creditLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationLessThanOrEqual toItem:creditLabel.superview attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
            [topConstraint install:UILayoutPriorityRequired];
            
            [CONSTRAINT_STACKING_V(preImageView, creditLabel, spaceVLabelAndLine) install:200];
            [CONSTRAINT_ALIGNING_PAIR_CENTERX(creditLabel, preImageView, 0) install];
        }
    }
//    ALIGN_TRAILING(lastImageView, lineMargin);
    
    UILabel* dayTitleLabel = [[UILabel alloc] init];
    dayTitleLabel.font = [UIFont systemFontOfSize:kFontS5];
    dayTitleLabel.textColor = RGBHex(qwColor8);
    dayTitleLabel.text = @"( 天 )";
    [self.creditRuleContainerView addSubview:dayTitleLabel];
    PREPCONSTRAINTS(dayTitleLabel);
    
    LAYOUT_H_WITHOUTCENTER(lineView, 5, dayTitleLabel);
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:dayTitleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:dayTitleLabel.superview attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    [topConstraint install:UILayoutPriorityRequired];
    
    [CONSTRAINT_STACKING_V(dayTitleLabel, lineView, spaceVLabelAndLine+1) install:200];
    
    UILabel* creditTitleLabel = [[UILabel alloc] init];
    creditTitleLabel.font = [UIFont systemFontOfSize:kFontS5];
    creditTitleLabel.textColor = RGBHex(qwColor8);
    creditTitleLabel.text = @"( 积分 )";
    [self.creditRuleContainerView addSubview:creditTitleLabel];
    PREPCONSTRAINTS(creditTitleLabel);
    
    LAYOUT_H_WITHOUTCENTER(lineView, 5, creditTitleLabel);
    NSLayoutConstraint *topConstraint2 = [NSLayoutConstraint constraintWithItem:creditTitleLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationLessThanOrEqual toItem:creditTitleLabel.superview attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    [topConstraint2 install:UILayoutPriorityRequired];
    
    [CONSTRAINT_STACKING_V(lineView, creditTitleLabel, spaceVLabelAndLine + 1) install:200];
    ALIGN_TRAILING(creditTitleLabel, 0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
