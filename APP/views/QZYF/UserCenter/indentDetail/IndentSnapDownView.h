//
//  IndentSnapDownView.h
//  APP
//
//  Created by qw_imac on 16/3/14.
//  Copyright © 2016年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IndentSnapDownView : UIView
@property (weak, nonatomic) IBOutlet UILabel *secLabel;
@property (weak, nonatomic) IBOutlet UILabel *minLabel;
+(IndentSnapDownView *)indentSnapDownView;
-(void)updateUI:(double)time;
@end
