//
//  WeiStoreTableViewCell.m
//  APP
//
//  Created by 李坚 on 15/12/31.
//  Copyright © 2015年 carret. All rights reserved.
//

#import "WeiStoreTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation WeiStoreTableViewCell

- (void)awakeFromNib {
    // Initialization code
    UIView *selectedView = [[UIView alloc]init];
    selectedView.backgroundColor = [UIColor clearColor];
    self.selectedBackgroundView = selectedView;
    self.clipsToBounds = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.ratView setImagesDeselected:@"star_none" partlySelected:@"star_half" fullSelected:@"star_full" andDelegate:nil];
    self.ratView.userInteractionEnabled = NO;

    _line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APP_W, 0.5)];
    _line.backgroundColor = RGBHex(qwColor10);
    [self addSubview:_line];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)getCellHeight:(MicroMallBranchVo *)sender{

    if(sender.promotions == nil){
        return 88.0f;
    }
    
    switch (sender.promotions.count) {
        case 0:
            return 88.0f;
            break;
        case 1:
            return 111.0f;
            break;
        case 2:
            return 125.0f;
            break;
        case 3:
            if(sender.spelled){
                return 145.0f;
            }else{
                return 125.0f;
            }
            break;
        case 4:
            if(sender.spelled){
                return 162.0f;
            }else{
                return 125.0f;
            }
            break;
        case 5:
            if(sender.spelled){
                return 179.0f;
            }else{
                return 125.0f;
            }
            break;
        default:{
            if(sender.spelled){
                return 179.0f;
            }else{
                return 125.0f;
            }
        }
            break;
    }
   
}

- (void)setCell:(MicroMallBranchVo *)model withSpell:(spellCallback)callback{
    CGRect rect = _line.frame;
    rect.origin.y = [WeiStoreTableViewCell getCellHeight:model] - 0.5;
    _line.frame = rect;
    self.callback = callback;
    
    self.proName.text = model.branchName;
    
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
    if([model.type intValue] == 2){
        self.ratView.hidden = YES;
        [self setupServiceUI:@""];
    }else{
        self.ratView.hidden = NO;
    }
    
    [self.ratView displayRating:[model.stars floatValue]/2.0];
    [self setupServiceUI:model.postTag];
    
//    if(model.distance.length > 5){
//        model.distance = [NSString stringWithFormat:@"%@km",[model.distance substringToIndex:3]];
//    }
    
    self.distanceLabel.text = [NSString stringWithFormat:@"%@",model.distance];
    if([model.star boolValue]){
        self.VImage.hidden = NO;
    }else{
        self.VImage.hidden = YES;
    }

    if(model.promotions == nil || model.promotions.count <= 2){
        self.couponCountLabel.hidden = YES;
    }else{
        self.couponCountLabel.hidden = NO;
        self.couponCountLabel.text = [NSString stringWithFormat:@"%d个活动",(int)model.promotions.count > 5?5:(int)model.promotions.count];
    }
    
    [self setupImageAndName:model.promotions andSpell:model.spelled];
    
    if(model.promotions.count <= 2){
        _sepllImage.hidden = YES;
        _sepllBtn.enabled = NO;
    }else{
        _sepllImage.hidden = NO;
        _sepllBtn.enabled = YES;
    }
}

- (void)setNoMiCell:(MicroMallBranchVo *)model withSpell:(spellCallback)callback{

    
    CGRect rect = _line.frame;
    
//    if(model.promotions.count>0){
//        switch (model.promotions.count) {
//            case 0:
//                rect.origin.y = 87.5f;
//                break;
//            case 1:
//                rect.origin.y = 109.5f;
//                break;
//            case 2:
//                rect.origin.y = 124.5f;
//                break;
//            case 3:
//                if(model.spelled){
//                    rect.origin.y = 144.5f;
//                }else{
//                    rect.origin.y = 124.5f;
//                }
//                break;
//            case 4:
//                if(model.spelled){
//                    rect.origin.y = 161.5f;
//
//                }else{
//                    rect.origin.y = 124.5f;
//                }
//                break;
//            case 5:
//                if(model.spelled){
//                    rect.origin.y = 178.5f;
//                }else{
//                    rect.origin.y = 124.5f;
//                }
//                break;
//            default:{
//                if(model.spelled){
//                    rect.origin.y = 178.5f;
//                }else{
//                    rect.origin.y = 124.5f;
//                }
//            }
//                break;
//        }
//    }else{
//        rect.origin.y = 87.5;
//    }
    rect.origin.y = 87.5;
    _line.frame = rect;
    self.callback = callback;
    
    self.proName.text = model.branchName;
    
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
    if([model.type intValue] == 2){
        self.ratView.hidden = YES;
        [self setupServiceUI:@""];
    }else{
        self.ratView.hidden = NO;
    }
    
    [self.ratView displayRating:[model.stars floatValue]/2.0];
    [self setupServiceUI:model.postTag];
    
    //    if(model.distance.length > 5){
    //        model.distance = [NSString stringWithFormat:@"%@km",[model.distance substringToIndex:3]];
    //    }
    
    self.distanceLabel.text = [NSString stringWithFormat:@"%@",model.distance];
    self.distanceLabel.hidden=YES;
    if([model.star boolValue]){
        self.VImage.hidden = NO;
    }else{
        self.VImage.hidden = YES;
    }
    
//    if(model.promotions == nil || model.promotions.count <= 2){
//        self.couponCountLabel.hidden = YES;
//    }else{
//        self.couponCountLabel.hidden = NO;
//        self.couponCountLabel.text = [NSString stringWithFormat:@"%d个活动",model.promotions.count > 5?5:model.promotions.count];
//    }
//    
//    [self setupImageAndName:model.promotions andSpell:model.spelled];
//    
//    if(model.promotions.count <= 2){
//        _sepllImage.hidden = YES;
//        _sepllBtn.enabled = NO;
//    }else{
//        _sepllImage.hidden = NO;
//        _sepllBtn.enabled = YES;
//    }
    
    self.couponCountLabel.hidden = YES;
     _sepllImage.hidden = YES;
    _sepllBtn.enabled = NO;
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
    
    if(flag){
        _sepllImage.image = [UIImage imageNamed:@"btn_img_spelled"];

    }else{
        _sepllImage.image = [UIImage imageNamed:@"btn_img_unSpell"];

    }
    
    for(UIView *v in self.CouponView.subviews){
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
        [self.CouponView addSubview:imageText];
        
        UILabel *labelText = [[UILabel alloc]initWithFrame:CGRectMake(16, conY, self.CouponView.frame.size.width - 20, 14)];
        labelText.font = fontSystem(kFontS6);
        labelText.textColor = RGBHex(qwColor8);
        labelText.text = VO.title;
        [self.CouponView addSubview:labelText];
        
        conY += 20.0f;
        i ++;
    }
    
}


- (IBAction)spellCell:(id)sender {
    
    if (self.callback) {
        self.callback(self.path);
    }
}


@end
