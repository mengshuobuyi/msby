//
//  BaseModel.m
//  APP
//
//  Created by carret on 15/1/16.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "BaseModel.h"
#import <objc/runtime.h>
#import "DCKeyValueObjectMapping.h"
#import "DCArrayMapping.h"
#import "DCParserConfiguration.h"
#import "QWSandbox.h"
#import "NSObject+DCKeyValueObjectMapping.h"
#import "DrugModel.h"
#import "NotificationModel.h"

@interface BaseModel()
{
    
}
@end

//@property (copy, nonatomic) NSString *name;
//@property (strong, nonatomic) NSNumber *number;
//@property (strong, nonatomic) NSArray *array;
//@property (assign, nonatomic) NSInteger i;
//@property (assign, nonatomic) CGFloat f;
//@property (assign, nonatomic) char *cStr;

//T@"NSString",C,N,V_name
//T@"NSNumber",&,N,V_number
//T@"NSArray",&,N,V_array
//Tq,N,V_i
//Td,N,V_f
//T*,N,V_cStr


@implementation BaseModel
//add by Qingyang
static const char *getPropertyType(objc_property_t property) {
    const char *attributes = property_getAttributes(property);
    //printf("attributes=%s\n", attributes);
    char buffer[1 + strlen(attributes)];
    strcpy(buffer, attributes);
    char *state = buffer, *attribute;
    while ((attribute = strsep(&state, ",")) != NULL) {
        if (attribute[0] == 'T' && attribute[1] != '@') {
            // it's a C primitive type:
            /*
             if you want a list of what will be returned for these primitives, search online for
             "objective-c" "Property Attribute Description Examples"
             apple docs list plenty of examples of what you get for int "i", long "l", unsigned "I", struct, etc.
             */
            NSString *name = [[NSString alloc] initWithBytes:attribute + 1 length:strlen(attribute) - 1 encoding:NSASCIIStringEncoding];
            return (const char *)[name cStringUsingEncoding:NSASCIIStringEncoding];
        }
        else if (attribute[0] == 'T' && attribute[1] == '@' && strlen(attribute) == 2) {
            // it's an ObjC id type:
            return "id";
        }
        else if (attribute[0] == 'T' && attribute[1] == '@') {
            // it's another ObjC object type:
            NSString *name = [[NSString alloc] initWithBytes:attribute + 3 length:strlen(attribute) - 4 encoding:NSASCIIStringEncoding];
            return (const char *)[name cStringUsingEncoding:NSASCIIStringEncoding];
        }
    }
    return "";
}

- (NSString *)getProperty:(objc_property_t)property attributeType:(NSString*)attributeType{
    if (attributeType==nil) {
        return nil;
    }
    NSString *at=[attributeType uppercaseString];
    
    const char *attributes = property_getAttributes(property);
    NSString *atts=[NSString stringWithUTF8String:attributes];
    NSArray *arr=[atts componentsSeparatedByString:@","];
    for (NSString *ss in arr) {
        NSString *attName=[ss substringToIndex:1];
        if ([attName isEqualToString:at]) {
            return [ss substringFromIndex:1];
        }
    }
    return nil;
}

- (NSString *)description
{
    NSString *str=[NSString stringWithFormat:@"%@ %@",[super description],[[self dictionaryModel] description]];
    return str;
    
    
    
}

- (NSDictionary*)dictionaryModel{
    NSMutableDictionary* returnDic = [NSMutableDictionary dictionary];
    
    Class clazz = [self class];
    while (clazz != [NSObject class])
    {
        unsigned int propertyCount;
        objc_property_t *properties = class_copyPropertyList(clazz, &propertyCount);
        
        NSMutableArray* propertyArray = [NSMutableArray arrayWithCapacity:propertyCount];
        NSMutableArray* valueArray = [NSMutableArray arrayWithCapacity:propertyCount];
        
        for (int i = 0; i < propertyCount; i++)
        {
            //get property
            objc_property_t property = properties[i];
            const char *propertyName = property_getName(property);
            const char *propertyType = getPropertyType(property);
            
            NSString *name=[NSString stringWithUTF8String:propertyName];
            NSString *type=[NSString stringWithUTF8String:propertyType];
            id objValue = [self valueForKey:name];
            if(!objValue)
                continue;
//            DebugLog(@"property: \n%@ %@ \n%s \n%@",type,name,property_getAttributes(property),[self getProperty:property attributeType:@"G"]);
            [propertyArray addObject:name];
            
//            NSString *nameGetter=[self getProperty:property attributeType:@"G"];
//            if (nameGetter==nil) {
//                nameGetter=name;
//            }
//            SEL selector = NSSelectorFromString(nameGetter);
//            IMP imp = [self methodForSelector:selector];
            
//            DebugLog(@"selector: %@",NSStringFromSelector(selector));
            if ([type length]==1) {
//                DebugLog(@"%@ %@ %@",type,[self valueForKey:name],[[self valueForKey:name] class]);
                NSNumber *num=[self valueForKey:name];
//                
//                if ([type isEqualToString:@"i"]) { //strcmp(propertyType, @encode(NSInteger))
//                    NSInteger (*func)(id, SEL) = (void *)imp;
//                    num = [NSNumber numberWithInteger:func(self, selector)];
//                }
//                if ([type isEqualToString:@"d"]) {
//                    double (*func)(id, SEL) = (void *)imp;
//                    num = [NSNumber numberWithDouble:func(self, selector)];
//                }
//                if ([type isEqualToString:@"f"]) {
//                    float (*func)(id, SEL) = (void *)imp;
//                    num = [NSNumber numberWithFloat:func(self, selector)];
//                }
//                if ([type isEqualToString:@"l"]) {
//                    long (*func)(id, SEL) = (void *)imp;
//                    num = [NSNumber numberWithLong:func(self, selector)];
//                }
//                if ([type isEqualToString:@"q"]) {
//                    long long (*func)(id, SEL) = (void *)imp;
//                    num = [NSNumber numberWithLongLong:func(self, selector)];
//                }
//                if ([type isEqualToString:@"s"]) {
//                    short (*func)(id, SEL) = (void *)imp;
//                    num = [NSNumber numberWithShort:func(self, selector)];
//                }
//                if ([type isEqualToString:@"c"]) {
//                    char (*func)(id, SEL) = (void *)imp;
//                    num = [NSNumber numberWithChar:func(self, selector)];
//                }
//                if ([type isEqualToString:@"B"]) {
//                    char (*func)(id, SEL) = (void *)imp;
//                    num = [NSNumber numberWithBool:func(self, selector)];
//                }
                
                if (num == nil) {
                    [valueArray addObject:@"0"];
                }
                else
                    [valueArray addObject:num];
            }
            else {
                
//                id (*func)(id, SEL) = (void *)imp;
                id value = //func(self, selector);
                [self valueForKey:name];//
//                DebugLog(@"value: %@",value);
                if(value == nil) {
                    
                    if ([type isEqualToString:@"NSString"]) {
                        [valueArray addObject:@""];
                    }
                    else if ([type isEqualToString:@"NSNumber"]) {
                        [valueArray addObject:@""];
                    }
                    else if ([type isEqualToString:@"NSDictionary"]) {
                        [valueArray addObject:[NSDictionary dictionary]];
                    }
                    else if ([type isEqualToString:@"NSArray"]) {
                        [valueArray addObject:[NSArray array]];
                    }
//                    else if ([type isEqualToString:@"NSArray"]) {
//                        [valueArray addObject:[NSArray array]];
//                    }
                    else
                        [valueArray addObject:[NSNull null]];
                }
                else if([value isKindOfClass:[BaseModel class]]){
                    NSDictionary *dd=[value dictionaryModel];
                    [valueArray addObject:dd];
                }
                else {
                    [valueArray addObject:value];
                }
            }
        }
        free(properties);
        
        NSMutableDictionary* tmp = [NSMutableDictionary dictionaryWithObjects:valueArray forKeys:propertyArray];
        [returnDic addEntriesFromDictionary:tmp];

        clazz = [clazz superclass];
    }
    
    return returnDic;
}

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}
#pragma mark - copy
- (id)copyWithZone:(NSZone*)zone{
    id copyInstance = [[[self class] allocWithZone:zone] init];
    
    Class class = [self class];
    while (class != [NSObject class])
    {
        unsigned int propertyCount;
        objc_property_t *properties = class_copyPropertyList(class, &propertyCount);
        for (int i = 0; i < propertyCount; i++)
        {
            //get property
            objc_property_t property = properties[i];
            
//            const char *propertyType = getPropertyType(property);
            const char *propertyName = property_getName(property);
            
            NSString *name = [NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding];
//            NSString *type = [NSString stringWithCString:propertyType encoding:NSUTF8StringEncoding];
            NSString *cName= [@"_" stringByAppendingString:name];
            
            //check if read-only
            BOOL readonly = NO;
            const char *attributes = property_getAttributes(property);
            NSString *encoding = [NSString stringWithCString:attributes encoding:NSUTF8StringEncoding];
            if ([[encoding componentsSeparatedByString:@","] containsObject:@"R"])
            {
                readonly = YES;
                
                //see if there is a backing ivar with a KVC-compliant name
                NSRange iVarRange = [encoding rangeOfString:@",V"];
                if (iVarRange.location != NSNotFound)
                {
                    NSString *iVarName = [encoding substringFromIndex:iVarRange.location + 2];
                    if ([iVarName isEqualToString:name] ||
                        [iVarName isEqualToString:cName])
                    {
                        //setValue:forKey: will still work
                        readonly = NO;
                    }
                }
            }
            
            if (!readonly)
            {
//                DebugLog(@"%@ %@ %@",name,type,[self valueForKey:name]);
                [copyInstance setValue:[self valueForKey:name] forKey:name];
            }
        }
        free(properties);
        class = [class superclass];
    }
    
    return copyInstance;
}
//add end

#pragma mark - conde & decode
- (id)initWithCoder:(NSCoder *)coder
{
    if (self = [super init])
    {
        [self codeWithCoder:coder decodeEnabled:YES];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [self codeWithCoder:coder decodeEnabled:NO];
}

-(void)codeWithCoder:(NSCoder *)coder decodeEnabled:(BOOL)decodeEnabled{
    Class class = [self class];
    while (class != [NSObject class])
    {
        unsigned int propertyCount;
        objc_property_t *properties = class_copyPropertyList(class, &propertyCount);
        for (int i = 0; i < propertyCount; i++)
        {
            //get property
            objc_property_t property = properties[i];
            
            const char *propertyType = getPropertyType(property);
            const char *propertyName = property_getName(property);
            
            NSString *name = [NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding];
            NSString *type = [NSString stringWithCString:propertyType encoding:NSUTF8StringEncoding];
            NSString *cName= [@"_" stringByAppendingString:name];
            
            //check if read-only
            BOOL readonly = NO;
            const char *attributes = property_getAttributes(property);
            NSString *encoding = [NSString stringWithCString:attributes encoding:NSUTF8StringEncoding];
            if ([[encoding componentsSeparatedByString:@","] containsObject:@"R"])
            {
                readonly = YES;
                
                //see if there is a backing ivar with a KVC-compliant name
                NSRange iVarRange = [encoding rangeOfString:@",V"];
                if (iVarRange.location != NSNotFound)
                {
                    NSString *iVarName = [encoding substringFromIndex:iVarRange.location + 2];
                    if ([iVarName isEqualToString:name] ||
                        [iVarName isEqualToString:cName])
                    {
                        //setValue:forKey: will still work
                        readonly = NO;
                    }
                }
            }
            
            if (!readonly)
            {
                //exclude read-only properties
                if ([type length]==1) {
                    if ([type isEqualToString:@"q"]) {
                        if (decodeEnabled){
                            NSInteger num=[coder decodeIntegerForKey:cName];
                            [self setValue:[NSNumber numberWithInteger:num] forKey:name];
                        }
                        else {
                            //[coder encodeInteger:_tag forKey:@"_tag"];
                            NSInteger value = [[self valueForKey:name]integerValue];
                            [coder encodeInteger:value forKey:cName];
                        }
                    }
                    else if ([type isEqualToString:@"Q"]) {
                        
                        if (decodeEnabled){
                            NSUInteger num=[coder decodeIntegerForKey:cName];
                            [self setValue:[NSNumber numberWithUnsignedInteger:num] forKey:name];
                        }
                        else {
                            NSUInteger value = [[self valueForKey:name]unsignedIntegerValue];
                            
                            [coder encodeInteger:value forKey:cName];
                        }
                    }
                    else if ([type isEqualToString:@"i"]) { //strcmp(propertyType, @encode(NSInteger))
                        if (decodeEnabled){
                            int num=[coder decodeIntForKey:cName];
                            [self setValue:[NSNumber numberWithInt:num] forKey:name];
                        }
                        else {
                            int value = [[self valueForKey:name]intValue];
                            [coder encodeInt:value forKey:cName];
                        }
                    }
                    else if ([type isEqualToString:@"d"]) {
                        
                        if (decodeEnabled){
                            double num=[coder decodeDoubleForKey:cName];
                            [self setValue:[NSNumber numberWithDouble:num] forKey:name];
                        }
                        else {
                            double value = [[self valueForKey:name]doubleValue];
                            [coder encodeDouble:value forKey:cName];
                        }
                    }
                    else if ([type isEqualToString:@"f"]) {
                        
                        if (decodeEnabled){
                            float num=[coder decodeFloatForKey:cName];
                            [self setValue:[NSNumber numberWithFloat:num] forKey:name];
                        }
                        else {
                            float value = [[self valueForKey:name]floatValue ];
                            [coder encodeFloat:value forKey:cName];
                        }
                    }
                    else if ([type isEqualToString:@"l"]) {
                        
                        if (decodeEnabled){
                            NSInteger num=[coder decodeIntegerForKey:cName];
                            [self setValue:[NSNumber numberWithInteger:num] forKey:name];
                        }
                        else {
                            NSInteger value = [[self valueForKey:name]intValue];
                            [coder encodeInteger:value forKey:cName];
                        }
                    }
                    else if ([type isEqualToString:@"s"]) {
                        
                        if (decodeEnabled){
                            short num=[coder decodeIntForKey:cName];
                            [self setValue:[NSNumber numberWithShort:num] forKey:name];
                        }
                        else {
                            int value = [[self valueForKey:name]intValue];
                            [coder encodeInt:value forKey:cName];
                        }
                    }
                    else if (strcmp(propertyType, @encode(BOOL)) == 0 || strcmp(propertyType, @encode(bool)) == 0) {
                        //                        DebugLog(@"+++++++++++++:%@ %s %s",type,@encode(BOOL),propertyType);
                        if (decodeEnabled){
                            BOOL num=YES;
                            @try {
                                num=[coder decodeBoolForKey:cName];
                            }
                            @catch (NSException *exception) {
                                @try {
                                    int value = [coder decodeIntForKey:cName];
                                    if (value<=0) {
                                        num=false;
                                    }
                                }
                                @catch (NSException *exception) {
                                    //
                                }
                                @finally {
                                    //
                                }
                            }
                            @finally {
                                
                            }
                            
                            [self setValue:[NSNumber numberWithBool:num] forKey:name];
                            //                            DebugLog(@"%@ %i",cName,num);
                        }
                        else {
                            BOOL value = YES;
                            @try {
                                value = [[self valueForKey:name]boolValue];
                            }
                            @catch (NSException *exception) {
                                //
                            }
                            @finally {
                                //
                            }
                            [coder encodeBool:value forKey:cName];
                        }
                    }
                    else if (strcmp(propertyType, @encode(char)) == 0) {
                        DebugLog(@"--------------:%@",type);
                        
                    }
                    
                }
                else {
                    if (decodeEnabled){
                        //self.oid = [coder decodeObjectForKey:@"_oid"];
                        [self setValue:[coder decodeObjectForKey:cName] forKey:name];
                    }
                    else {
                        //[coder encodeObject:_oid forKey:@"_oid"];
                        id value = [self valueForKey:name];
                        [coder encodeObject:value forKey:cName];
                    }
                }
                
            }
        }
        free(properties);
        class = [class superclass];
    }
}
#pragma mark - end modify by yqy

- (void)encodeIvarOfClass:(Class)class withCoder:(NSCoder *)coder
{
    unsigned int numIvars = 0;
    Ivar *ivars = class_copyIvarList(class, &numIvars);
    for (int i = 0; i < numIvars; i++) {
        Ivar thisIvar = ivars[i];
        NSString * key = [NSString stringWithUTF8String:ivar_getName(thisIvar)];
        id value = [self valueForKey:key];
        if ([key hasPrefix:@"parent"]) {
            [coder encodeConditionalObject:value forKey:key];
        } else {
            [coder encodeObject:value forKey:key];
        }
    }
    if (ivars != NULL) { free(ivars); }
}



- (void)continueEncodeIvarOfClass:(Class)class withCoder:(NSCoder *)coder
{
    if (class_respondsToSelector(class, @selector(encodeWithCoder:))) {
        [self encodeIvarOfClass:class withCoder:coder];
        [self continueEncodeIvarOfClass:class_getSuperclass(class) withCoder:coder];
    }
}


//
//- (void)encodeWithCoder:(NSCoder *)coder {
//    @autoreleasepool {
//        [self continueEncodeIvarOfClass:[self class] withCoder:coder];
//        
//    }
//}

//- (void)encodeWithCoder:(NSCoder *)coder {
//    @autoreleasepool {
//        [self continueEncodeIvarOfClass:[self class] withCoder:coder];
//        
//    }
//}

- (void)decodeIvarOfClass:(Class)class withCoder:(NSCoder *)coder
{
    unsigned int numIvars = 0;
    Ivar * ivars = class_copyIvarList(class, &numIvars);
    for(int i = 0; i < numIvars; i++) {
        Ivar thisIvar = ivars[i];
        NSString * key = [NSString stringWithUTF8String:ivar_getName(thisIvar)];
        id value = [coder decodeObjectForKey:key];
        [self setValue:value forKey:key];
        DDLogVerbose(@"var name: %@\n", key);
    }
    if (ivars != NULL) { free(ivars); }
}


- (void)continueDecodeIvarOfClass:(Class)class withCoder:(NSCoder *)coder
{
    if (class_respondsToSelector(class, @selector(initWithCoder:))) {
        [self decodeIvarOfClass:class withCoder:coder];
        [self continueDecodeIvarOfClass:class_getSuperclass(class) withCoder:coder];
    }
}


//- (id)initWithCoder:(NSCoder *)coder {
//    self = [super init];
//    if (self == nil) {
//        return nil;
//    }
//    @autoreleasepool {
//        [self continueDecodeIvarOfClass:[self class] withCoder:coder];
//    }
//    return self;
//}





+ (id)parse:(id)json
{
    id instance = nil;
    instance = [[self alloc] init];
    DCArrayMapping *mapper = [DCArrayMapping mapperForClassElements:[instance class] forAttribute:@"data" onClass:[instance class]];
    
    DCParserConfiguration *configuration = [DCParserConfiguration configuration];
    [configuration addArrayMapper:mapper];
    
    DCKeyValueObjectMapping *parser = [DCKeyValueObjectMapping mapperForClass:[instance class] andConfiguration:configuration];
    
//    instance   = [parser parseDictionary:json];
    @try {
        instance   = [parser parseDictionary:json];
        if ([instance isKindOfClass:[NotificationModel class]]) {
            NotificationModel *model = instance;
            if (model.ot != nil) {
                model.objId = model.oid;
            }
        }
        return instance;
    }
    @catch (NSException *exception) {
        DDLogError(@"可能数据模型建立错误，未与接口匹配");
    }
    @finally {
        
    }
    return instance;
}
+(id)parse:(id)json Elements:(id)classE
{
    id instance = nil;
    instance = [[self alloc] init];
    DCArrayMapping *mapper = [DCArrayMapping mapperForClassElements:classE forAttribute:@"data" onClass:[instance class]];
    
    DCParserConfiguration *configuration = [DCParserConfiguration configuration];
    [configuration addArrayMapper:mapper];
    
    DCKeyValueObjectMapping *parser = [DCKeyValueObjectMapping mapperForClass:[instance class] andConfiguration:configuration];

    @try {
        instance   = [parser parseDictionary:json];
        return instance;
    }
    @catch (NSException *exception) {
        DDLogError(@"可能数据模型建立错误，未与接口匹配");
    }
    @finally {
        
    }
    return instance;
}
+(id)parse:(id)json Elements:(id)classE forAttribute:(NSString *)attribute
{
    id instance = nil;
    instance = [[self alloc] init];
    DCArrayMapping *mapper = [DCArrayMapping mapperForClassElements:classE forAttribute:attribute onClass:[instance class]];
    
    DCParserConfiguration *configuration = [DCParserConfiguration configuration];
    [configuration addArrayMapper:mapper];
    
    DCKeyValueObjectMapping *parser = [DCKeyValueObjectMapping mapperForClass:[instance class] andConfiguration:configuration];
    
//    instance   = [parser parseDictionary:json];
    @try {
        instance   = [parser parseDictionary:json];
        return instance;
    }
    @catch (NSException *exception) {
        DDLogError(@"可能数据模型建立错误，未与接口匹配");
    }
    @finally {
        
    }
    return instance;
}
+ (NSArray *)parseArray:(id)json
{
    id instance = nil;
    instance = [[self alloc] init];
    DCObjectMapping *maper = [[DCObjectMapping alloc] initWithClass:[instance class]];
    
    DCParserConfiguration *configuration = [DCParserConfiguration configuration];
    [configuration addObjectMapping:maper];
    
    DCKeyValueObjectMapping *parser = [DCKeyValueObjectMapping mapperForClass:[instance class] andConfiguration:configuration];
    
    @try {
       NSArray *modelArray = [parser parseArray:json];
            return  modelArray;
    }
    @catch (NSException *exception) {
        DDLogError(@"可能数据模型建立错误，未与接口匹配");
    }
    @finally {
        
    }
   
    

}
 
+(id)parse:(id)json ClassArr:(NSMutableArray *)classA Elements:(NSMutableArray *)elements
{
    id instance = nil;
    instance = [[self alloc] init];
    if ([classA count]<1) {
        return nil;
    }
    DCParserConfiguration *configuration = [DCParserConfiguration configuration];
//    
//    DCArrayMapping *mapper = [DCArrayMapping mapperForClassElements:[QuerySecondProductClassModel  class]  forAttribute:[elements objectAtIndex:0] onClass:[instance class]];
//    [configuration addArrayMapper:mapper];
//    
//    
//    DCArrayMapping *mapper2 = [DCArrayMapping mapperForClassElements:NSClassFromString([ classA   objectAtIndex:1])  forAttribute:[elements objectAtIndex:1] onClass:NSClassFromString([ classA   objectAtIndex:0])];
//    [configuration addArrayMapper:mapper2];
    
//    DCArrayMapping *mapper = [DCArrayMapping mapperForClassElements:[QuerySecondProductClassModel class]  forAttribute:@"data" onClass:[instance class]];
//    [configuration addArrayMapper:mapper];
//    
//    
//    DCArrayMapping *mapper2 = [DCArrayMapping mapperForClassElements:[QuerySecondProductClassItemModel class]  forAttribute:@"childrens" onClass:[QuerySecondProductClassModel class]];
//    [configuration addArrayMapper:mapper2];
    for (int i =0; i<[elements count]; i ++) {

        if (i == 0) {
  
            DCArrayMapping *mapper = [DCArrayMapping mapperForClassElements:NSClassFromString([classA objectAtIndex:0])  forAttribute:[elements objectAtIndex:0] onClass:[instance class]];
            [configuration addArrayMapper:mapper];
            continue;
        }
     
        DCArrayMapping *mapper2 = [DCArrayMapping mapperForClassElements:NSClassFromString([ classA   objectAtIndex:i])  forAttribute:[elements objectAtIndex:i] onClass:NSClassFromString([ classA   objectAtIndex:i-1])];
        [configuration addArrayMapper:mapper2];
    }
    DCKeyValueObjectMapping *parser = [DCKeyValueObjectMapping mapperForClass:[instance class] andConfiguration:configuration];
    @try {
            instance   = [parser parseDictionary:json];
            return instance;
    }
    @catch (NSException *exception) {
        DDLogError(@"可能数据模型建立错误，未与接口匹配");
    }
    @finally {
        
    }


}
+(id)parseArray:(id)json ElementsDic:(NSMutableDictionary *)classE
{
    id instance = nil;
    instance = [[self alloc] init];
    if ([classE count]<1) {
        return nil;
    }
    DCParserConfiguration *configuration = [DCParserConfiguration configuration];
    for (int i =0; i<[[classE allValues] count]; i ++) {
        DCArrayMapping *mapper = [DCArrayMapping mapperForClassElements:[[classE allValues] objectAtIndex:i] forAttribute:[[classE allKeys] objectAtIndex:i] onClass:[[classE allValues] objectAtIndex:i]];
        [configuration addArrayMapper:mapper];
    }
    DCKeyValueObjectMapping *parser = [DCKeyValueObjectMapping mapperForClass:[instance class] andConfiguration:configuration];
//    instance   = [parser parseDictionary:json];
    @try {
        instance   = [parser parseDictionary:json];
        return instance;
    }
    @catch (NSException *exception) {
        DDLogError(@"可能数据模型建立错误，未与接口匹配");
    }
    @finally {
        
    }
    return instance;
}

+ (NSDictionary*)dataTOdic:(id)obj
{
    NSMutableDictionary  *dic = [NSMutableDictionary dictionary];
    unsigned int propsCount;
    objc_property_t  *props = class_copyPropertyList([obj class], &propsCount);
    for(int i = 0;i < propsCount; i++)
    {
        objc_property_t prop = props[i];
        NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];
        id  value = [obj valueForKey:propName];
        if(value == nil)
        {
            value = [NSNull null];
        }
        else
        {
            value  = [self getObjectInternal:value];
        }
        if(![value isEqual:[NSNull null]])
            [dic setObject:value forKey:propName];
    }
    return dic;
}


+(id)getObjectInternal:(id)obj
{
    if([obj isKindOfClass:[NSString class]] || [obj isKindOfClass:[NSNumber class]] || [obj isKindOfClass:[NSNull class]])
    {
        return  obj;
    }
    if([obj isKindOfClass:[NSArray class]])
    {
        NSArray *objarr = obj;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:objarr.count];
        for(int i = 0;i < objarr.count; i++)
        {
            [arr setObject:[self getObjectInternal:[objarr objectAtIndex:i]] atIndexedSubscript:i];
        }
        return  arr;
    }
    if([obj isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *objdic = obj;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[objdic count]];
        for(NSString  *key in  objdic.allKeys)
        {
            [dic setObject:[self getObjectInternal:[objdic objectForKey:key]] forKey:key];
        }
        return  dic;
    }
    return  [self dataTOdic:obj];
}


+ (NSData*)getJSON:(id)obj options:(NSJSONWritingOptions)options error:(NSError**)error
{
    return [NSJSONSerialization dataWithJSONObject:[self dataTOdic:obj] options:options error:error];
}


+ (void)print:(id)obj
{
    DebugLog(@"%@", [self dataTOdic:obj]);
}

-(BOOL)saveToNsuserDefault:(NSString *)objId
{
    //序列化
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSData  *data1 = [NSKeyedArchiver archivedDataWithRootObject:self];
    [user setObject:data1 forKey:objId];
    [user synchronize];
    
    return YES;
}
+ (id)getFromNsuserDefault:(NSString *)objId
{
    id instance = nil;
    instance = [[self alloc] init];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    if(![user objectForKey:objId])
    {
        return nil;
    }
    
    instance   = [NSKeyedUnarchiver unarchiveObjectWithData:[user objectForKey:objId]];//反序列化
    
    return instance;
}

-(BOOL)saveToNsuserlocal:(NSString *)userPath
{
    NSString *path = [NSString stringWithFormat:@"archive.dat"];
    NSData  *data1 = [NSKeyedArchiver archivedDataWithRootObject:self];//将s1序列化后,保存到NSData中
    DebugLog(@"%@",[QWSandbox docPath]);
    BOOL su =  [data1 writeToFile:[NSString stringWithFormat:@"%@%@", [QWSandbox docPath],userPath?userPath:path] atomically:YES];//持久化保存成物理文件
    

    return su;
}

-(id)getFromNsuserlocal:(NSString *)userPath
{
    NSString *path = [NSString stringWithFormat:@"archive.dat"];
    id instance = nil;
    instance = [super init];
    NSData *data2 = [NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@%@", [QWSandbox docPath],userPath?userPath:path] ];//读取文件
    instance   = [NSKeyedUnarchiver unarchiveObjectWithData:data2];//反序列化
    
    return instance;
    
}


+ (NSString *)getPrimaryKey
{
    return @"";
}

+ (NSError *)saveObjToDB:(id)Obj
{
    if (Obj == nil){
        NSError *error = [NSError errorWithDomain:[NSString stringWithFormat:@"[save error] :%@", Obj] code:0 userInfo:nil];
        DDLogError(@"%s:%d,%@",__FILE__,__LINE__,[error description]);
        return error;
    }
    LKDBHelper *globalHelper = [[self class] getUsingLKDBHelperEx:nil];
    
    if (globalHelper == nil) {
        NSError *error =  [NSError errorWithDomain:[NSString stringWithFormat:@"[save error] :%@", Obj] code:1 userInfo:nil];
        DDLogError(@"%s:%d,%@",__FILE__,__LINE__,[error description]);
        return error;
    }

    if (![globalHelper insertToDB:Obj])
    {
        
        NSError *error = [NSError errorWithDomain:[NSString stringWithFormat:@"[save error] :%@", Obj] code:0 userInfo:nil];
        DDLogError(@"%s:%d,%@",__FILE__,__LINE__,[error description]);
        return error;
    }
    
    return nil;
    
}

+ (NSError *)saveObjToDBWithArray:(NSArray *)array
{
    if (array == nil || array.count == 0) {
        
        NSError *error = [NSError errorWithDomain:[NSString stringWithFormat:@"[save error] :%@", array] code:0 userInfo:nil];
        DDLogError(@"%s:%d,%@",__FILE__,__LINE__,[error description]);
        return error;
    }
    LKDBHelper* globalHelper = [[self class] getUsingLKDBHelperEx:nil];
    if (globalHelper == nil) {
        NSError *error = [NSError errorWithDomain:[NSString stringWithFormat:@"[save error] :%@", array] code:1 userInfo:nil];
        DDLogError(@"%s:%d,%@",__FILE__,__LINE__,[error description]);
        return error;
    }
    
    NSMutableString *str = [NSMutableString stringWithFormat:@"[save error] :"];
    NSInteger length = str.length;
    
    for (NSObject *entity in array)
    {
        if (![globalHelper insertToDB:entity])
        {
            [str stringByAppendingFormat:@"%@ ", entity];
        }
    }
    
    if (str.length > length)
    {
        NSError *error = [NSError errorWithDomain:str code:0 userInfo:nil];
        DDLogError(@"%s:%d,%@",__FILE__,__LINE__,[error description]);
        return error;
    }
    
    return nil;
}

+ (NSError *)updateObjToDB:(id)Obj WithKey:(NSString *)key
{
    if (Obj == nil) {
        NSError *error =  [NSError errorWithDomain:[NSString stringWithFormat:@"[save error] :%@", Obj] code:0 userInfo:nil];
        DDLogError(@"%s:%d,%@",__FILE__,__LINE__,[error description]);
        return error;
    }
    LKDBHelper *globalHelper = [[self class] getUsingLKDBHelperEx:nil];
    
    if (globalHelper == nil) {
        NSError *error = [NSError errorWithDomain:[NSString stringWithFormat:@"[save error] :%@", Obj] code:1 userInfo:nil];
        DDLogError(@"%s:%d,%@",__FILE__,__LINE__,[error description]);
        return error;
    }
    
    NSString *where = [NSString stringWithFormat:@"%@ = '%@'", [[self class] getPrimaryKey], key];
    
    if ([[self class] getObjFromDBWithKey:key]) {
        if (![globalHelper updateToDB:Obj where:where])
        {
            NSError *error =  [NSError errorWithDomain:[NSString stringWithFormat:@"[save error] :%@", Obj] code:0 userInfo:nil];
            DDLogError(@"%s:%d,%@",__FILE__,__LINE__,[error description]);
            return error;
        }
    }
    else
    {
        //如果失败插入数据
        [globalHelper insertToDB:Obj];
    }
    
    return nil;
}

+ (NSError *)updateSetToDB:(NSString*)set WithKey:(NSString *)key
{
    if (set == nil) {
        NSError *error = [NSError errorWithDomain:[NSString stringWithFormat:@"[save error] :%@", set] code:0 userInfo:nil];
        DDLogError(@"%s:%d,%@",__FILE__,__LINE__,[error description]);
        return error;
    }
    LKDBHelper *globalHelper = [[self class] getUsingLKDBHelperEx:nil];
    
    if (globalHelper == nil) {
        NSError *error =  [NSError errorWithDomain:[NSString stringWithFormat:@"[save error] :%@", set] code:1 userInfo:nil];
        DDLogError(@"%s:%d,%@",__FILE__,__LINE__,[error description]);
        return error;
    }
    
    NSString *where = [NSString stringWithFormat:@"%@ = '%@'", [[self class] getPrimaryKey], key];
    
    if ([[self class] getObjFromDBWithKey:key]) {
        if (![globalHelper updateToDB:[self class] set:set where:where])
        {
            NSError *error = [NSError errorWithDomain:[NSString stringWithFormat:@"[save error] :%@", set] code:0 userInfo:nil];
            DDLogError(@"%s:%d,%@",__FILE__,__LINE__,[error description]);
            return error;
        }
    }
    
    return nil;
}

+ (NSError *)updateSetToDB:(NSString*)set WithWhere:(NSString *)where
{
    if (where.length == 0) {
        NSError *error =  [NSError errorWithDomain:[NSString stringWithFormat:@"[save error] :%@", set] code:0 userInfo:nil];
        DDLogError(@"%s:%d,%@",__FILE__,__LINE__,[error description]);
        return error;
    }
    if (set == nil) {
        NSError *error = [NSError errorWithDomain:[NSString stringWithFormat:@"[save error] :%@", set] code:0 userInfo:nil];
        DDLogError(@"%s:%d,%@",__FILE__,__LINE__,[error description]);
        return error;
    }
    LKDBHelper *globalHelper = [[self class] getUsingLKDBHelperEx:nil];
    
    if (globalHelper == nil) {
        NSError *error = [NSError errorWithDomain:[NSString stringWithFormat:@"[save error] :%@", set] code:1 userInfo:nil];
        DDLogError(@"%s:%d,%@",__FILE__,__LINE__,[error description]);
        return error;
    }
    
    if (![globalHelper updateToDB:[self class] set:set where:where])
    {
        NSError *error = [NSError errorWithDomain:[NSString stringWithFormat:@"[save error] :%@", set] code:0 userInfo:nil];
        DDLogError(@"%s:%d,%@",__FILE__,__LINE__,[error description]);
        return error;
    }
    
    return nil;
}

+ (id)getObjFromDBWithKey:(NSString *)key
{
    if (key.length == 0)
        return nil;
    
    LKDBHelper *globalHelper = [[self class] getUsingLKDBHelperEx:nil];
    if (globalHelper == nil) {
        return nil;
    }
    
    id object = [[self alloc] init];
    
    NSString *where = nil;
    
    if ([key isKindOfClass:[NSString class]])
    {
        where = [NSString stringWithFormat:@"%@ = '%@'", [[self class] getPrimaryKey], key];
    }
    else if ([key isKindOfClass:[NSNumber class]])
    {
        where = [NSString stringWithFormat:@"%@ = %@", [[self class] getPrimaryKey], key];
    }
    else if (1)
    {
#pragma mark-  多主键种类判断
        where = @"";
    }
    
    object = [globalHelper searchSingle:[self class] where:where orderBy:nil];
    return object;
}

+ (id)getObjFromDBWithWhere:(NSString *)where
{
    
    id object = [[self alloc] init];
 
    LKDBHelper *globalHelper = [[self class] getUsingLKDBHelperEx:nil];
    if (globalHelper == nil) {
        return nil;
    }
    
    if (where.length == 0)
    {
        object = [globalHelper searchSingle:[self class] where:nil orderBy:nil];
    }
    else
    {
        object = [globalHelper searchSingle:[self class] where:where orderBy:nil];
    }
    
    return object;
}

+ (id)getObjFromDBWithWhere:(NSString *)where WithorderBy:(NSString*)value
{
    
    id object = [[self alloc] init];
    
    LKDBHelper *globalHelper = [[self class] getUsingLKDBHelperEx:nil];
    if (globalHelper == nil) {
        return nil;
    }
    
    if (where.length == 0)
    {
        object = [globalHelper searchSingle:[self class] where:nil orderBy:value];
    }
    else
    {
        object = [globalHelper searchSingle:[self class] where:where orderBy:value];
    }
    
    return object;
}

+ (NSArray *)getArrayFromDBWithWhere:(NSString *)where
{
    LKDBHelper *globalHelper = [[self class] getUsingLKDBHelperEx:nil];
    if (globalHelper == nil) {
        return nil;
    }
    
    if (where.length == 0 || where == nil)
    {
        return [globalHelper search:[self class] where:nil orderBy:nil offset:0 count:0];
    }
    else
    {
        return [globalHelper search:[self class] where:where orderBy:nil offset:0 count:0];
    }
}

+ (NSArray *)getArrayFromDBWithWhere:(NSString *)where WithorderBy:(NSString*)value
{
    LKDBHelper *globalHelper = [[self class] getUsingLKDBHelperEx:nil];
    if (globalHelper == nil) {
        return nil;
    }
    
    if (where.length == 0 || where == nil)
    {
        return [globalHelper search:[self class] where:nil orderBy:value offset:0 count:0];
    }
    else
    {
        return [globalHelper search:[self class] where:where orderBy:value offset:0 count:0];
    }
}

+ (void)getArrayFromDBWithWhere:(NSString *)where callback:(void (^)(NSMutableArray *))block
{
    LKDBHelper *globalHelper = [[self class] getUsingLKDBHelperEx:nil];
    if (globalHelper == nil) {
        return;
    }
    
    if (where.length == 0 || where == nil)
    {
        [globalHelper search:[self class] where:nil orderBy:nil offset:0 count:0 callback:block];
    }
    else
    {
        [globalHelper search:[self class] where:where orderBy:nil offset:0 count:0 callback:block];
    }
}

+ (void)getArrayFromDBWithWhere:(NSString *)where WithorderBy:(NSString*)value callback:(void (^)(NSMutableArray *))block
{
    LKDBHelper *globalHelper = [[self class] getUsingLKDBHelperEx:nil];
    if (globalHelper == nil) {
        return;
    }
    
    if (where.length == 0 || where == nil)
    {
        [globalHelper search:[self class] where:nil orderBy:value offset:0 count:0 callback:block];
    }
    else
    {
        [globalHelper search:[self class] where:where orderBy:value offset:0 count:0 callback:block];
    }
}


+ (NSInteger)getcountFromDBWithWhere:(NSString *)where
{
    LKDBHelper *globalHelper = [[self class] getUsingLKDBHelperEx:nil];
    if (globalHelper == nil) {
        return 0;
    }
    return [globalHelper rowCount:[self class] where:where];
}

+ (NSError *)deleteObjFromDBWithKey:(NSString *)key
{
    LKDBHelper *globalHelper = [[self class] getUsingLKDBHelperEx:nil];
    if (globalHelper == nil) {
        NSError *error = [NSError errorWithDomain:[NSString stringWithFormat:@"[delete error] : %@ %@", [self class], key] code:0 userInfo:nil];
        DDLogError(@"%s:%d,%@",__FILE__,__LINE__,[error description]);
        return error;
    }
    NSString * where = [NSString stringWithFormat:@"%@ = '%@'", [[self class] getPrimaryKey], key];
    if (![globalHelper deleteWithClass:[self class] where:where])
    {
        NSError *error = [NSError errorWithDomain:[NSString stringWithFormat:@"[delete error] : %@ %@", [self class], key] code:0 userInfo:nil];
        DDLogError(@"%s:%d,%@",__FILE__,__LINE__,[error description]);
        return error;
    }
    
    return nil;
}

+ (NSError *)deleteObjFromDBWithWhere:(NSString *)where
{
    LKDBHelper *globalHelper = [[self class] getUsingLKDBHelperEx:nil];
    if (globalHelper == nil) {
        NSError *error = [NSError errorWithDomain:[NSString stringWithFormat:@"[delete error] : %@ %@", [self class], where] code:0 userInfo:nil];
        DDLogError(@"%s:%d,%@",__FILE__,__LINE__,[error description]);
        return error;
    }
    
    if (![globalHelper deleteWithClass:[self class] where:where])
    {
        NSError *error = [NSError errorWithDomain:[NSString stringWithFormat:@"[delete error] : %@ %@", [self class], where] code:0 userInfo:nil];
        DDLogError(@"%s:%d,%@",__FILE__,__LINE__,[error description]);
        return error;
    }
    
    return nil;
}

+ (void)deleteAllObjFromDB
{
    [LKDBHelper clearTableData:[self class]];
}


+(LKDBHelper*)getUsingLKDBHelperEx:(NSString*)dbName
{
    static LKDBHelper* db;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        NSString* dbpath = [LKDBHelper getDBPathWithDBName:@"public"];
        
        db = [[LKDBHelper alloc] initWithDBPath:dbpath];
        
    });
    [db createTableWithModelClass:[self class] tableName:[[self class] getTableName]];
    return db;
}

+(void)insertToDBWithArray:(NSArray *)models filter:(void (^)(id model, BOOL inseted, BOOL * rollback))filter
{
    
    
    [super insertToDBWithArray:models filter:filter];
    
}

//add by yqy

//end
@end
