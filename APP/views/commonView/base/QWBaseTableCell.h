//
//  QWBaseTableCell.h
//  APP
//
//  Created by Yan Qingyang on 15/2/27.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "QWBaseCell.h"
#import "Constant.h"
#import "QWGlobalManager.h"
@interface QWBaseTableCell : QWBaseCell
//@property(nonatomic, assign) id delegate;

/**
 *  传递需要返回到的页面位置
 */
//@property (nonatomic, assign) id delegatePopVC;

/**
 *  是否显示分割线
 */
//@property (assign) BOOL separatorHidden;
//@property (nonatomic, retain) UIView* separatorLine;

/*!
 @method
 @brief 返回cell当前高度
 @param 传递cell内容用于计算cell实际高度
 @discussion
 @result 返回高度值
 */

/*!
 @method
 @brief 设置cell内容
 @param 传递cell内容用于设置
 @discussion
 @result
 */
- (void)setCell:(id)data;

/**
 *  app的UI全局设置，包括背景色，top bar背景等
 */
- (void)UIGlobal;

/**
 *  设置分割线前后边距
 *
 *  @param margin 边距
 *  @param edge   前还是后
 */



/**
 *  设置选择后背景的颜色
 *
 *  @param aColor 颜色color
 */
//- (void)setSelectedBGColor:(UIColor*)aColor;
@end
