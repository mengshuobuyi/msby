//
//  ExpertFlowerViewController.h
//  wenYao-store
//
//  Created by Yang Yuexia on 16/1/7.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "QWBaseVC.h"

@interface ExpertFlowerViewController : QWBaseVC
@property (nonatomic ,strong) UINavigationController * navigationController;
@property (nonatomic, copy) void (^refreshBlock)(BOOL success);
@end
