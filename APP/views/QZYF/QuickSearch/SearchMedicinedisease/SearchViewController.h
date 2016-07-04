//
//  SearchViewController.h
//  APP
//
//  Created by 李坚 on 15/8/17.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QWBaseVC.h"

typedef enum  PageNumber {
    Enum_Page_First   = 0,
    Enum_Page_Second  = 1,
    Enum_Page_Third   = 2,
}Page_Number;


@interface SearchViewController : QWBaseVC

@property (assign, nonatomic) Page_Number pageNumber;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *LeadingSearchBarConstant;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBarView;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (strong, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;


@property (assign, nonatomic) BOOL isHideBranchList;

@property (strong, nonatomic) NSString *tjType;//0 首页 1 自查 2 药品 3 疾病 4 症状

@end
