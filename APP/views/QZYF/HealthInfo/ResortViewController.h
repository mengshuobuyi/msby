//
//  ResortViewController.h
//  APP
//
//  Created by PerryChen on 1/4/16.
//  Copyright © 2016 carret. All rights reserved.
//

#import "QWBaseVC.h"
#import "BYListBar.h"

@interface ResortViewController : QWBaseVC
@property (nonatomic,strong) NSMutableArray *listTop;
@property (nonatomic,strong) NSMutableArray *listBottom;
@property (nonatomic,strong) NSMutableArray *listBottomTwo;

@property (nonatomic,strong) BYListBar *listBar;
@property (nonatomic,strong) ResortItem *itemSelect;
@property (nonatomic,copy) void(^resortRefresh)(NSMutableArray *arrListTop, NSMutableArray *arrListCenter, NSMutableArray *arrListBottom, NSInteger indexSelect, ResortItem *itemSelect);
@end
