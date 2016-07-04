//
//  FavoriteModel.m
//  APP
//
//  Created by qw on 15/3/5.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "FavoriteModel.h"

@implementation FavoriteModel

@end

@implementation MyFavListModel
+(NSString *)getPrimaryKey{
    
    return @"favSomeId";
}
@end


@implementation MyFavStoreModel

+(NSString *)getPrimaryKey{
    
    return @"favInKey";
}

@end

@implementation MyFavStoreTagListModel

@end



@implementation MyFavProductListModel
+(NSString *)getPrimaryKey{
    
    return @"favProductInKey";
}
@end

@implementation MyFavDiseaseListModel
+(NSString *)getPrimaryKey{
    
    return @"favDiseaseInKey";
}
@end

@implementation MyFavAdviceListModel
+(NSString *)getPrimaryKey{
    
    return @"favAdviceInKey";
}
@end

@implementation MyFavCoupnListModel
+(NSString *)getPrimaryKey{
    
    return @"favCoupnInKey";
}
@end



@implementation MyFavSpmListModel
+(NSString *)getPrimaryKey{
    
    return @"favSpmInKey";
}
@end

@implementation CancleResult
@synthesize result;

@end
@implementation AdviceCollectResult

@end
@implementation MyFavMsgListModel

@end

@implementation MyFavMsgLists

@end
@implementation DelCollectionModel

@end