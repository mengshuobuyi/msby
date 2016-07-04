//
//  DrugDetailViewController.h
//  wenyao
//
//  Created by Meng on 14-9-28.
//  Copyright (c) 2014年 xiezhenghong. All rights reserved.
//

#import "QWBaseVC.h"

@interface DrugDetailViewController : QWBaseVC

@property (nonatomic ,copy) NSString * proId; //药品的id
@property (nonatomic ,copy) NSString * facComeFrom;//品牌厂家

//@property (nonatomic) NSInteger useType;

@property (nonatomic ,strong) UITableView *tableViews;               //主视图

@property (nonatomic) BOOL isConsult;//从聊天进入
@end




@interface TopView : UIView

@property (nonatomic ,strong) NSDictionary * dataDictionary;
@property (nonatomic ,strong) UIFont * titleFont;
@property (nonatomic ,strong) UIFont * contentFont;
@property (nonatomic ,strong) UIFont * topTitleFont;
@property (nonatomic ,strong) UILabel * titleLabel;

@property (nonatomic, strong) UIImageView *ephedrineImage;
@property (nonatomic, strong) UILabel     *ephedrineLabel;

@property (nonatomic, strong) UIImageView *recipeImage;
@property (nonatomic, strong) UILabel     *recipeLabel;

@property (nonatomic ,strong) UILabel * specLabel;
@property (nonatomic ,strong) UILabel * factoryLabel;

@property (nonatomic ,strong) UIImageView * firstImageView;
@property (nonatomic ,strong) UIImageView * secondImageView;
@property (nonatomic ,strong) UILabel * firstLabel;
@property (nonatomic ,strong) UILabel * secondLabel;
@property (nonatomic ,copy) NSString * facComeFrom;

- (void)setUpView;

@end