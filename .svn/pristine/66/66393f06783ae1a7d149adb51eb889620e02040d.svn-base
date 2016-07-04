//
//  GlobalManager.m
//  APP
//
//  Created by carret on 15/1/16.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "GlobalManager.h"
#import "SystemMacro.h"
@implementation GlobalManager
+ (GlobalManager *)sharedInstance
{
    DEFINE_SHARED_INSTANCE_USING_BLOCK(^{
        return [[self alloc] init];
    });
}
- (BOOL)console {
#ifdef CONSOLE
    return YES;
#else
    return NO;
#endif
    
}
- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}
- (BOOL)iPhone {
    return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone ? YES : NO;
}

- (BOOL)iPad {
    return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad ? YES : NO;
}

#pragma mark 判断
- (BOOL)isNULL:(id)obj{
    if (obj==nil || [obj isKindOfClass:[NSNull class]]) {
        return YES;
    }
    return NO;
}

- (BOOL)object:(id)obj isClass:(Class)aClass {
    if (![self isNULL:obj] && [obj isKindOfClass:aClass]) {
        return YES;
    }
    return NO;
}

- (BOOL)isStringEmpty:(id)obj{
    if (obj==nil || [obj isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([obj isKindOfClass:[NSString class]]) {
        if ([obj length]==0) {
            return YES;
        }
    }

    return NO;
    
}

- (NSString*)targetString:(NSString*)targetString defaultString:(NSString*)defaultString
{
    if (!StrIsEmpty(targetString)) {
        return targetString;
    }
    if (!StrIsEmpty(defaultString)) {
        return defaultString;
    }
    return @"";
}

- (BOOL)isPhoneNumber:(NSString*)text
{
    NSString * regex = @"^([1])([0-9]{10})$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([predicate evaluateWithObject:text]) {
        return YES;
    }
    return NO;
}

- (BOOL)isEmailAddress:(NSString*)text
{
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([predicate evaluateWithObject:text]) {
        return YES;
    }
    return NO;
}

#pragma mark 发出全局通知
- (NSDictionary *)postNotif:(NSInteger)type data:(id)data object:(id)obj{
    NSMutableDictionary *info=[NSMutableDictionary dictionary];
    [info setObject:[NSNumber numberWithInteger:type] forKey:@"type"];
    if (data) {
        [info setObject:data forKey:@"data"];
    }
    if (obj) {
        [info setObject:obj forKey:@"object"];
    }

    [[NSNotificationCenter defaultCenter] postNotificationName:kQWGlobalNotification object:obj userInfo:info];
    return info;
}

#pragma mark 文字高度
- (CGSize)sizeText:(NSString*)text
              font:(UIFont*)font
        limitWidth:(float)width
{
    NSDictionary *attributes = @{NSFontAttributeName:font};
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                     options:NSStringDrawingUsesLineFragmentOrigin//|NSStringDrawingUsesFontLeading
                                  attributes:attributes
                                     context:nil];
    rect.size.width=width;
    rect.size.height=ceil(rect.size.height);
    return rect.size;
}

- (CGSize)sizeText:(NSString*)text
              font:(UIFont*)font
        limitHeight:(float)height
{
    NSDictionary *attributes = @{NSFontAttributeName:font};
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                     options:NSStringDrawingUsesLineFragmentOrigin//|NSStringDrawingUsesFontLeading
                                  attributes:attributes
                                     context:nil];
    rect.size.height=height;
    rect.size.width=ceil(rect.size.width);
    return rect.size;
}

- (CGSize)sizeText:(NSString*)text font:(UIFont*)font{
    return [text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];
}

- (CGSize)sizeText:(NSString*)text font:(UIFont*)font constrainedToSize:(CGSize)size{
    return [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] context:nil].size;
//    return [text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];
}
#pragma mark 设置边距
- (void)setObject:(UIView*)object margin:(CGFloat)margin edge:(Enum_Edge)edge{
    if (object && [object isMemberOfClass:[UIView class]]) {
        CGRect frm=object.frame;
        if (edge & EdgeLeft) {
            frm.size.width -= margin;
            frm.origin.x = margin;
        }
        if (edge & EdgeRight) {
            frm.size.width -= margin;
        }
        if (edge & EdgeTop) {
            frm.size.height -= margin;
            frm.origin.y = margin;
        }
        if (edge & EdgeBottom) {
            frm.size.height -= margin;
        }
        
        object.frame=frm;
    }
}

#pragma mark 判断键盘输入模式是否是表情模式

/**
 *  @brief 判断键盘当前是否是表情输入模式
 *
 *  @param inputControl 传入调出键盘的控件对象 例如:UITextField UITextView
 *
 *  @return YES表示是表情输入模式, NO表示不是表情模式
 */
- (BOOL)judgeTheKeyboardInputModeIsEmojiOrNot:(id)inputControl
{
    UITextInputMode *inputMode = nil;
    if ([inputControl isKindOfClass:[UIResponder class]]) {
        UIResponder *c = (UIResponder *)inputControl;
        inputMode = c.textInputMode;
    }
    if (inputMode == nil) {
        return YES;
    }
    return NO;
}

@end
