//
//  SlowDiseaseListCell.h
//  APP
//
//  Created by PerryChen on 8/22/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "QWBaseCell.h"

@protocol SlowDiseaseCellDelegate <NSObject>

- (void)selectDiseaseCell:(BOOL)isSelect withIndex:(NSInteger)index;

@end

@interface SlowDiseaseListCell : QWBaseCell
{
    
}

@property (weak, nonatomic) IBOutlet UILabel *lblDiseaseTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imgSelected;
@property (weak, nonatomic) IBOutlet UIButton *btnSelect;
@property (assign, nonatomic) NSInteger intSelectedIndex;
@property (weak, nonatomic) id<SlowDiseaseCellDelegate> cellDelegate;

- (IBAction)action_diseaseSelect:(UIButton *)sender;

@end
