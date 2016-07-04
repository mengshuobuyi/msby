//
//  LevelHeaderView.h
//  APP
//
//  Created by qw_imac on 16/2/3.
//  Copyright © 2016年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LevelHeaderView : UIView
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
+(LevelHeaderView *)LevelHeaderView;
@end
