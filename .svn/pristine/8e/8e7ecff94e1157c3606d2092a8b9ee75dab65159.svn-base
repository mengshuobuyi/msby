//
//  UIView+LoadFromNib.m
//  BannerDemo
//
//  Created by Meng on 15/6/4.
//  Copyright (c) 2015年 Meng. All rights reserved.
//

#import "UIView+LoadFromNib.h"

@implementation UIView (LoadFromNib)

+ (id)loadFromNib
{
    id view = nil;
    NSString *xibName = NSStringFromClass([self class]);
    UIViewController *co = [[UIViewController alloc] initWithNibName:xibName bundle:nil];
    if (co) {
        view = co.view;
    }
    return view;
}

@end
