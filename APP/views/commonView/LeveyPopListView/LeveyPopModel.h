//
//  LeveyPopModel.h
//  APP
//
//  Created by carret on 15/8/26.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BasePrivateModel.h"
@interface LeveyPopModel : BasePrivateModel
@property(nonatomic,copy)NSString *title;
@property(nonatomic,assign)BOOL selected;
@property(nonatomic,copy)NSString *memberId;
@end
