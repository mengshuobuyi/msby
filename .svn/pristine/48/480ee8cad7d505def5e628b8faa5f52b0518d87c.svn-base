//
//  MallBranchTableViewCell.m
//  APP
//
//  Created by 李坚 on 16/6/17.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "MallBranchTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation MallBranchTableViewCell

+ (CGFloat)getCellHeight:(id)data{
    return 100.0f;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.imgUrl.image = [UIImage imageNamed:@"img_bg_pharmacy"];
    self.nameLabel.text = @"";
    [self.ratView setImagesDeselected:@"star_none" partlySelected:@"star_half" fullSelected:@"star_full" andDelegate:nil];
    self.ratView.userInteractionEnabled = NO;
    [self.ratView displayRating:0.0f];
    self.distanceLabel.text = @"";
    
    UIView *sepatorLine = [[UIView alloc]initWithFrame:CGRectMake(0, [MallBranchTableViewCell getCellHeight:nil] - 0.5f, APP_W, 0.5f)];
    sepatorLine.backgroundColor = RGBHex(qwColor10);
    [self addSubview:sepatorLine];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCell:(MicroMallBranchVo *)model{
    
    self.nameLabel.text = model.branchName;
    
    NSString *imgUrl;
    if(!StrIsEmpty(model.logo)){
        imgUrl = model.logo;
    }else if(!StrIsEmpty(model.branchLogo)){
        imgUrl = model.branchLogo;
    }else{
        imgUrl = @"";
    }
    if(!StrIsEmpty(imgUrl)){
        [_imgUrl setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"img_bg_pharmacy"]];
    }else{
        [_imgUrl setImage:[UIImage imageNamed:@"img_bg_pharmacy"]];
    }

    [self.ratView displayRating:[model.stars floatValue]/2.0];
    [self setupServiceUI:model.postTag];
    
    self.distanceLabel.text = [NSString stringWithFormat:@"%@",model.distance];
}

- (void)setupServiceUI:(NSString *)Str{
    
    for(UIView *v in self.serviceLabel.subviews){
        [v removeFromSuperview];
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
            sepator.backgroundColor = RGBHex(qwColor7);
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


@end
