//
//  LevelAnimationCell.m
//  APP
//
//  Created by qw_imac on 15/12/1.
//  Copyright © 2015年 carret. All rights reserved.
//

#import "LevelAnimationCell.h"
#import "QWGlobalManager.h"
@implementation LevelAnimationCell
{
    BOOL firstDir;
    BOOL secondDir;
    BOOL thirdDir;
    NSArray *array;
    NSArray *levelArray;
}
- (void)awakeFromNib {
    // Initialization code

    firstDir = YES;
    secondDir = YES;
    thirdDir = YES;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:.05 target:self selector:@selector(cloudMove) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    self.knowBtn.layer.cornerRadius = 5.0;
    self.knowBtn.layer.masksToBounds = YES;
    array = @[@"img_tree0",@"img_tree1",@"img_tree2",@"img_tree3",@"img_tree4",@"img_tree5",@"img_tree6"];
    levelArray = @[@"icon_v0",@"icon_v1",@"icon_v2",@"icon_v3",@"icon_v4",@"icon_v5",@"icon_v6"];
    //[self performSelector:@selector(deleteAlertView) withObject:nil afterDelay:5.0];
    
}

-(void)setAlertViewWithVo:(MyLevelDetailVo *)vo {
    BOOL isClick = [QWUserDefault getBoolBy:@"isLevelAlertClick"];
    if (!vo.level) {
        return;
    }
    if([vo.level integerValue] == 0){
        [self.knowBtn setTitle:@"知道了" forState:UIControlStateNormal];
        self.contentLabel.text = [NSString stringWithFormat:@"升级至V%d每月可获%ld积分",[vo.nextLevel integerValue],(long)[QWGLOBALMANAGER rewardScoreWithTaskKey:[NSString stringWithFormat:@"VIP%@",vo.nextLevel]]];
        NSString *can;
        if (isClick) {
            self.alertView.hidden = YES;
            can = @"不能领取";
        }else {
            can = @"可以领取";
            self.alertView.hidden = NO;
        }
        NSMutableDictionary *tdParams = [NSMutableDictionary dictionary];
        tdParams[@"是否可以领取"]=can;
        tdParams[@"用户等级"] = [NSString stringWithFormat:@"%@",vo.level];
        [QWGLOBALMANAGER statisticsEventId:@"x_wd_dj_lqym" withLable:@"等级" withParams:tdParams];
    } else {
        [self.knowBtn setTitle:@"领取" forState:UIControlStateNormal];
        self.contentLabel.text = [NSString stringWithFormat:@"本月等级奖励%ld积分",(long)[QWGLOBALMANAGER rewardScoreWithTaskKey:[NSString stringWithFormat:@"VIP%@",vo.level]]];
        NSString *can;
        if (vo.claim) {
            can = @"不能领取";
            self.alertView.hidden = YES;
        }else {
            can = @"可以领取";
            self.alertView.hidden = NO;
        }
        NSMutableDictionary *tdParams = [NSMutableDictionary dictionary];
        tdParams[@"是否可以领取"]=can;
        tdParams[@"用户等级"] = [NSString stringWithFormat:@"%@",vo.level];
        [QWGLOBALMANAGER statisticsEventId:@"x_wd_dj_lqym" withLable:@"等级" withParams:tdParams];
    }
    
    [self setUiWithVip:[vo.level integerValue]];
}


-(void)setAlertViewWith:(BOOL)isClick {
    if (isClick) {
        return;
    }else {
        self.alertView.hidden = YES;
    }
}

-(void)cloudMove {
    [self firstDirWith:self.FirstCloudMove];
    if (firstDir) {
        self.FirstCloudMove.constant ++;
    }else {
        self.FirstCloudMove.constant --;
    }
    
    [self secondDirWith:self.secondCloudMove];
    if (secondDir) {
        self.secondCloudMove.constant ++;
    }else {
        self.secondCloudMove.constant --;
    }
    
    [self thirdDirWith:self.thirdCloudMove];
    if (thirdDir) {
        self.thirdCloudMove.constant ++;
    }else {
        self.thirdCloudMove.constant --;
    }
}

//云朵方向
-(void)firstDirWith:(NSLayoutConstraint *)move {
    if (move.constant == APP_W - 100) {
        firstDir = NO;
        
    }else if (move.constant == 0) {
        firstDir = YES;
    }else {
        return;
    }
}

-(void)secondDirWith:(NSLayoutConstraint *)move {
    if (move.constant == APP_W - 50) {
        secondDir = NO;
    }else if (move.constant == 80) {
        secondDir = YES;
    }else {
        return;
    }
}

-(void)thirdDirWith:(NSLayoutConstraint *)move {
    if (move.constant == APP_W - 120) {
        thirdDir = NO;
    }else if (move.constant == 80) {
        thirdDir = YES;
    }else {
        return;
    }
    
}
//屏幕高度适配
+(CGFloat)cellHeight {
    return APP_W * (300.0/320.0);
}


-(void)setUiWithVip:(NSInteger)vip {
    float scale = 0.0;
    switch (vip) {
        case 0:
            scale = 97.0 / 640.0;
            break;
        case 1:
            scale = 172.0 / 640.0;
            break;
        case 2:
            scale = 234.0 / 640.0;
            break;
        case 3:
            scale = 302.0 / 640.0;
            break;
        case 4:
            scale = 362.0 / 640.0;
            break;
        case 5:
            scale = 451.0 / 640.0;
            break;
        case 6:
            scale = 483.0 / 640.0;
            break;
        default:
            scale = 483.0 / 640.0;
            break;
    }
    self.treeHeight.constant = APP_W * scale;
    
    if(vip>6){
        self.treeImage.image = [UIImage imageNamed:array[6]];
        self.levelImage.image = [UIImage imageNamed:levelArray[6]];
    }else{
        self.treeImage.image = [UIImage imageNamed:array[vip]];
        self.levelImage.image = [UIImage imageNamed:levelArray[vip]];
    }
   
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
