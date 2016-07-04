//
//  CustomSheetView.h
//  APP
//
//  Created by carret on 15/8/30.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CustomSheetViewDelegate;
@interface CustomSheetView : UIView
@property (weak, nonatomic) IBOutlet UIButton *one;
@property (weak, nonatomic) IBOutlet UIButton *two;
@property (weak, nonatomic) IBOutlet UIButton *three;
@property (weak, nonatomic) IBOutlet UIButton *four;
@property (weak, nonatomic) IBOutlet UIView *footerView;
@property (nonatomic, assign) id<CustomSheetViewDelegate> delegate;
- (void)fadeIn;
- (void)fadeOut;

- (void)didslevt:(id)sender;


@end
@protocol CustomSheetViewDelegate <NSObject>
- (void)customSheetView:(CustomSheetView *)customSheetView didSelectedIndex:(NSInteger)anIndex ;
- (void)customSheetViewDidCancel;
@end