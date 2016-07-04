//
//  BYSelectionDetails.m
//  BYDailyNews
//
//  Created by bassamyan on 15/1/18.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "BYDetailsList.h"

#import "BYDeleteBar.h"
@interface BYDetailsList()

@property (nonatomic,strong) UIView *sectionHeaderView;

@property (nonatomic,strong) UILabel *lblSectionOne;

@property (nonatomic,strong) UILabel *lblSectionTwo;

@property (nonatomic,strong) UIButton *btnLoadMore;

@property (nonatomic,strong) NSMutableArray *allItems;

@property (nonatomic,strong) NSString *strSelectID;

@property (nonatomic,strong) BYDeleteBar *deleteBar;

@end

@implementation BYDetailsList

-(void)setListAll:(NSMutableArray *)listAll{
    _listAll = listAll;
    self.showsVerticalScrollIndicator = NO;
    self.contentInset = UIEdgeInsetsMake(0, 0, 20, 0);
    self.backgroundColor = [UIColor clearColor];
    
    NSArray *listTop = listAll[0];
    NSArray *listBottom = listAll[1];
    NSArray *listAppend;
   listAppend = listAll[2];

    
    if (!self.deleteBar) {
        self.deleteBar = [[BYDeleteBar alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kDeleteBarHeight)];
        [self addSubview:self.deleteBar];
    }
#pragma 更多频道标签
    // 第一个频道
    self.sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0,17.5+kDeleteBarHeight+(kPaddingItemVertical + kItemH)*((listTop.count -1)/itemPerLine+1),[UIScreen mainScreen].bounds.size.width, channelHeight)];
    self.sectionHeaderView.backgroundColor = [UIColor clearColor];//[UIColor colorWithRed:(238.0)/255.0 green:(238.0)/255.0 blue:(238.0)/255.0 alpha:1.0];
    UILabel *moreText = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, channelHeight)];
    moreText.text = @"频道推荐";
    moreText.textColor = RGBHex(qwColor6);
    moreText.font = fontSystem(kFontS1);
    [self.sectionHeaderView addSubview:moreText];
    [self addSubview:self.sectionHeaderView];
    
    
    // 推荐专题第一个
    NSInteger count2 = listBottom.count;
    self.lblSectionOne = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.sectionHeaderView.frame)+padding / 2, kScreenW, channelHeight)];
    self.lblSectionOne.textColor = RGBHex(qwColor8);
    self.lblSectionOne.text = @"资讯频道";
    self.lblSectionOne.font = fontSystem(kFontS5);
    [self addSubview:self.lblSectionOne];

    // 推荐专题第二个
    NSInteger count3 = listAppend.count;
    self.lblSectionTwo = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.lblSectionOne.frame)+padding / 2 + (kPaddingItemVertical + kItemH)*((listBottom.count -1)/4+1), kScreenW, channelHeight)];
    self.lblSectionTwo.textColor = RGBHex(qwColor8);
    self.lblSectionTwo.text = @"疾病频道";
    self.lblSectionTwo.font = fontSystem(kFontS5);
    [self addSubview:self.lblSectionTwo];
    
     __weak typeof(self) unself = self;
    NSInteger count1 = listTop.count;
    for (int i =0; i <count1; i++) {
        BYListItem *item = [[BYListItem alloc] initWithFrame:CGRectMake(padding+(padding+kItemW)*(i% itemPerLine), kDeleteBarHeight+padding/2+(kItemH + kPaddingItemVertical)*(i/itemPerLine), kItemW, kItemH)];
        if (i!=0) {
            
        } else {
            [item removeGestureRecognizer:item.gesture];
        }
        // 点击事件
        item.operationBlock = ^(animateType type, ResortItem *item, int index){
            self.opertionFromItemBlock(type,item,index);
        };
        item.longPressBlock = ^(){
            //                if (unself.longPressedBlock) {
            //                    unself.longPressedBlock();
            //                }
            if (item.location == top) {
                [unself.deleteBar sortBtnClick:unself.deleteBar.sortBtn];
            }
        };
        ResortItem *itemResort = listTop[i];
        item.item = listTop[i];
        item.location = top;
        item.olocation = itemResort.olocation;
        
        [self.topView addObject:item];
        item->locateView = self.topView;
        item->topView = self.topView;
        item->centerView = self.centerView;
        item->bottomView = self.bottomView;
        item.hitTextLabel = self.sectionHeaderView;
        item.sectionOneTitle = self.lblSectionOne;
        item.sectionTwoTitle = self.lblSectionTwo;
        [self addSubview:item];
        [self.allItems addObject:item];
        
        if (!self.itemSelect) {
            if ([itemResort.strTitle isEqualToString:@"热点"]) {
                [item setTitleColor:[UIColor redColor] forState:0];
                [item setTitleColor:RGBHex(qwColor4) forState:UIControlStateNormal];
                [item setBackgroundColor:RGBHex(qwColor3)];
                self.itemSelect = item;
            }
        } else {
        }
    }
    
    for (int i=0; i<count2; i++) {
//        BYListItem *item = [[BYListItem alloc] initWithFrame:CGRectMake(padding+(padding+kItemW)*(i%itemPerLine),CGRectGetMaxY(self.sectionHeaderView.frame)+padding+(kItemH+padding)*(i/itemPerLine)+heightSubBar+padding/2, kItemW, kItemH)];
        BYListItem *item = [[BYListItem alloc] initWithFrame:CGRectMake(padding+(padding+kItemW)*(i%itemPerLine),CGRectGetMaxY(self.lblSectionOne.frame)+padding/2+(kItemH+kPaddingItemVertical)*(i/itemPerLine), kItemW, kItemH)];
        // 点击事件
        item.operationBlock = ^(animateType type, ResortItem *item, int index){
            self.strSelectID = item.strID;
            if (self.opertionFromItemBlock) {
                self.opertionFromItemBlock(type,item,index);
            }
        };
        item.longPressBlock = ^(){
            //                if (unself.longPressedBlock) {
            //                    unself.longPressedBlock();
            //                }
            if (item.location == top) {
               [unself.deleteBar sortBtnClick:unself.deleteBar.sortBtn];
            }
            
        };
        ResortItem *itemResort = listBottom[i];
        item.item = listBottom[i];
        item.location = center;
        item.olocation = itemResort.olocation;
        item.hitTextLabel = self.sectionHeaderView;
        item.sectionOneTitle = self.lblSectionOne;
        item.sectionTwoTitle = self.lblSectionTwo;
        [self.centerView addObject:item];
        item->locateView = self.centerView;
        item->topView = self.topView;
        item->centerView = self.centerView;
        item->bottomView = self.bottomView;
        [self addSubview:item];
        [self.allItems addObject:item];
    }
    
    
    
    for (int i = 0; i < count3 ; i++) {
        BYListItem *item = [[BYListItem alloc] initWithFrame:CGRectMake(padding+(padding+kItemW)*(i%itemPerLine),CGRectGetMaxY(self.lblSectionTwo.frame)+(kItemH+kPaddingItemVertical)*(i/itemPerLine)+padding/2, kItemW, kItemH)];
        // 点击事件
        item.operationBlock = ^(animateType type, ResortItem *item, int index){
            self.strSelectID = item.strID;
            if (self.opertionFromItemBlock) {
                self.opertionFromItemBlock(type,item,index);
            }
        };
        item.longPressBlock = ^(){
            //                if (unself.longPressedBlock) {
            //                    unself.longPressedBlock();
            //                }
            if (item.location == top) {
                [unself.deleteBar sortBtnClick:unself.deleteBar.sortBtn];
            }
            
        };
        ResortItem *itemResort = listAppend[i];
        item.item = listAppend[i];
        item.location = bottom;
        item.olocation = itemResort.olocation;
        item.hitTextLabel = self.sectionHeaderView;
        item.sectionOneTitle = self.lblSectionOne;
        item.sectionTwoTitle = self.lblSectionTwo;
        [self.bottomView addObject:item];
        item->locateView = self.bottomView;
        item->topView = self.topView;
        item->centerView = self.centerView;
        item->bottomView = self.bottomView;
        [self addSubview:item];
        [self.allItems addObject:item];
    }
    

    
    
//    self.contentSize = CGSizeMake(kScreenW, CGRectGetMaxY(self.sectionHeaderView.frame)+padding+(kItemH+padding)*((count2-1)/4+1) + 50 + kDeleteBarHeight + heightSubBar + padding / 2);
    
    self.contentSize = CGSizeMake(kScreenW, CGRectGetMaxY(self.lblSectionTwo.frame)+padding/2+(kItemH+kPaddingItemVertical)*((count3-1)/4+1) + 50);
}

-(void)itemRespondFromListBarClickWithItemName:(ResortItem *)itemT{
    for (int i = 0 ; i<self.allItems.count; i++) {
        BYListItem *item = (BYListItem *)self.allItems[i];
        if ([itemT.strID isEqualToString:item.item.strID]) {
            [self.itemSelect setBackgroundColor:RGBHex(qwColor4)];
            [self.itemSelect setTitleColor:RGBHex(qwColor6) forState:UIControlStateNormal];
            self.itemSelect.borderView.layer.borderColor = [RGBHex(qwColor10) CGColor];
            [item setBackgroundColor:RGBHex(qwColor3)];
            item.borderView.layer.borderColor = [RGBHex(qwColor3) CGColor];
            [item setTitleColor:RGBHex(qwColor4) forState:0];
            item.didSelected = YES;
            self.itemSelect = item;
        } else {
            item.didSelected = NO;
        }
    }
}

-(NSMutableArray *)allItems{
    if (_allItems == nil) {
        _allItems = [NSMutableArray array];
    }
    return _allItems;
}

-(NSMutableArray *)topView{
    if (_topView == nil) {
        _topView = [NSMutableArray array];
    }
    return _topView;
}

-(NSMutableArray *)bottomView{
    if (_bottomView == nil) {
        _bottomView = [NSMutableArray array];
    }
    return _bottomView;
}

-(NSMutableArray *)centerView{
    if (_centerView == nil) {
        _centerView = [NSMutableArray array];
    }
    return _centerView;
}

@end
