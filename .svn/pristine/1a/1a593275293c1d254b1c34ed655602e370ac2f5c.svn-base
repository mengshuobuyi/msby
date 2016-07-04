//
//  ChatChooserViewController.h
//  APP
//  咨询中间页面，显示药房和砖家列表
//  Created by 李坚 on 16/5/9.
//  Copyright © 2016年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QWBaseVC.h"
#import "ConsultStoreModel.h"

@interface ChatChooserViewController : QWBaseVC

@property (nonatomic, strong) MicroMallBranchProductVo *product;//商品详情进入聊天需要传值，其他页面可以无视

@property (nonatomic, strong) NSString *branchId;//药房ID
@property (nonatomic, strong) NSString *branchName;//药房名称
@property (nonatomic, strong) NSString *branchLogo;//药房图片

@property (nonatomic, assign) BOOL      online;//店长是否在线

@end


@interface ChatHeaderView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *branchImage;
@property (weak, nonatomic) IBOutlet UILabel *branchNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *specLabel;

@property (weak, nonatomic) IBOutlet UIButton *chatBtn;

+ (CGFloat)getHeight;
+ (ChatHeaderView *)getView;

@end