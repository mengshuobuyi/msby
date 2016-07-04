//
//  HealthCellStyleTwo.h
//  APP
//
//  Created by PerryChen on 1/5/16.
//  Copyright © 2016 carret. All rights reserved.
//

#import "QWBaseCell.h"

@interface HealthCellStyleLargeImg : QWBaseCell
@property (weak, nonatomic) IBOutlet UIImageView *imgViewContent;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UILabel *lblReadNum;
@property (weak, nonatomic) IBOutlet UILabel *lblHealthContent;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintImgHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintImgWidth;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewTag;
@property (weak, nonatomic) IBOutlet UILabel *lblTag;
@property (weak, nonatomic) IBOutlet UIView *viewTop;

@end
