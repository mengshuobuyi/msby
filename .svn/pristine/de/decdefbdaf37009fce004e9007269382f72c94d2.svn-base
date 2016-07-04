//
//  QWLNActionSheet.m
//  wenyao
//
//  Created by Yan Qingyang on 15/4/11.
//  Copyright (c) 2015年 xiezhenghong. All rights reserved.
//
#import "QWLNTimeListCell.h"
#import "QWLNActionSheet.h"
#import "QWcss.h"

//static float kAlpha = 0.4f;
static float kTblCellH = 44.f;
static NSInteger kMax = 6;
static NSInteger kMin = 1;

@interface QWLNActionSheet()
<UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UIButton *btnShadow,*btnTimeClose;
    IBOutlet UIView *vHeader,*vFooter;
    IBOutlet UIView *vTime;
    IBOutlet UIButton *btnAdd,*btnDel;
    IBOutlet UIButton *btnOK,*btnOKTime;
    IBOutlet UITableView *tableMain;
    IBOutlet UILabel *lblTTL;
    IBOutlet UIView* vSeparatorLine;
    IBOutlet UIDatePicker *picker;
    
//    UIView *curView;
//    NSMutableArray *self.listTimes;
//    NSMutableArray *arrHour,*arrMin;
    
    NSInteger curTime;
}
@end

@implementation QWLNActionSheet
@synthesize delegate=_delegate;

+(QWLNActionSheet *)instance
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"QWLNActionSheet" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}

+(QWLNActionSheet *)instanceWithDelegate:(id)delegate timeList:(NSMutableArray*)list showInView:(UIView *)aView{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"QWLNActionSheet" owner:nil options:nil];
    QWLNActionSheet *sheet=[nibView objectAtIndex:0];
    sheet.delegate=delegate;
    sheet.listTimes=list;
    sheet.curView=aView;
    return sheet;
}

- (void)UIGlobal{
//    UIWindow *win=[UIApplication sharedApplication].keyWindow;
    
    CGRect frm=tableMain.frame;
    frm.size.height=kTblCellH * self.listTimes.count+CGRectGetHeight(vHeader.bounds)+CGRectGetHeight(vFooter.bounds);
    tableMain.frame=frm;
    
    frm=vTime.frame;
    frm.origin.y=CGRectGetHeight(self.curView.bounds);
    vTime.frame=frm;
    
    btnShadow.backgroundColor=[UIColor colorWithWhite:0 alpha:0];
    btnTimeClose.backgroundColor=[UIColor colorWithWhite:0 alpha:0];
    btnTimeClose.hidden=YES;
    
    vHeader.backgroundColor=[UIColor whiteColor];
    vFooter.backgroundColor=[UIColor whiteColor];
    vTime.backgroundColor=[UIColor whiteColor];
    
    tableMain.tableHeaderView=vHeader;
    tableMain.tableFooterView=vFooter;
    
    frm=vSeparatorLine.bounds;
    frm.origin.y=CGRectGetHeight(vHeader.bounds)-0.5f;
    frm.size.height=.5f;
    frm.origin.x=7;
    frm.size.width=CGRectGetWidth(vHeader.bounds)-14;
    vSeparatorLine.frame=frm;
    
    vSeparatorLine.backgroundColor = RGBAHex(qwColor10, 1);
    
    lblTTL.font=fontSystem(kFontS4);
    lblTTL.textColor=RGBHex(qwColor7);
    lblTTL.text=@"设置服药时间";
    
    btnOK.backgroundColor=RGBHex(qwColor2);
    btnOK.titleLabel.font=fontSystem(kFontS2);
    btnOK.layer.cornerRadius=4;
    
    btnOKTime.backgroundColor=RGBHex(qwColor2);
    btnOKTime.titleLabel.font=fontSystem(kFontS2);
    btnOKTime.layer.cornerRadius=4;
    
    [self checkBtns];
    
    [picker setBackgroundColor:[UIColor whiteColor]];
//    [_datePicker addTarget:self action:@selector(datePickerValueChange:) forControlEvents:UIControlEventValueChanged];
    picker.datePickerMode = UIDatePickerModeTime;
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"NL"];
    [picker setLocale:locale];
    
//    arrHour=[[NSMutableArray alloc]initWithCapacity:24];
//    arrMin=[[NSMutableArray alloc]initWithCapacity:60];
//    int i=0;
//    while (i<24) {
//        [arrHour addObject:[NSString stringWithFormat:@"%2i",i]];
//        i++;
//    }
//    
//    i=0;
//    while (i<60) {
//        [arrMin addObject:[NSString stringWithFormat:@"%2i",i]];
//        i++;
//    }
    
//    picker.
}

- (void)checkBtns{
    if (self.listTimes.count==kMax) {
        btnAdd.enabled=NO;
    }
    else
        btnAdd.enabled=YES;
    
    if (self.listTimes.count==kMin) {
        btnDel.enabled=NO;
    }
    else
        btnDel.enabled=YES;
}

- (void)show{
    [self UIGlobal];
//    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate]
//    UIWindow *win=[UIApplication sharedApplication].keyWindow;
    CGRect frm=self.curView.bounds;
    self.frame=frm;
    [self.curView addSubview:self];
//    [self.curView bringSubviewToFront:self];
    
    
    
    frm=tableMain.frame;
    frm.origin.y=CGRectGetHeight(self.curView.bounds);
    tableMain.frame=frm;
    
    [UIView animateWithDuration:.25 animations:^{
        btnShadow.backgroundColor=[UIColor colorWithWhite:0 alpha:kShadowAlpha];
        
        CGRect frm;
        frm=tableMain.frame;
        frm.origin.y=CGRectGetHeight(self.curView.bounds)-CGRectGetHeight(tableMain.frame);
        tableMain.frame=frm;
        
        [tableMain reloadData];
    } completion:^(BOOL finished) {

    }];
}

- (void)checkTableInsert{
    
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.listTimes.count-1 inSection:0];
        [tableMain insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationBottom];
        [UIView animateWithDuration:.3 animations:^{
            CGRect frm=tableMain.frame;
            frm.size.height=kTblCellH * self.listTimes.count+CGRectGetHeight(vHeader.bounds)+CGRectGetHeight(vFooter.bounds);
            frm.origin.y=CGRectGetHeight(self.curView.bounds)-frm.size.height;
            tableMain.frame=frm;
        } completion:^(BOOL finished) {
            
        }];
    }
    else {
        CGRect frm=tableMain.frame;
        frm.size.height=kTblCellH * self.listTimes.count+CGRectGetHeight(vHeader.bounds)+CGRectGetHeight(vFooter.bounds);
        frm.origin.y=CGRectGetHeight(self.curView.bounds)-frm.size.height;
        tableMain.frame=frm;
        
        [tableMain reloadData];
    }
    
    
    
}

- (void)checkTableDelete{
    
    
//    UIWindow *win=[UIApplication sharedApplication].keyWindow;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.listTimes.count inSection:0];
        [tableMain deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationBottom];
        [UIView animateWithDuration:.3 animations:^{
            CGRect frm=tableMain.frame;
            frm.size.height=kTblCellH * self.listTimes.count+CGRectGetHeight(vHeader.bounds)+CGRectGetHeight(vFooter.bounds);
            frm.origin.y=CGRectGetHeight(self.curView.bounds)-frm.size.height;
            tableMain.frame=frm;
        } completion:^(BOOL finished) {
            
        }];
    }
    else {
        CGRect frm=tableMain.frame;
        frm.size.height=kTblCellH * self.listTimes.count+CGRectGetHeight(vHeader.bounds)+CGRectGetHeight(vFooter.bounds);
        frm.origin.y=CGRectGetHeight(self.curView.bounds)-frm.size.height;
        tableMain.frame=frm;
        
        [tableMain reloadData];
    }
    
    
}
- (void)checkTimeList{
    NSMutableArray *tmp=[NSMutableArray arrayWithCapacity:kMax];
    for (NSString *str in self.listTimes) {
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
    
    self.listTimes=[tmp mutableCopy];
}

- (void)setListTimes:(NSMutableArray *)listTimes{
//    self.listTimes=[listTimes mutableCopy];
//    [tableMain reloadData];
//    
    _listTimes=[listTimes mutableCopy];
}

#pragma mark - action
- (IBAction)closeAction:(id)sender{
//    UIWindow *win=[UIApplication sharedApplication].keyWindow;
    
    [UIView animateWithDuration:.15 animations:^{
        btnShadow.backgroundColor=[UIColor colorWithWhite:0 alpha:0];
        
        CGRect frm;
        frm=tableMain.frame;
        frm.origin.y=CGRectGetHeight(self.curView.bounds);
        tableMain.frame=frm;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (IBAction)addAction:(id)sender{
    [self.listTimes addObject:@"18:00"];
    [self checkBtns];
    [self checkTableInsert];
}

- (IBAction)delAction:(id)sender{
    if (self.listTimes.count>kMin) {
        [self.listTimes removeLastObject];
    }
    [self checkBtns];
    [self checkTableDelete];
}

- (IBAction)okAction:(id)sender{
    [self checkTimeList];
    
//    UIWindow *win=[UIApplication sharedApplication].keyWindow;
    
    [UIView animateWithDuration:.15 animations:^{
        btnShadow.backgroundColor=[UIColor colorWithWhite:0 alpha:0];
        
        CGRect frm;
        frm=tableMain.frame;
        frm.origin.y=CGRectGetHeight(self.curView.bounds);
        tableMain.frame=frm;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if ([self.delegate respondsToSelector:@selector(QWLNActionSheetDelegate:)]) {
            [self.delegate QWLNActionSheetDelegate:self.listTimes];
        }
    }];
}

- (IBAction)okTimeAction:(id)sender{
    //确定时间修改
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *datePickerStr = [dateFormatter stringFromDate:picker.date];
    NSMutableString *mutStr = [[NSMutableString alloc] initWithString:datePickerStr];
    
    if (curTime<self.listTimes.count) {
        [self.listTimes removeObjectAtIndex:curTime];
        [self.listTimes insertObject:mutStr atIndex:curTime];
        
        [tableMain reloadData];
    }
    
    [self timeCloseAction:nil];
}

- (IBAction)timeCloseAction:(id)sender{
    
//    UIWindow *win=[UIApplication sharedApplication].keyWindow;
    [UIView animateWithDuration:.25 animations:^{
        CGRect frm;
        frm=vTime.frame;
        frm.origin.y=CGRectGetHeight(self.curView.bounds);
        vTime.frame=frm;
        
        btnTimeClose.backgroundColor=[UIColor colorWithWhite:0 alpha:0];
    } completion:^(BOOL finished) {
        btnTimeClose.hidden=YES;
    }];
}

#pragma mark - table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listTimes.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kTblCellH;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    
    static NSString *tableID=@"QWLNTimeListCell";
    if (row<self.listTimes.count) {
        QWLNTimeListCell *cell;
        cell = (QWLNTimeListCell*)[tableView dequeueReusableCellWithIdentifier:tableID];
        if (cell == nil) {
            //获取nib里第一个
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"QWLNTimeListCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            
        }
        cell.delegate=self;
        
        [cell setCell:[self.listTimes objectAtIndex:row]];
        
        
        return cell;
    }
    
    return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:tableID];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    curTime=row;
    
    if (row<self.listTimes.count) {
        NSString *tt=[self.listTimes objectAtIndex:row];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH:mm"];
        NSDate *dt = [dateFormatter dateFromString:tt];
        [picker setDate:dt animated:NO];
    }
    
//    UIWindow *win=[UIApplication sharedApplication].keyWindow;
    btnTimeClose.hidden=NO;
    btnTimeClose.backgroundColor=[UIColor colorWithWhite:0 alpha:0];
    [UIView animateWithDuration:.25 animations:^{
        CGRect frm;
        frm=vTime.frame;
        frm.origin.y=CGRectGetHeight(self.curView.bounds)-CGRectGetHeight(vTime.frame);
        vTime.frame=frm;
        
        btnTimeClose.backgroundColor=[UIColor colorWithWhite:0 alpha:.15];
    } completion:^(BOOL finished) {
        
    }];
}


@end
