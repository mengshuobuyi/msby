//
//  ChooseHomeMedicineViewController.h
//  wenyao
//
//  Created by garfield on 15/4/9.
//  Copyright (c) 2015年 xiezhenghong. All rights reserved.
//

#import "QWBaseVC.h"
#import "WYChooseMyDrugModel.h"
@interface ChooseHomeMedicineViewController : QWBaseVC
<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UILabel *lblAddTTL;
}

@property (nonatomic,copy) void(^selectBlock)(WYChooseMyDrugModel* model);
@end
