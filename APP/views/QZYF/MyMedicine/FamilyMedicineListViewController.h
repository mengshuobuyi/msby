//
//  FamilyMedicineListViewController.h
//  APP
//
//  Created by carret on 15/8/17.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "QWBaseVC.h"
typedef void (^FamilySlowCallback)(BOOL success);
@interface FamilyMedicineListViewController : QWBaseVC
@property (weak, nonatomic) IBOutlet UITableView *familyListView;
@property (nonatomic, strong) FamilySlowCallback extCallback;
- (IBAction)pushTo:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *footerView;
@property (nonatomic, assign) BOOL fromSlowGuide;
@end
