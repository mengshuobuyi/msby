//
//  FinderRelatedViewController.h
//  APP
//
//  Created by 李坚 on 16/1/22.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "QWSearchBaseVC.h"

@interface FinderRelatedViewController : QWSearchBaseVC

@property (nonatomic, strong) NSString *keyWord;//用于发现搜索查看全部功能传String类型值
@property (nonatomic, assign) NSInteger selectedSection;//0.疾病 1.症状 2.药品 3.问答

@end
