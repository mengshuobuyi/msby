//
//  KnowLedgeViewController.h
//  wenyao
//
//  Created by Meng on 14-9-29.
//  Copyright (c) 2014年 xiezhenghong. All rights reserved.
//

#import "QWBaseVC.h"

@interface KnowLedgeViewController : QWBaseVC

@property (nonatomic, strong) NSDictionary  *source;
@property (nonatomic ,copy) NSString * knowledgeTitle;
@property (nonatomic ,strong) NSString * knowledgeContent;
@property(nonatomic,strong)NSString *viewtitle;

@end
