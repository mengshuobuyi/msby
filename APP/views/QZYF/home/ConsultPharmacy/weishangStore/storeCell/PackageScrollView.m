//
//  PackageScrollView.m
//  APP
//
//  Created by 李坚 on 16/5/11.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "PackageScrollView.h"
#import "PackageShower.h"

#define CurrWidth 20.0f

@implementation PackageScrollView

- (void)awakeFromNib{

    self.priceOutView.layer.masksToBounds = YES;
    self.priceOutView.layer.cornerRadius = 20.0f;
    
}

- (void)initCycleScrollView
{
    if(!self.cycleScroll){
        self.cycleScroll = [[XLCycleScrollView alloc]initWithFrame: CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 16.0f, self.bounds.size.height - 108.0f)];
        [self.cycleScroll.pageControl removeFromSuperview];
        self.cycleScroll.addGesture = NO;
        self.cycleScroll.datasource = self;
        self.cycleScroll.delegate = self;
        [self.cycleScrollView addSubview:self.cycleScroll];
    }
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    
    [self layoutIfNeeded];
}

#pragma mark - XLCycleScrollViewDatasource
- (NSInteger)numberOfPages{
    if(drugCount > 0){
        return drugCount;
    }else{
        return 0;
    }
}

- (UIView *)pageAtIndex:(NSInteger)index{

    return [self setupCurrPageView:index];
}

#pragma mark - XLCycleScrollViewDelegate
- (void)scollerToindex:(NSUInteger)index{
    
    self.mainLabel.text = _combo.desc;
    self.priceLabel.text = [NSString stringWithFormat:@"%.1f",[_combo.price doubleValue]];
    self.secondPriceLabel.text = [NSString stringWithFormat:@"节省￥%.1f",[_combo.reduce doubleValue]];
    
    for(UIView *view in self.currPageView.subviews){
        [view removeFromSuperview];
    }
    
    for(int i = 0;i < drugCount;i ++){
        
        UIView *currView = [[UIView alloc]init];
        if(i == 0){
            currView.frame = CGRectMake(0, 0, CurrWidth, 2.0f);
        }else{
            currView.frame = CGRectMake(i * CurrWidth + i * 12.0f, 0, CurrWidth, 2.0f);
        }
        
        if(i == (int)index){
            currView.backgroundColor = RGBHex(qwColor2);
        }else{
            currView.backgroundColor = RGBHex(qwColor9);
        }
        [self.currPageView addSubview:currView];
    }
    self.currViewWidthConstant.constant = drugCount * CurrWidth + (drugCount - 1) * 10.0f;
    [self.currPageView layoutIfNeeded];
    
}

- (void)setupShowerView:(ComboProductVo *)productVO atIndex:(NSInteger)index atView:(UIView *)backView{
    
    CGFloat pkShowWidth = ([UIScreen mainScreen].bounds.size.width - 16.0f)/2.0f - 1.5f;
    CGFloat pkShowHeight = self.bounds.size.height - 108.0f;
    
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"PackageShower" owner:self options:nil];
    PackageShower *pkView = [nibView objectAtIndex:0];
    
    if(index == 0){
        
        pkView.frame = CGRectMake(0, 0, pkShowWidth, pkShowHeight);

    }else{
        
        pkView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 16.0f)/2.0f + 1.5f, 0,pkShowWidth, pkShowHeight);
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 16.0f)/2.0f - 1.5f, 0, 3.0f, pkShowHeight)];
        line.backgroundColor = RGBHex(qwColor21);
        [backView addSubview:line];
    }

    [pkView setShowerView:productVO];
    __weak __typeof(self) weakSelf = self;
    pkView.selectedBlock = ^(NSString *branchProId){
        if(weakSelf.delegate){
            [weakSelf.delegate didSelectedPackageView:self withBranchProId:branchProId];
        }
    };
    [backView addSubview:pkView];
}

- (void)reloadData{
    
    ComboVo *combo = _combo;
    
    drugCount = 0;
    switch (combo.druglist.count) {
        case 2:
            drugCount = 1;
            break;
        case 3:
            drugCount = 2;
            break;
        case 4:
            drugCount = 2;
            break;
        case 5:
            drugCount = 3;
            break;
        case 6:
            drugCount = 3;
            break;
        default:
            drugCount = 0;
            break;
    }
    
    [self.cycleScroll reloadData];
}

- (UIView *)setupCurrPageView:(NSInteger)index{
    
    UIView *currpageView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 16.0f, self.bounds.size.height - 108.0f)];
    currpageView.backgroundColor = [UIColor clearColor];
    ComboProductVo *productVO1 = nil;
    ComboProductVo *productVO2 = nil;
    
    switch (index) {
        case 0:
        {
            productVO1 = _combo.druglist[0];
            if(_combo.druglist.count > 1){
                productVO2 = _combo.druglist[1];
            }
        }
            break;
        case 1:
        {
            productVO1 = _combo.druglist[2];
            if(_combo.druglist.count > 3){
                productVO2 = _combo.druglist[3];
            }
        }
            break;
        case 2:
        {
            productVO1 = _combo.druglist[4];
            if(_combo.druglist.count > 5){
                productVO2 = _combo.druglist[5];
            }
        }
            break;
        default:{
            
        }
            break;
    }
    
    if(productVO1){
        [self setupShowerView:productVO1 atIndex:0 atView:currpageView];
    }
    if(productVO2){
        [self setupShowerView:productVO2 atIndex:1 atView:currpageView];
    }

    return currpageView;
}

@end
