//
//  ResultBranchTableViewCell.m
//  APP
//
//  Created by 李坚 on 16/6/16.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "ResultBranchTableViewCell.h"

@implementation ResultBranchTableViewCell

//注意UI逻辑！！！
//当结果药房不带活动的时候，nameConstant:24.0f,distantceConstant:30.0f
//当结果药房有了活动的时候，nameConstant:12.0f,distantceConstant:17.0f

+ (CGFloat)getCellHeight:(MicroMallBranchVo *)data{

    return 85.0f;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APP_W, 0.5)];
    line.backgroundColor = RGBHex(qwColor10);
    [self addSubview:line];
    
}

- (void)setCell:(MicroMallBranchVo *)model
{
    if(model.promotions.count > 0){
        self.nameConstant.constant = 12.0f;
        self.distanceConstant.constant = 17.0f;
        self.couponView.hidden= NO;
    }else{
        self.nameConstant.constant = 24.0f;
        self.distanceConstant.constant = 30.0f;
        self.couponView.hidden= YES;
    }
    
    CGRect rect = _line.frame;
    rect.origin.y = [ResultBranchTableViewCell getCellHeight:model] - 0.5;
    _line.frame = rect;
    
    self.nameLabel.text = model.branchName;

    [self setupServiceUI:model.postTag];

    self.distanceLabel.text = [NSString stringWithFormat:@"%@",model.distance];

    self.priceLabel.text = [NSString stringWithFormat:@"￥%.1f",[model.price floatValue]];
    
    [self setupImageAndName:model.promotions andSpell:model.spelled];

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


-(void)setupImageAndName:(NSArray *)Arr andSpell:(BOOL)flag{

    
    for(UIView *v in self.couponView.subviews){
        [v removeFromSuperview];
    }
    
    int i = 0;
    CGFloat conY = 0.0f;
    
    for(BranchProductPromotionVo *VO in Arr){
        
        if(i > 1 && !flag){
            return;
        }
        if(i > 4){
            break;
        }
        
        UIImageView *imageText = [[UIImageView alloc]initWithFrame:CGRectMake(0, conY, 14, 14)];
        //展示活动类型:1.券 2.惠 3.抢 4.套餐 5.换购
        if([VO.showType intValue] == 1){
            imageText.image = [UIImage imageNamed:@"label_vouchers"];
        }
        if([VO.showType intValue] == 2){
            imageText.image = [UIImage imageNamed:@"label_hui"];
        }
        if([VO.showType intValue] == 3){
            imageText.image = [UIImage imageNamed:@"label_rob"];
        }
        if([VO.showType intValue] == 4){
            imageText.image = [UIImage imageNamed:@"label_tao"];
        }
        if([VO.showType intValue] == 5){
            imageText.image = [UIImage imageNamed:@"label_huan"];
        }
        
        imageText.contentMode = UIViewContentModeScaleToFill;
        [self.couponView addSubview:imageText];
        
        UILabel *labelText = [[UILabel alloc]initWithFrame:CGRectMake(16, conY, self.couponView.frame.size.width - 20, 14)];
        labelText.font = fontSystem(kFontS5);
        labelText.textColor = RGBHex(qwColor8);
        labelText.text = VO.title;
        [self.couponView addSubview:labelText];
        
        conY += 20.0f;
        i ++;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
