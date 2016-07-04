//
//  WYLNOtherCell.m
//  wenyao
//
//  Created by Yan Qingyang on 15/4/2.
//  Copyright (c) 2015年 xiezhenghong. All rights reserved.
//
static int kTM2 = 24;
static int kTM3 = 34;
static int kTM4 = 44;

#import "WYLNOtherCell.h"
@interface WYLNOtherCell()
{
    IBOutlet UIPickerView *tm1,*tm2,*tm3,*tm4;
    IBOutlet UIImageView *imgClock1,*imgClock2,*imgClock3,*imgClock4;
    IBOutlet UIButton *btn1,*btn2,*btn3,*btn4;
    IBOutlet UIView *vTimes;
    
    
    
    NSMutableArray *arrTM1,*arrTM2,*arrTM3,*arrTM4;//*arrTM234;
}
@end

@implementation WYLNOtherCell

+ (CGFloat)getCellHeight:(id)obj{
//    if ([obj isKindOfClass:[WYLocalNotifModel class]]) {
//        WYLocalNotifModel *mode=obj;
//        
//        if ([mode.remark length]==0) {
//            return 85;
//        }
//    }
    return 265;
//    return AutoValue(275);
}

- (void)awakeFromNib{
    arrTM1 = [NSMutableArray new];
    for(int i = 0;i < 24;i ++){
        [arrTM1 addObject:[NSString stringWithFormat:@"%02d:00",i]];
        [arrTM1 addObject:[NSString stringWithFormat:@"%02d:30",i]];
    }
    arrTM2 = [[NSMutableArray alloc]initWithArray:arrTM1];
    arrTM3 = [[NSMutableArray alloc]initWithArray:arrTM1];
    arrTM4 = [[NSMutableArray alloc]initWithArray:arrTM1];
    [arrTM2 insertObject:@"--:--" atIndex:kTM2];
    [arrTM3 insertObject:@"--:--" atIndex:kTM3];
    [arrTM4 insertObject:@"--:--" atIndex:kTM4];
    
    tm1.dataSource = self;
    tm1.delegate = self;
    tm2.dataSource = self;
    tm2.delegate = self;
    tm3.dataSource = self;
    tm3.delegate = self;
    tm4.dataSource = self;
    tm4.delegate = self;
    
    tm1.backgroundColor=RGBHex(qwColor4);
    tm2.backgroundColor=RGBHex(qwColor4);
    tm3.backgroundColor=RGBHex(qwColor4);
    tm4.backgroundColor=RGBHex(qwColor4);
    
    btn1.backgroundColor=RGBAHex(qwColor4, 0);
    btn2.backgroundColor=RGBAHex(qwColor4, 0);
    btn3.backgroundColor=RGBAHex(qwColor4, 0);
    btn4.backgroundColor=RGBAHex(qwColor4, 0);
    
    [btn1 setImage:[UIImage imageNamed:@"btn_clock_uncheck"] forState:UIControlStateNormal];
    [btn1 setImage:[UIImage imageNamed:@"btn_clock_check"] forState:UIControlStateSelected];
    [btn2 setImage:[UIImage imageNamed:@"btn_clock_uncheck"] forState:UIControlStateNormal];
    [btn2 setImage:[UIImage imageNamed:@"btn_clock_check"] forState:UIControlStateSelected];
    [btn3 setImage:[UIImage imageNamed:@"btn_clock_uncheck"] forState:UIControlStateNormal];
    [btn3 setImage:[UIImage imageNamed:@"btn_clock_check"] forState:UIControlStateSelected];
    [btn4 setImage:[UIImage imageNamed:@"btn_clock_uncheck"] forState:UIControlStateNormal];
    [btn4 setImage:[UIImage imageNamed:@"btn_clock_check"] forState:UIControlStateSelected];
    
    
    
    
    DebugLog(@"vt1 %@",NSStringFromCGRect(vTimes.frame));
}

- (void)UIGlobal{
    [super UIGlobal];

    self.separatorLine.hidden=YES;
    
    self.contentView.backgroundColor=RGBAHex(qwColor4, 0);

}

- (void)setCell:(id)data{
    [super setCell:data];
    
    if ([data isKindOfClass:[WYLocalNotifModel class]]) {
        WYLocalNotifModel *mm=data;
//        DebugLog(@"＝＝＝＝＝ %@",mm);
        NSArray *tmp=mm.listTimes;


        for (int i = 0 ; i<4; i++) {
            if (i<tmp.count) {
                NSString *tt=tmp[i];
                [self setTime:tt tag:i];
            }
            else {
                [self resetTimes:i];
            }
            
        }

    }
}
- (void)setTime:(NSString*)tm tag:(int)tag {
    if (tm.length >=5) {
        NSString *last=[tm substringFromIndex:tm.length-2];
//        DebugLog(@"%d",last.integerValue);
        if (last.integerValue!=0 && last.integerValue!=30) {
            tm=[tm substringToIndex:2];
            tm=[NSString stringWithFormat:@"%@:00",tm];
        }
    }
    NSInteger n = 0;//(NSInteger)[arrTM234 indexOfObject:tm];
    switch (tag) {
        case 0:
        {
            n = (NSInteger)[arrTM1 indexOfObject:tm];
            [tm1 selectRow:n inComponent:0 animated:YES];
            btn1.selected = YES;
            _time1=tm;
        }
            break;
        case 1:
        {
            n = (NSInteger)[arrTM2 indexOfObject:tm];
            [tm2 selectRow:n inComponent:0 animated:YES];
            btn2.selected = YES;
            _time2=tm;
            break;
        }
        case 2:
        {
            n = (NSInteger)[arrTM3 indexOfObject:tm];
            [tm3 selectRow:n inComponent:0 animated:YES];
            btn3.selected = YES;
            _time3=tm;
            break;
        }
        case 3:
        {
            n = (NSInteger)[arrTM4 indexOfObject:tm];
            [tm4 selectRow:n inComponent:0 animated:YES];
            btn4.selected = YES;
            _time4=tm;
            break;
        }
        default:
            break;
    }
    [self timesList];
}

- (void)resetTimes:(int)tag{
    switch (tag) {
        case 1:
            [tm2 selectRow:kTM2 inComponent:0 animated:YES];
            btn2.selected = NO;
            _time2=nil;
            break;
        case 2:
            [tm3 selectRow:kTM3 inComponent:0 animated:YES];
            btn3.selected = NO;
            _time3=nil;
            break;
        case 3:
            [tm4 selectRow:kTM4 inComponent:0 animated:YES];
            btn4.selected = NO;
            _time4=nil;
            break;
        default:
            break;
    }
    
    [self timesList];
}

- (void)timesList{
    NSMutableArray *tmp=[[NSMutableArray alloc]initWithCapacity:4];
    if (_time1) {
        [tmp addObject:_time1];
    }
    if (_time2) {
        [tmp addObject:_time2];
    }
    if (_time3) {
        [tmp addObject:_time3];
    }
    if (_time4) {
        [tmp addObject:_time4];
    }
    
    NSMutableArray *list=[self checkTimeList:tmp];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(WYLNOtherCellDelegateTimes:)]) {
        [self.delegate WYLNOtherCellDelegateTimes:list];
    }
}

- (NSMutableArray*)checkTimeList:(NSMutableArray*)list{
    NSMutableArray *tmp=[NSMutableArray arrayWithCapacity:4];
    for (NSString *str in list) {
        BOOL can=YES;
        int i = 0,j=-1;
        for (NSString *tp in tmp) {
            NSComparisonResult rr=[str compare:tp];
            if (rr==NSOrderedSame) {
                can=NO;
                break;
            }
            else if (rr==NSOrderedAscending){
                
                if (j==-1) j=i;
            }
            i++;
        }
        if (can) {
            if (j>=0)
                [tmp insertObject:str atIndex:j];
            else
                [tmp addObject:str];
        }
        
    }
    return tmp;
//    DebugLog(@"%@",tmp);
//    list=[tmp mutableCopy];
}
#pragma mark action
- (IBAction)clockAction:(id)sender{
    if (sender==btn1) {
        
    }
    else if (sender==btn2 && btn2.selected) {
        [self resetTimes:1];
    }
    else if (sender==btn3 && btn3.selected) {
        [self resetTimes:2];
    }
    else if (sender==btn4 && btn4.selected) {
        [self resetTimes:3];
    }

}

#pragma mark - UIPickerViewDelegates
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if([pickerView isEqual:tm1]){
        return arrTM1.count;
    }else{
        return arrTM1.count+1;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if([pickerView isEqual:tm1] && row<arrTM1.count){
        return arrTM1[row];
    }
    else if([pickerView isEqual:tm2] && row<arrTM2.count){
        return arrTM2[row];
    }
    else if([pickerView isEqual:tm3] && row<arrTM3.count){
        return arrTM3[row];
    }
    else if([pickerView isEqual:tm4] && row<arrTM4.count){
        return arrTM4[row];
    }
    return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if([pickerView isEqual:tm1]){
        if(row < arrTM1.count)
            _time1=arrTM1[row];
    }
    if([pickerView isEqual:tm2]){
        _time2=nil;
        if(row == kTM2){
            btn2.selected=NO;

        }
        else if(row < arrTM2.count){
            btn2.selected=YES;
            _time2=arrTM2[row];
        }
    }
    if([pickerView isEqual:tm3]){
        _time3=nil;
        if(row == kTM3){
            btn3.selected=NO;

        }
        else if(row < arrTM3.count){
            btn3.selected=YES;
            _time3=arrTM3[row];
        }
    }
    if([pickerView isEqual:tm4]){
        _time4=nil;
        if(row == kTM4){
            btn4.selected=NO;
        }
        else if(row < arrTM4.count){
            btn4.selected=YES;
            _time4=arrTM4[row];
        }
    }
    [pickerView reloadInputViews];
    [self timesList];
}
@end
