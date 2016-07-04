#import "QWLocation.h"
#import "INTULocationManager.h"
#import "CLLocation+YCLocation.h"
#import "QWGlobalManager.h"
#import <CoreLocation/CLLocationManager.h>
#import "Search.h"


#define LOCATION_EXPIRE_IN 60

@interface QWLocation()
@property (strong, atomic) INTULocationManager * locMgr;
@property (strong, atomic) CLLocation * lastLocation;
@property (strong, atomic) CLLocation * tmpLocation;

@property (nonatomic, strong) AMapSearchAPI               *searchAPI;
@property (nonatomic, copy)   MapLocationBlock              mapLocationBlock;


@property long lastLocationTime;
@end

@implementation QWLocation
 static QWLocation *_sharedInstance = nil;
+ (instancetype)sharedInstance
{
   
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [QWLocation new];
        _sharedInstance.locMgr = [INTULocationManager sharedInstance];
        _sharedInstance.lastLocation = nil;
        _sharedInstance.searchAPI = [[AMapSearchAPI alloc] initWithSearchKey:AMAP_KEY Delegate:_sharedInstance];
        _sharedInstance.searchAPI.timeOut = 8;
    });
    
    return _sharedInstance;
}

+ (BOOL)locationServicesAvailable
{
    if ([CLLocationManager locationServicesEnabled] == NO) {
        return NO;
    } else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        return NO;
    } else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusRestricted) {
        return NO;
    }
    return YES;
}


- (INTULocationAccuracy)getAccuracyFromLocationType:(LocationType)type
{
    switch (type) {
        case LocationNone:
            return INTULocationAccuracyNone;
        case LocationCity:
            return INTULocationAccuracyCity;
        case LocationNeighborhood:
            return INTULocationAccuracyNeighborhood;
        case LocationCreate:
            return INTULocationAccuracyBlock;
        case LocationHouse:
            return INTULocationAccuracyHouse;
        case LocationRoom:
            return INTULocationAccuracyRoom;
    }
}

- (NSTimeInterval) getAccuracyFromLocationTimeout:(LocationType)type
{
    switch (type) {
        case LocationNone:
            return 100.0;
        case LocationCity:
            return 50.0;
        case LocationNeighborhood:
            return 25.0;
        case LocationCreate:
            return 12.5;
        case LocationHouse:
            return 10;
        case LocationRoom:
            return 7;
    }
}

- (NSInteger)request:(LocationType)type
          block:(void (^)(CLLocation *currentLocation, LocationStatus status))block
{
    INTULocationAccuracy accuracy = [self getAccuracyFromLocationType:type];
    NSTimeInterval timeout = [self getAccuracyFromLocationTimeout:type];
    
    return [_locMgr requestLocationWithDesiredAccuracy:accuracy
                                        timeout:timeout
                           delayUntilAuthorized:YES
                                          block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
                    
                                              if (status == INTULocationStatusSuccess || status == INTULocationStatusTimedOut) {
                                                  _lastLocationTime = (long)([[NSDate date] timeIntervalSince1970] * 1000.0f);
                                              }
                                              
                                              block(currentLocation, (LocationStatus)status);
                                          }];
}

//保存定位信息
- (void)saveLastMapInfo:(MapInfoModel *)mapinfo
{
    [QWUserDefault setObject:mapinfo.province key:APP_PROVIENCE_NOTIFICATION];
    [QWUserDefault setObject:mapinfo.city key:APP_CITY_NOTIFICATION];
    [QWUserDefault setObject:mapinfo key:APP_MAPINFOMODEL];
}

//如果已经有经纬度信息,则不会重新获取
- (void)requetWithCache:(LocationType)type
                timeout:(NSUInteger)timeout
             reLocation:(BOOL)relocation
                  block:(MapLocationBlock)block
{
    MapInfoModel *mapInfoModel = [QWUserDefault getObjectBy:APP_MAPINFOMODEL];
    
    if(mapInfoModel.location && mapInfoModel.province && mapInfoModel.city) {
        if(block) {
            block(mapInfoModel,LocationSuccess);
        }
    }else if(![QWLocation locationServicesAvailable]){
        block(nil,LocationRegeocodeFailed);
    }else if(mapInfoModel.location) {
        [self mapReGeocodeSearchRequest:mapInfoModel.location timeout:timeout block:block];
        
    }else{//读取历史失败(即没有历史数据)
        if (relocation) {//如果需要重新定位,则开始重新定位
            [self requetWithReGoecode:type timeout:timeout block:block];
        }else{//如果不需要重新定位,则直接返回定位失败
            
            block(nil,LocationRegeocodeFailed);
        }
    }
}

//解析mapInfoModel,组合成response
- (AMapReGeocodeSearchResponse *)reGeocodeSearchResponse:(MapInfoModel *)mapInfoModel
{
    AMapReGeocode *regeoCode = [[AMapReGeocode alloc] init];
    regeoCode.formattedAddress = mapInfoModel.formattedAddress;
    regeoCode.addressComponent = [[AMapAddressComponent alloc] init];
    regeoCode.addressComponent.province = mapInfoModel.province;
    regeoCode.addressComponent.city = mapInfoModel.city;
    
    AMapReGeocodeSearchResponse *lastReGeocodeSearchResponse = [[AMapReGeocodeSearchResponse alloc] init];
    lastReGeocodeSearchResponse.regeocode = regeoCode;
    return lastReGeocodeSearchResponse;
}


- (void)mapReGeocodeSearchRequest:(CLLocation *)cllocation
                          timeout:(NSUInteger)timeout
                            block:(MapLocationBlock)block{
    AMapReGeocodeSearchRequest *request = [[AMapReGeocodeSearchRequest alloc] init];
    request.searchType = AMapSearchType_ReGeocode;
    request.requireExtension = YES;
    request.radius = 50;
    request.location = [AMapGeoPoint locationWithLatitude:cllocation.coordinate.latitude longitude:cllocation.coordinate.longitude];;
    request.requireExtension = YES;
    self.mapLocationBlock = block;
    _searchAPI.timeOut = timeout;
    _tmpLocation = cllocation;
    [_searchAPI AMapReGoecodeSearch:request];
}

//定位当前经纬度,并根据高德地图逆地理解析
- (void)requetWithReGoecode:(LocationType)type
                    timeout:(NSUInteger)timeout
                      block:(MapLocationBlock)block
{
    INTULocationAccuracy accuracy = [self getAccuracyFromLocationType:type];
    [_locMgr requestLocationWithDesiredAccuracy:accuracy
                                        timeout:2.5
                           delayUntilAuthorized:YES
                                          block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
                                              if(status != INTULocationStatusSuccess) {

                                                    block(nil,LocationError);
                                                  
                                              }else{
                                                  //add by xie transform to Mars
                                                  currentLocation = [currentLocation locationMarsFromEarth];
                                                  if (status == INTULocationStatusSuccess || status == INTULocationStatusTimedOut) {
                                                      _lastLocationTime = (long)([[NSDate date] timeIntervalSince1970] * 1000.0f);
                                                      _tmpLocation = currentLocation;
                                                      //拿到地理位置信息后,逆地理编码解析,获取可读的地址
                                                      AMapReGeocodeSearchRequest *request = [[AMapReGeocodeSearchRequest alloc] init];
                                                      request.searchType = AMapSearchType_ReGeocode;
                                                      request.requireExtension = YES;
                                                      request.radius = 3000;
                                                      request.location = [AMapGeoPoint locationWithLatitude:currentLocation.coordinate.latitude longitude:currentLocation.coordinate.longitude];;
                                                      request.requireExtension = YES;
                                                      self.mapLocationBlock = block;
                                                      [_searchAPI AMapReGoecodeSearch:request];
                                                      
                                                  }
                                              }
                                          }];
}

#pragma mark -
#pragma mark AMapSearchDelegate
//高德回调,取得可读字符串地位位置
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if(self.mapLocationBlock)
    {
        MapInfoModel *mapInfo = [[MapInfoModel alloc] init];
        mapInfo.location = _tmpLocation;
        mapInfo.formattedAddress = response.regeocode.formattedAddress;
        mapInfo.province = response.regeocode.addressComponent.province;
        //直辖市处理方法:省不为空,市为空  则把省赋给市
        if (!StrIsEmpty(response.regeocode.addressComponent.province) && StrIsEmpty(response.regeocode.addressComponent.city)) {
            mapInfo.city = response.regeocode.addressComponent.province;
        }else{
            mapInfo.city = response.regeocode.addressComponent.city;
        }
        
        KeywordModelR *modelR = [KeywordModelR new];
        modelR.city = response.regeocode.addressComponent.city;
        if(modelR.city.length == 0) {
            modelR.city = response.regeocode.addressComponent.province;
        }
        //拿城市查询,当前城市是否开通信息
        [Search searchOpencityChecknew:modelR success:^(OpenCityCheckVoModel *model) {
            if([model.apiStatus intValue] == 0) {
                NSString *openStr;
                if(model.status == 3){
                    openStr = @"已开通";
                }else{
                    openStr = @"未开通";
                }
                [QWGLOBALMANAGER statisticsEventId:@"x_dw_dwcg" withLable:@"" withParams:[NSMutableDictionary dictionaryWithDictionary:@{@"城市名":modelR.city,@"是否开通微商":openStr}]];
                mapInfo.status = model.status;
                mapInfo.cityCode = model.cityCode;
                mapInfo.remark = model.remark;
                self.mapLocationBlock(mapInfo,LocationSuccess);
            }
        } failure:^(HttpException *e) {
            self.mapLocationBlock(nil,LocationRegeocodeFailed);
        }];
    }
}

- (void)searchRequest:(id)request didFailWithError:(NSError *)error
{
    if(self.mapLocationBlock)
    {
        MapInfoModel *mapInfo = [[MapInfoModel alloc] init];
        mapInfo.location = _tmpLocation;
        self.mapLocationBlock(mapInfo,LocationRegeocodeFailed);
    }
}

- (void)cancel:(NSInteger)requestID
{
    [_locMgr cancelLocationRequest:requestID];
}

+ (CLLocation *)wgs84ToGcj02
{
   _sharedInstance.lastLocation = [_sharedInstance lastWellLocation] ;
    return [_sharedInstance.lastLocation locationMarsFromEarth];
}

+ (CLLocation *)wgs84ToBd09
{
    _sharedInstance.lastLocation = [_sharedInstance lastWellLocation] ;
    return [_sharedInstance.lastLocation locationBaiduFromMars];
}
+ (CLLocation *)gcj02ToBd09
{
    _sharedInstance.lastLocation = [self wgs84ToGcj02] ;
    return [_sharedInstance.lastLocation locationBaiduFromMars];
}

+ (CLLocation *)Bd09Togcj02
{
    _sharedInstance.lastLocation = [self wgs84ToGcj02] ;
    return [_sharedInstance.lastLocation locationMarsFromBaidu];
}
- (CLLocation *)lastWellLocation
{
    long now = (long)([[NSDate date] timeIntervalSince1970] * 1000.0f);
    if (now - _lastLocationTime > LOCATION_EXPIRE_IN * 1000) {
        return nil;
    }
    
    return _lastLocation;
}

@end