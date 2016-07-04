//
//  ConsultStoreModelR.h
//  APP
//
//  Created by 李坚 on 16/1/5.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "BaseModel.h"

@interface ConsultStoreModelR : BaseModel



@end

@interface BranchProModelR : BaseModel

@property (nonatomic, strong) NSString *branchId;   //药店ID
@property (nonatomic, strong) NSString *code;       //全维商品编码

@end

@interface NearByStoreModelR : BaseModel

@property (nonatomic, strong) NSString *branchId;//药店ID

@property (nonatomic, strong) NSNumber *page;
@property (nonatomic, strong) NSNumber *pageSize;

@property (nonatomic, strong) NSString *city;//城市名称
@property (nonatomic, strong) NSNumber *longitude;//经度
@property (nonatomic, strong) NSNumber *latitude;//纬度

@property (nonatomic, strong) NSNumber *type;//配送方式：0.全部 1.送货上门 2.同城快递
@property (nonatomic, strong) NSNumber *eFee;//免配送费：0.全部 1.不免 2.免
@property (nonatomic, strong) NSNumber *sFee;//免起送价：0.全部 1.不免 2.免
@property (nonatomic, strong) NSNumber *sale;//优惠药房：0.全部 1.没有 2.有
@property (nonatomic, assign) NSInteger nearest;//排序：离我最近
@property (nonatomic, assign) BOOL best;//排序：评价最高

@end

@interface CategoryWrapperModelR : BaseModel

@property (nonatomic, strong) NSString *branchId;//药店ID

@end

@interface CategoryNormalProductModelR : BaseModel

@property (nonatomic, strong) NSString *branchId;//药店ID
@property (nonatomic, strong) NSString *classifyId;//分类ID
@property (nonatomic, strong) NSNumber *currPage;
@property (nonatomic, strong) NSNumber *pageSize;

@end

@interface CategoryModelR : BaseModel

@property (nonatomic, strong) NSString *branchId;

@end

@interface ProductModelR : BaseModel

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *latitude;

@end

@interface GroupModelR : BaseModel

@property (nonatomic, strong) NSString *branchId;

@end

@interface ProductByCodeModelR : BaseModel

@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSNumber *longitude;
@property (nonatomic, strong) NSNumber *latitude;

@end



@interface ProductByCodeBranchModelR : BaseModel

@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSNumber *longitude;
@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic,assign) NSInteger page;    //当前页数
@property (nonatomic,assign) NSInteger pageSize;//每页个数
@property (nonatomic,assign) NSString *couponId;//优惠券

@end


@interface ReportReasonModelR : BaseModel

@property (nonatomic, strong) NSString *objType;//投诉对象类型：1.未开通微商的药房，2.社会药房，3.微商药房，4.帖子，5.药师

@end

@interface ReportBranchModelR : BaseModel

@property (nonatomic, strong) NSString *objType;//投诉对象类型：1.未开通微商的药房，2.社会药房，3.微商药房，4.帖子，5.药师
@property (nonatomic, strong) NSString *objId;//投诉对象id
@property (nonatomic, strong) NSString *token;//投诉人Token
@property (nonatomic, strong) NSString *reason;//投诉原因，多个原因用分号隔开，中文
@property (nonatomic, strong) NSString *reasonRemark;//投诉原因备注

@end

@interface MallProductSearchModelR : BaseModel

@property (nonatomic, strong) NSString *branchId;//药房ID
@property (nonatomic, strong) NSString *city;//城市
@property (nonatomic, strong) NSNumber *longitude;//经度
@property (nonatomic, strong) NSNumber *latitude;//纬度
@property (nonatomic, strong) NSString *barcode;//条形码
@property (nonatomic, strong) NSString *key;//关键字
@property (nonatomic, strong) NSNumber *page;
@property (nonatomic, strong) NSNumber *pageSize;
@end

@interface MallSearchModelR : BaseModel

@property (nonatomic, strong) NSString *city;//城市 required
@property (nonatomic, strong) NSNumber *longitude;//经度
@property (nonatomic, strong) NSNumber *latitude;//纬度
@property (nonatomic, strong) NSString *key;//关键字 required
@property (nonatomic, strong) NSNumber *page;// required
@property (nonatomic, strong) NSNumber *pageSize;// required
@property (nonatomic, assign) BOOL containsSociety;//是否包含社会药房
@property (nonatomic, assign) BOOL national;//是否全国药房范围


@end

@interface BranchEvluationModelR : BaseModel

@property (nonatomic, strong) NSString *branchId;//药房ID
@property (nonatomic, strong) NSNumber *page;//城市
@property (nonatomic, strong) NSNumber *pageSize;//经度

@end