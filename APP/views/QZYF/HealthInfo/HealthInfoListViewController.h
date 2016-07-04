//
//  HealthInfoListViewController.h
//  APP
//
//  Created by PerryChen on 1/4/16.
//  Copyright © 2016 carret. All rights reserved.
//

#import "QWBaseVC.h"
#import "ResortItem.h"

@interface HealthInfoListViewController : QWBaseVC
@property (weak, nonatomic) IBOutlet UILabel *lblContent;
@property (nonatomic, strong) ResortItem *itemSelect;
@property (nonatomic, strong) NSString *channelID;
@property (nonatomic, strong) NSString *channelName;
@property (nonatomic, assign) BOOL hadLoadInitialData;
@property (nonatomic, assign) BOOL isTopicChannel;
- (void)refreshData;
- (void)scrollToTop;
@end
