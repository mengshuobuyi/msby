//
//  BYSelectionView.m
//  BYDailyNews
//
//  Created by bassamyan on 15/1/18.
//  Copyright (c) 2015年 apple. All rights reserved.
//
#import "QWGlobalManager.h"
#import "BYListItem.h"
#define kDeleteW 6
#define kItemFont kFontS5
#define kItemSizeChangeAdded 2

@implementation BYListItem

- (void)setItem:(ResortItem *)item
{
    _item = item;
    
    [self setTitle:item.strTitle forState:0];
    [self setTitleColor:RGBHex(qwColor6) forState:0];
    [self setBackgroundColor:[UIColor whiteColor]];//RGBHex(qwColor4)];
    self.titleLabel.font = [UIFont systemFontOfSize:kItemFont];
    self.layer.cornerRadius = 4;
    self.layer.borderColor = [[UIColor clearColor] CGColor];
    self.layer.borderWidth = 0.5;
//    self.layer.masksToBounds = YES;
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
//    self.backgroundColor = [UIColor whiteColor];
    [self addTarget:self
             action:@selector(operationWithoutHidBtn)
   forControlEvents:UIControlEventTouchUpInside];
    
    self.gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pangestureOperation:)];
    self.longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress)];
    self.longGesture.minimumPressDuration = 1;
    self.longGesture.allowableMovement = 20;
    [self addGestureRecognizer:self.longGesture];
    
    
    
    if (!self.borderView) {
        self.borderView = [[UIView alloc] initWithFrame:self.bounds];
        self.borderView.backgroundColor = [UIColor clearColor];
        self.borderView.layer.borderColor = [RGBHex(qwColor10) CGColor];
        self.borderView.layer.cornerRadius = 4;
        self.borderView.layer.borderWidth = 0.5;
        [self addSubview:self.borderView];
        [self.borderView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(operationWithoutHidBtn)]];
    }
    
    if (![item.strTitle isEqualToString:@"热点"]) {
        if (!self.deleteBtn) {
            self.deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(-kDeleteW+2, -kDeleteW+2, 2*kDeleteW, 2*kDeleteW)];
            self.deleteBtn.userInteractionEnabled = NO;
            [self.deleteBtn setImage:[UIImage imageNamed:@"health_btn_img_closeround"] forState:0];
//            self.deleteBtn.layer.cornerRadius = self.deleteBtn.frame.size.width/2;
            self.deleteBtn.hidden = YES;
            self.deleteBtn.alpha = 1.0;
//            self.deleteBtn.backgroundColor = RGBColor(111.0, 111.0, 111.0);
            [self addSubview:self.deleteBtn];
        }
    }
    if (!self.hiddenBtn) {
        self.hiddenBtn = [[UIButton alloc] initWithFrame:self.bounds];
        self.hiddenBtn.hidden = NO;
        [self.hiddenBtn addTarget:self
                           action:@selector(operationWithHidBtn)
                 forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.hiddenBtn];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(sortButtonClick)
                                                 name:@"sortBtnClick"
                                               object:nil];
}

-(void)longPress{
    if (self.hiddenBtn.hidden == NO) {
        if (self.longPressBlock) {
            self.longPressBlock();
        }
        if (self.location == top) {
            [self addGestureRecognizer:self.gesture];
        }
    }
}

-(void)sortButtonClick{
    if (self.location == top){
        self.deleteBtn.hidden = !self.deleteBtn.hidden;
        if(iOSv8) {
            self.deleteBtn.maskView.alpha = 1.0;
        }
    }
    self.hiddenBtn.hidden = !self.hiddenBtn.hidden;
    if (self.gestureRecognizers) {
        [self removeGestureRecognizer:self.gesture];
    }
    if (self.hiddenBtn.hidden && self.location == top) {
        [self addGestureRecognizer:self.gesture];
    }
    
}

-(void)operationWithHidBtn{
    if (!self.hiddenBtn.hidden) {
        if (self.location == top) {
            [self setTitleColor:[UIColor redColor] forState:0];
            if (self.operationBlock) {
                self.operationBlock(topViewClick,self.item,0);
            }
            [self animationForWholeView];
        }
        else if (self.location == bottom){
            [self changeFromBottomToTop];
        }
        else if (self.location == center){
            [self changeFromCenterToTop];
        }
    }
}

-(void)operationWithoutHidBtn{
    if (self.location == top){
        if (self.olocation == ocenter) {
            [self changeFromTopToCenter];
        } else if (self.olocation == obottom){
            [self changeFromTopToBottom];
        }
    }
    else if (self.location == bottom) {
        self.deleteBtn.hidden = NO;
        [self addGestureRecognizer:self.gesture];
        [self changeFromBottomToTop];
    }
    else if (self.location == center) {
        self.deleteBtn.hidden = NO;
        [self addGestureRecognizer:self.gesture];
        [self changeFromCenterToTop];
    }
}

- (void)pangestureOperation:(UIPanGestureRecognizer *)pan{
    [self.superview exchangeSubviewAtIndex:[self.superview.subviews indexOfObject:self] withSubviewAtIndex:[[self.superview subviews] count] - 1];
    CGPoint translation = [pan translationInView:pan.view];
    CGPoint center = pan.view.center;
    center.x += translation.x;
    center.y += translation.y;
    pan.view.center = center;
    [pan setTranslation:CGPointZero inView:pan.view];
    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:{
            NSInteger indexX = (center.x <= kItemW+2*padding)? 0 : (center.x - kItemW-2*padding)/(padding+kItemW) + 1;
            NSInteger indexY = (center.y <= kItemH+2*kPaddingItemVertical)? 0 : (center.y - kItemH-2*kPaddingItemVertical)/(kPaddingItemVertical+kItemH) + 1;
            
            NSInteger index = indexX + indexY*itemPerLine;
            if (index == 0) {
                [self removeGestureRecognizer:self.gesture];
                [self animationForWholeView];
                return;
            }
            CGRect itemFrame = self.frame;
            [self setFrame:CGRectMake(itemFrame.origin.x-kItemSizeChangeAdded, itemFrame.origin.y-kItemSizeChangeAdded, itemFrame.size.width+kItemSizeChangeAdded*2, itemFrame.size.height+kItemSizeChangeAdded*2)];
            [self.borderView setFrame:CGRectMake(0, 0, itemFrame.size.width+kItemSizeChangeAdded*2, itemFrame.size.height+kItemSizeChangeAdded*2)];
        }
            break;
        case UIGestureRecognizerStateChanged:{
            BOOL InTopView = [self whetherInAreaWithArray:topView Point:center];
            if (InTopView) {
                
                NSInteger indexX = (center.x <= kItemW+2*padding)? 0 : (center.x - kItemW-2*padding)/(padding+kItemW) + 1;
                NSInteger indexY = (center.y <= kItemH+2*kPaddingItemVertical)? 0 : (center.y - kItemH-2*kPaddingItemVertical)/(kPaddingItemVertical+kItemH) + 1;
                
                NSInteger index = indexX + indexY*itemPerLine;
                index = (index == 0)? 1:index;
                if (index >= topView.count) {
                    index = topView.count-1;
                }
                [locateView removeObject:self];
                [topView insertObject:self atIndex:index];
                locateView = topView;
                [self animationForTopView];
                if (self.operationBlock) {
                    self.operationBlock(FromTopToTop,self.item,(int)index);
                }
            }
            else if (!InTopView && center.y < [self TopViewMaxY]+50) {
                [locateView removeObject:self];
                [topView insertObject:self atIndex:topView.count];
                locateView = topView;
                [self animationForTopView];
                if (self.operationBlock) {
                    self.operationBlock(FromTopToTopLast,self.item,0);
                }
            }
//            else if (center.y > [self TopViewMaxY]+50){
//                [self changeFromTopToBottom];
//            }
        }
            break;
        case UIGestureRecognizerStateEnded:
            [self animationForWholeView];
            break;
        default:
            break;
    }
}

- (void)setStyleDefault
{
    self.backgroundColor = RGBHex(qwColor4);
    [self setTitleColor:RGBHex(qwColor6) forState:UIControlStateNormal];
    self.borderView.layer.borderColor = [RGBHex(qwColor10) CGColor];
}

- (void)setStyleHighlight
{
    self.backgroundColor = RGBHex(qwColor3);
    [self setTitleColor:RGBHex(qwColor4) forState:UIControlStateNormal];
    self.borderView.layer.borderColor = [RGBHex(qwColor3) CGColor];
}

-(void)changeFromTopToBottom{
    [locateView removeObject:self];
    [bottomView insertObject:self atIndex:0];
    locateView = bottomView;
    self.location = bottom;
    self.deleteBtn.hidden = YES;
    [self setStyleDefault];
    [self removeGestureRecognizer:self.gesture];
    if (self.operationBlock) {
        self.operationBlock(FromTopToBottomHead,self.item,0);
    }
    [self animationForWholeView];
}

-(void)changeFromBottomToTop{
    [locateView removeObject:self];
    [topView insertObject:self atIndex:topView.count];
    locateView = topView;
    self.location = top;
    if (!self.didSelected) {
        [self setStyleDefault];
    } else {
        [self setStyleHighlight];
    }
    if (self.operationBlock) {
        self.operationBlock(FromBottomToTopLast,self.item,0);
    }
    [self animationForWholeView];
    
    // 统计
    NSMutableDictionary *tdParams = [NSMutableDictionary dictionary];
    tdParams[@"频道名"]=self.item.strTitle;
    [QWGLOBALMANAGER statisticsEventId:@"x_bjzx_zj" withLable:@"资讯" withParams:tdParams];
}

- (void)changeFromTopToCenter{
    [locateView removeObject:self];
    [centerView insertObject:self atIndex:0];
    locateView = centerView;
    self.location = center;
    self.deleteBtn.hidden = YES;
    [self setStyleDefault];
    [self removeGestureRecognizer:self.gesture];
    if (self.operationBlock) {
        self.operationBlock(FromTopToCenterHead,self.item,0);
    }
    [self animationForWholeView];
    
    // 统计
    NSMutableDictionary *tdParams = [NSMutableDictionary dictionary];
    tdParams[@"频道名"]=self.item.strTitle;
    [QWGLOBALMANAGER statisticsEventId:@"x_bjzx_sc" withLable:@"资讯" withParams:tdParams];
}

- (void)changeFromCenterToTop{
    [locateView removeObject:self];
    [topView insertObject:self atIndex:topView.count];
    locateView = topView;
    self.location = top;
    if (!self.didSelected) {
        [self setStyleDefault];
    } else {
        [self setStyleHighlight];
    }
    if (self.operationBlock) {
        self.operationBlock(FromCenterToTopLast,self.item,0);
    }
    [self animationForWholeView];
    
    // 统计
    NSMutableDictionary *tdParams = [NSMutableDictionary dictionary];
    tdParams[@"频道名"]=self.item.strTitle;
    [QWGLOBALMANAGER statisticsEventId:@"x_bjzx_zj" withLable:@"资讯" withParams:tdParams];
}

- (BOOL)whetherInAreaWithArray:(NSMutableArray *)array Point:(CGPoint)point{
    int row = (array.count%itemPerLine == 0)? itemPerLine : array.count%itemPerLine;
    int column =  (int)(array.count-1)/itemPerLine+1;
    if ((point.x > 0 && point.x <=kScreenW &&point.y > 0 && point.y <= (kItemH + kPaddingItemVertical)*(column-1)+padding)||
        (point.x > 0 && point.x <= (row*(padding+kItemW)+padding)&& point.y > (kItemH + kPaddingItemVertical)*(column -1)+padding && point.y <= (kItemH+kPaddingItemVertical) * column+padding)){
        return YES;
    }
    return NO;
}

- (unsigned long)TopViewMaxY{
    unsigned long y = 0;
    y = ((topView.count-1)/itemPerLine+1)*(kItemH + kPaddingItemVertical) + padding;
    return y;
}

- (unsigned long)CenterViewMaxY{
    unsigned long y = 0;
    y = ((centerView.count-1)/itemPerLine+1)*(kItemH + kPaddingItemVertical) + padding;
    return y;
}

- (void)animationForTopView{
    for (int i = 0; i < topView.count; i++){
        if ([topView objectAtIndex:i] != self){
            [self animationWithView:[topView objectAtIndex:i] frame:CGRectMake(padding+(padding+kItemW)*(i%itemPerLine), padding/2+(kItemH + kPaddingItemVertical)*(i/itemPerLine)+kDeleteBarHeight, kItemW, kItemH)];
        }
    }
}
-(void)animationForBottomView{
    for (int i = 0; i < bottomView.count; i++) {
        if ([bottomView objectAtIndex:i] != self) {
            [self animationWithView:[bottomView objectAtIndex:i] frame:CGRectMake(padding+(padding+kItemW)*(i%itemPerLine), [self TopViewMaxY]+50+(kItemH+kPaddingItemVertical)*(i/itemPerLine), kItemW, kItemH)];
        }
    }
    [self animationWithView:self.hitTextLabel frame:CGRectMake(0,[self TopViewMaxY],kScreenW,30)];
}

- (void)animationForWholeView{
    for (int i = 0; i <topView.count; i++) {
        [self animationWithView:[topView objectAtIndex:i] frame:CGRectMake(padding+(padding+kItemW)*(i%itemPerLine), padding/2+(kPaddingItemVertical+kItemH)*(i/itemPerLine)+kDeleteBarHeight, kItemW, kItemH)];
        [self animationWithView:((BYListItem *)[topView objectAtIndex:i]).borderView frame:CGRectMake(0, 0, kItemW, kItemH)];
    }
    [self animationWithView:self.hitTextLabel frame:CGRectMake(0,[self TopViewMaxY]+kDeleteBarHeight-padding+17.5,kScreenW,channelHeight)];
    [self animationWithView:self.sectionOneTitle frame:CGRectMake(15,CGRectGetMaxY(self.hitTextLabel.frame)+padding/2,kScreenW,channelHeight)];
    [self animationWithView:self.sectionTwoTitle frame:CGRectMake(15,CGRectGetMaxY(self.sectionOneTitle.frame) +[self CenterViewMaxY]-padding/2,kScreenW,channelHeight)];
    for (int i = 0; i < centerView.count; i++) {
//        [self animationWithView:[centerView objectAtIndex:i] frame:CGRectMake(padding+(padding+kItemW)*(i%itemPerLine),[self TopViewMaxY] + padding+(padding+kItemH)*(i/itemPerLine)+kDeleteBarHeight, kItemW, kItemH)];
        [self animationWithView:[centerView objectAtIndex:i] frame:CGRectMake(padding+(padding+kItemW)*(i%itemPerLine),CGRectGetMaxY(self.sectionOneTitle.frame) + padding/2+(kPaddingItemVertical+kItemH)*(i/itemPerLine), kItemW, kItemH)];
        [self animationWithView:((BYListItem *)[centerView objectAtIndex:i]).borderView frame:CGRectMake(0, 0, kItemW, kItemH)];
    }
    for (int i = 0; i < bottomView.count; i++) {
//        [self animationWithView:[bottomView objectAtIndex:i] frame:CGRectMake(padding+(padding+kItemW)*(i%itemPerLine), [self TopViewMaxY]+[self CenterViewMaxY]+50+(kItemH+padding)*(i/itemPerLine)+kDeleteBarHeight+20, kItemW, kItemH)];
//        [self animationWithView:[bottomView objectAtIndex:i] frame:CGRectMake(padding+(padding+kItemW)*(i%itemPerLine), CGRectGetMaxY(self.sectionOneTitle.frame)+[self CenterViewMaxY]+(kItemH+kPaddingItemVertical)*(i/itemPerLine)+padding+padding/2, kItemW, kItemH)];
        [self animationWithView:[bottomView objectAtIndex:i] frame:CGRectMake(padding+(padding+kItemW)*(i%itemPerLine), CGRectGetMaxY(self.sectionTwoTitle.frame)+(kItemH+kPaddingItemVertical)*(i/itemPerLine)+padding/2, kItemW, kItemH)];
        [self animationWithView:((BYListItem *)[bottomView objectAtIndex:i]).borderView frame:CGRectMake(0, 0, kItemW, kItemH)];
    }
    
}

-(void)animationWithView:(UIView *)view frame:(CGRect)frame{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        [view setFrame:frame];
    } completion:^(BOOL finished){}];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
