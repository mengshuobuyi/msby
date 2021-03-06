//
//  MedicineUseTypeTableViewCell.m
//  APP
//
//  Created by 李坚 on 16/2/18.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "MedicineUseTypeTableViewCell.h"
#import "QWGlobalManager.h"
@implementation MedicineUseTypeTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.clipsToBounds = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

+ (CGFloat)getCellHeight:(ProductInstructionsVo *)VO{
    if(StrIsEmpty(VO.title)){
        return 0.0f;
    }
    if(StrIsEmpty(VO.content)){
        return 55.0f;
    }
    
    CGFloat LabelHeight = [QWGLOBALMANAGER sizeText:VO.content font:fontSystem(kFontS4) limitWidth:APP_W - 30.0f].height;
    if(LabelHeight > 30.0f){
        return 109.0f;
    }else{
        return 74.0f +  LabelHeight;
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
}

- (void)setCell:(ProductInstructionsVo *)VO{

    self.mainLabel.text = VO.title;
    self.useLabel.text = [QWGLOBALMANAGER replaceSpecialStringWith:VO.content];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
