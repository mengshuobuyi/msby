//
//  PharmacyDetailViewController.h
//  wenyao
//
//  Created by xiezhenghong on 14-10-24.
//  Copyright (c) 2014年 xiezhenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QWBaseVC.h"
#import "Box.h"

@interface PharmacyDetailViewController : QWBaseVC<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) IBOutlet  UILabel     *titleLabel;

@property (nonatomic, strong) IBOutlet  UIImageView *OTCImage;
@property (nonatomic, strong) IBOutlet  UILabel     *OTCLabel;
 @property (nonatomic, strong) IBOutlet  UIView      *headerView;

@property (nonatomic, strong) IBOutlet  UILabel         *recipeLabel;
@property (nonatomic, strong) IBOutlet  UIImageView     *recipeImage;

@property (nonatomic, strong) IBOutlet  UILabel     *useNameLabel;
@property (nonatomic, strong) IBOutlet  UILabel     *useageLabel;

@property(nonatomic ,copy)NSString *memberId;
@property (weak, nonatomic) IBOutlet UIView *noDataView;
 
@property (nonatomic, strong) IBOutlet  UIView      *footerView;
@property (nonatomic, strong) QueryMyBoxModel       *boxModel;
@property (nonatomic, copy) void(^changeMedicineInformation)(QueryMyBoxModel *boxModel);
- (IBAction)editUseMether:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *tableviewSim;
- (IBAction)expandEffect:(UIButton *)sender;
- (IBAction)pushIntoMedicineDetail:(id)sender;
- (IBAction)medcineDetail:(id)sender;

@end
