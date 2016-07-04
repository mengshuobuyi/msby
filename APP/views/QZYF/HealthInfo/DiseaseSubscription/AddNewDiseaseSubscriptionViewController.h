//
//  AddNewDiseaseSubscriptionViewController.h
//  wenyao
//
//  Created by Pan@QW on 14-9-25.
//  Copyright (c) 2014年 xiezhenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QWBaseVC.h"
#import "DiseaseSubscriptionViewController.h"

@protocol AddNewDiseaseProtocol <NSObject>

- (void)diseaseSubUpdate:(BOOL)needUpdate;

@end

@interface AddNewDiseaseSubscriptionViewController : QWBaseVC<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) id<AddNewDiseaseProtocol> delegate;

@property (nonatomic, strong) DiseaseSubscriptionViewController      *diseaseSubscriptionViewController;

@end
