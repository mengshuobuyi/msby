//
//  NewUserCenterFooterView.h
//  APP
//
//  Created by qw_imac on 16/6/13.
//  Copyright © 2016年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewUserCenterFooterView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UIButton *telBtn;
-(void)setView:(NSString *)tel;
@end
