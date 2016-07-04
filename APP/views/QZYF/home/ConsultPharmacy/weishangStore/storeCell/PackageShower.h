//
//  PackageShower.h
//  APP
//
//  Created by 李坚 on 16/5/11.
//  Copyright © 2016年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConsultStoreModel.h"

typedef void (^selectedCallBack) (NSString *branchProId);

@interface PackageShower : UIView

@property (weak, nonatomic) IBOutlet UIImageView *proImageView;
@property (weak, nonatomic) IBOutlet UILabel *proName;
@property (weak, nonatomic) IBOutlet UILabel *proPrice;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@property (copy,nonatomic) selectedCallBack selectedBlock;
@property (nonatomic, strong) ComboProductVo *comboProduct;

- (void)setShowerView:(ComboProductVo *)product;

@end
