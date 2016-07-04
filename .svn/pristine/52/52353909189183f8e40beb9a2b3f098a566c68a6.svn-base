//
//  myConsultTableViewCell.m
//  APP
//
//  Created by 李坚 on 15/8/24.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "myConsultTableViewCell.h"
#import "CouponModel.h"

@implementation myConsultTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self.useButton setTitleColor:RGBHex(qwColor2) forState:UIControlStateNormal];
    self.useButton.titleLabel.font = fontSystem(kFontS5);
    self.useButton.layer.masksToBounds = YES;
    self.useButton.layer.cornerRadius = 3.0f;
    self.useButton.layer.borderColor = RGBHex(qwColor2).CGColor;
    self.useButton.layer.borderWidth = 0.5f;
    

    self.telNumber = @"";
    [self.starView setImagesDeselected:@"star_none" partlySelected:@"star_half" fullSelected:@"star_full" andDelegate:nil];
    self.starView.userInteractionEnabled = NO;
    
    [self.chatButton addTarget:self action:@selector(onClickChat:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 0.5, APP_W, 0.5)];
    line.backgroundColor = RGBHex(qwColor10);
    [self addSubview:line];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)getCellHeight:(id)data{
    
    return 85.0f;
}

- (void)setCell:(id)data{
    
    CouponBranchVoModel *vo = data;
    
    self.branchName.text = vo.branchName;
    
    
    self.address.text = vo.address;
    self.distance.text =[NSString stringWithFormat:@"离您最近%@", vo.distance];

    [self.starView displayRating:[vo.stars intValue]/2];
    
    self.branchId = vo.branchId;
    self.telNumber = vo.contact;
    
   // if(vo.contact == nil || [vo.contact isEqualToString:@""]){
    if(StrIsEmpty(vo.contact)){
        self.phoneImage.image = [UIImage imageNamed:@"btn_img_phonegray"];
    }else{
        self.phoneImage.image = [UIImage imageNamed:@"btn_img_phone.png"];
    }
    //if (vo.branchId == nil || [vo.branchId isEqualToString:@""]) {
    if(StrIsEmpty(vo.branchId)){
        self.branchImage.image = [UIImage imageNamed:@"btn_img_advisorygray"];
    }else{
        self.branchImage.image = [UIImage imageNamed:@"btn_img_advisory"];
    }
    if ([vo.online intValue] == 0) {
        self.chatEnable = NO;
        self.branchImage.image = [UIImage imageNamed:@"btn_img_advisorygray"];
    }else{
        self.branchImage.image = [UIImage imageNamed:@"btn_img_advisory"];
        self.chatEnable = YES;
    }
    self.phoneButton.hidden = YES;
    self.phoneImage.hidden = YES;
}


- (void)onClickChat:(id)sender {
    
    if(!self.chatEnable){
        return;
    }
    
    if(self.cellDelegate){
        
        [self.cellDelegate takeTalk:self.branchId name:self.branchName.text];
    }
}

- (IBAction)onClickPhone:(id)sender {
    
    if(self.cellDelegate){
        
        if([self.telNumber isEqualToString:@""]){
            return;
        }else{
            [self.cellDelegate takePhone:self.telNumber];
        }
    }
}
@end
