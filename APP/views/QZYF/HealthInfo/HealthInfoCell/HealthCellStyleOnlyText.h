//
//  HealthCellStyleOnlyText.h
//  APP
//
//  Created by PerryChen on 1/8/16.
//  Copyright © 2016 carret. All rights reserved.
//

#import "QWBaseCell.h"

@interface HealthCellStyleOnlyText : QWBaseCell
@property (weak, nonatomic) IBOutlet UIView *viewTop;
@property (weak, nonatomic) IBOutlet UILabel *lblHealthContent;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewTag;
@property (weak, nonatomic) IBOutlet UILabel *lblTag;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UILabel *lblReadNum;

@end
