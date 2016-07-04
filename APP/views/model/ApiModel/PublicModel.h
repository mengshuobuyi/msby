//
//  PublicModel.h
//  APP
//
//  Created by Meng on 15/3/16.
//  Copyright (c) 2015年 carret. All rights reserved.
//

/**
 *  存放一些公共使用的model
 */


#import "BaseAPIModel.h"
#import <CoreLocation/CLLocation.h>
#import "MapInfoModel.h"


@interface PublicModel : BaseAPIModel

@end

/**
 *  @brief 3.8.2	获取省市区的编码
 *
 *  add by meng(new framework)
 */
//
//@interface PharmacyGetAreaCodeModel : PublicModel
//@property (nonatomic ,strong) NSString *cityCode;
//@property (nonatomic ,strong) NSString *provinceCode;
//@property (nonatomic ,strong) NSString *countyCode ;
//
//@end
//
//
//
//@interface AreaCodeAndMapInfoModel : PublicModel
//
//@property (nonatomic, strong) MapInfoModel *mapInfoModel;
//@property (nonatomic, strong) PharmacyGetAreaCodeModel *areaCodeModel;
//
//@end
