//
//  NewConfirmOrderViewController.h
//  APP
//
//  Created by qw_imac on 16/3/26.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "QWBaseVC.h"
#import "MallCart.h"
@interface NewConfirmOrderViewController : QWBaseVC
@property (nonatomic, strong) NSString              *productsJson;
@property (nonatomic, strong) NSMutableArray        *chooseList;
@property (nonatomic, strong) NSMutableArray        *invariableList;
@property (nonatomic, strong) CartBranchVoModel     *branchModel;

@end
