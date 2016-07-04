#import "Login.h"
#import "Constant.h"


@implementation Login


+ (void)xxx:(xx *)model success:(void (^)(id))success failure:(void (^)(HttpException *))failure
{
//    NSDictionary *dd=@{@"account":phoneNum,
//                       @"password":check(password),
//                       @"deviceCode":@"12345",
//                       @"device":@"2"};
    HttpClientMgr.progressEnabled = NO;
    [[HttpClient sharedInstance] post:nil params:[model dictionaryModel] success:^(id responseObj) {
        
        DebugLog(@"responseObj===>%@",responseObj);

        mbrUser *body=[mbrUser parse:responseObj ];

        if (success) {
            success(body);
            //modify end
        }
    } failure:^(HttpException *e) {
        DebugLog(@"%@",e);
        if (failure) {
            failure(e);
        }
    }];
 
}


@end
