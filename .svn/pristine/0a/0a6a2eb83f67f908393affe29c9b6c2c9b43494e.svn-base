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

@protocol otherPharmcyTableViewCellDelegate <NSObject>

- (void)takeTalk:(NSString *)branchId name:(NSString *)branchName;

@end

@interface otherPharmcyTableViewCell : QWBaseCell{
    
}

@property (weak, nonatomic) IBOutlet UIButton *useButton;
@property (weak, nonatomic) IBOutlet UILabel *branchName;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *distance;
@property (weak, nonatomic) IBOutlet RatingView *starView;

@property (copy, nonatomic) NSString *branchId;


@property (assign, nonatomic) id<otherPharmcyTableViewCellDelegate>cellDelegate;

+ (CGFloat)getCellHeight:(id)data;

- (void)setCell:(id)data;

- (void)setMyCell:(id)data;
- (IBAction)getUseAction:(id)sender;

@end
