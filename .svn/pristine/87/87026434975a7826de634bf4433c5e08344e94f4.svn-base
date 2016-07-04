//
//  ScenarioDrugCell.m
//  APP
//
//  Created by caojing on 15-3-10.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "ScenarioDrugCell.h"
#import "DrugModel.h"

@implementation ScenarioDrugCell
@synthesize imgPath = imgPath;
@synthesize name = name;
@synthesize desc=desc;
@synthesize backImg=backImg;

+ (CGFloat)getCellHeight:(id)obj{
    return 63.0f;
}

- (void)UIGlobal{
    [super UIGlobal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setDrugCell:(id)data row:(NSInteger)number{
    
    [super setCell:data];
    if(number == 0) {
        [self.backImg setImage:[UIImage imageNamed:@"子常备药品推荐顶.png"]];
    }else{
        [self.backImg setImage:[UIImage imageNamed:@"子常备药品推荐底.png"]];
    }
    [self.imgPath setPlaceholderName:@"药品默认图片.png"];
    
    
}
@end
