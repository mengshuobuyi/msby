//
//  AddNewDiseaseSubscriptionTableViewCell.m
//  wenyao
//
//  Created by Pan@QW on 14-9-25.
//  Copyright (c) 2014年 xiezhenghong. All rights reserved.
//

#import "AddNewDiseaseSubscriptionTableViewCell.h"
#import "DrugGuideModel.h"
@implementation AddNewDiseaseSubscriptionTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCell:(id)data
{
    [super setCell:data];
    
    DrugAttentionChildModel *model = (DrugAttentionChildModel *)data;
    self.titleLabel.text = model.name;
}

@end
