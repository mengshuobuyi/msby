//
//  myConsultTableViewCell.h
//  APP
//
//  Created by 李坚 on 15/8/24.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QWBaseCell.h"
#import "RatingView.h"

@protocol myConsultTableViewCellDelegate <NSObject>

- (void)takeTalk:(NSString *)branchId name:(NSString *)branchName;
- (void)takePhone:(NSString *)telNumber;

@end

@interface myConsultTableViewCell : QWBaseCell{
    
}

@property (assign, nonatomic) BOOL chatEnable;

@property (weak, nonatomic) IBOutlet UIImageView *branchImage;
@property (weak, nonatomic) IBOutlet UIButton *phoneButton;
@property (weak, nonatomic) IBOutlet UIButton *chatButton;
@property (weak, nonatomic) IBOutlet UIImageView *phoneImage;
@property (weak, nonatomic) IBOutlet UIView *viewSeparateLine;
@property (weak, nonatomic) IBOutlet UIButton *useButton;

@property (weak, nonatomic) IBOutlet UILabel *branchName;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *distance;
@property (weak, nonatomic) IBOutlet RatingView *starView;

@property (copy, nonatomic) NSString *branchId;
@property (copy, nonatomic) NSString *telNumber;

@property (assign, nonatomic) id<myConsultTableViewCellDelegate>cellDelegate;

- (IBAction)onClickChat:(id)sender;
- (IBAction)onClickPhone:(id)sender;

+ (CGFloat)getCellHeight:(id)data;

- (void)setCell:(id)data;

@end
