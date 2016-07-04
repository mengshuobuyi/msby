//
//  AppGuide.h
//  quanzhi
//
//  Created by ZhongYun on 14-1-28.
//  Copyright (c) 2014年 ZhongYun. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  启动引导页
 */
@interface AppGuide : UIView

@property(nonatomic,retain)NSArray* imgNames;
@property(nonatomic,strong)UIImage* image;
@property(nonatomic,assign)int      count;

@end

void showAppGuide(NSArray* images);
void showAppOPGuide(UIImage* image);
