//
//  ChooseBranchTableViewCell.m
//  APP
//
//  Created by 李坚 on 16/6/13.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "ChooseBranchTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation ChooseBranchTableViewCell

+ (CGFloat)getCellHeight:(id)data{
    
    return 100.0f;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.branchImg.image = [UIImage imageNamed:@"ic_yaofang_pepole"];
    self.branchImg.layer.masksToBounds = YES;
    self.branchImg.layer.cornerRadius = 2.0f;
    self.branchNameLabel.text = @"";
    self.addressLabel.text = @"";
    self.distanceLabel.text = @"";
    
    UIView *sepatorLine = [[UIView alloc]initWithFrame:CGRectMake(0, [ChooseBranchTableViewCell getCellHeight:nil] - 0.5f, APP_W, 0.5f)];
    sepatorLine.backgroundColor = RGBHex(qwColor10);
    [self addSubview:sepatorLine];
}

- (void)setCell:(MicroMallBranchVo *)model{
    
    [self.branchImg setImageWithURL:[NSURL URLWithString:model.branchLogo] placeholderImage:[UIImage imageNamed:@"ic_yaofang_pepole"]];
    self.branchNameLabel.text = model.branchName;
    self.addressLabel.text = model.address;
    self.distanceLabel.text = model.distance;
    [self setupServiceUI:model.postTag];
    
}

- (void)setupServiceUI:(NSString *)Str{
    
    if(self.serviceLabel.subviews.count > 0){
        
        for(UIView *view in self.serviceLabel.subviews){
            [view removeFromSuperview];
        }
    }
    
    NSMutableArray *Arr = [NSMutableArray array];
    
    NSRange range;
    range = [Str rangeOfString:@"同城快递"];
    if (range.length >0){
        [Arr addObject:@"同城快递"];
    }
    range = [Str rangeOfString:@"送货上门"];
    if (range.length >0){
        [Arr addObject:@"送货上门"];
    }
    range = [Str rangeOfString:@"到店取货"];
    if (range.length >0){
        [Arr addObject:@"到店取货"];
    }
    
    int i = 1;
    CGFloat conX = 0.0f;
    for(NSString *str in Arr){
        
        if(i != 1){
            UIView *sepator = [[UIView alloc]initWithFrame:CGRectMake(conX + 8, 0, 0.5, self.serviceLabel.frame.size.height)];
            sepator.backgroundColor = RGBHex(qwColor10);
            [self.serviceLabel addSubview:sepator];
            conX += 16.0f;
        }
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(conX, 0, 50, self.serviceLabel.frame.size.height)];
        label.font = fontSystem(kFontS5);
        label.textColor = RGBHex(qwColor7);
        label.text = str;
        [self.serviceLabel addSubview:label];
        conX += label.frame.size.width;
        i ++;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
