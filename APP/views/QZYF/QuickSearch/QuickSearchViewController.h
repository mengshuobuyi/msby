//
//  QuickSearchViewController.h
//  wenyao
//
//  Created by Meng on 14-9-17.
//  Copyright (c) 2014年 xiezhenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QWBaseVC.h"
#import "MKNumberBadgeView.h"

typedef NS_ENUM(NSInteger,QuickSearchType) {
    QuickSearchMedicine,
    QuickSearchDisease,
    QuickSearchSymptom,
    QuickSearchHealthAssessment,
    QuickSearchHealthIndicators,
    QuickSearchHealthPlan,
    QuickSearchFactory
};

@interface QuickSearchViewController : QWBaseVC

@property (nonatomic, strong) MKNumberBadgeView *badgeView;
@end



@interface QuickSearchModel : BaseModel

@property (nonatomic ,strong) NSString *imageName;
@property (nonatomic ,strong) NSString *qucikTitle;
@property (nonatomic ,strong) NSString *qucikSubTitle;
@property (nonatomic, assign) QuickSearchType searchType;


@end