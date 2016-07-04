//
//  Discover.m
//  APP
//
//  Created by qw_imac on 16/1/13.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "Discover.h"

@implementation Discover
+(void)queryDiscover:(DiscoverR *)params success:(void(^)(DiscoverModel *model))success failure:(void(^)(HttpException *e))failure {
    [[HttpClient sharedInstance]get:SearchHotWord params:[params dictionaryModel] success:^(id responseObj) {
//        NSMutableArray *keyArr = [NSMutableArray array];
//        [keyArr addObject:NSStringFromClass([HotWord class])];
//        [keyArr addObject:NSStringFromClass([HotTestVO class])];
//        
//        NSMutableArray *valueArr = [NSMutableArray array];
//        [valueArr addObject:@"hostWord"];
//        [valueArr addObject:@"hotTests"];
//        
//        DiscoverModel *model = [DiscoverModel parse:responseObj ClassArr:keyArr Elements:valueArr];
        DiscoverModel *model = [DiscoverModel parse:responseObj Elements:[HotTestVO class] forAttribute:@"hotTests"];
        if (success) {
            success(model);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}
@end
