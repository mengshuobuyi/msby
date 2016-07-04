//
//  BodyPartViewController.m
//  APP
//
//  Created by qwfy0006 on 15/3/11.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "BodyPartViewController.h"
#import "BodyParterTableViewController.h"
#import "SymptomViewController.h"
#import "SVProgressHUD.h"


@interface BodyPartViewController ()
{
    PeopleKind      peopleKind;
    BOOL            positive;
    NSMutableArray *array;
}
@end

@implementation BodyPartViewController

- (void)refresh
{

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    array=[NSMutableArray array];
    peopleKind = MAN_KIND;
    positive = YES;
    self.view.backgroundColor = RGBHex(qwColor11);
    
    //遍历约束
    [self changeCon:self.manPositive];
    
    //底部的约束
    NSArray* constrains = self.view.constraints;
    for (NSLayoutConstraint* constraint in constrains) {
        if (constraint.firstAttribute == NSLayoutAttributeBottom) {
            if(IS_IPHONE_6){
            constraint.constant = constraint.constant*1.6;
            }else if(IS_IPHONE_6P){
            constraint.constant = constraint.constant*1.9;
            }else if(IS_IPHONE_4_OR_LESS){
                if(constraint.constant>40){
                     constraint.constant = constraint.constant-40;
                }
            }
        }
    }
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    
}

-(void)popVCAction:(id)sender {
    [super popVCAction:sender];
    
}

- (IBAction)didSelectDifferentBodyPart:(id)sender
{
    [self resetBodyImage];
    NSUInteger tag = ((UIButton *)sender).tag;
    NSMutableDictionary *source = [NSMutableDictionary dictionary];
    
    NSString *title = @"";
    switch (tag) {
        case 101:
        {
            //头部点击
//            [QWGLOBALMANAGER statisticsEventId:@"x_zz_1" withLable:@"部位查找" withParams:nil];
            title = @"头部";
            source[@"bodyCode"] = @"01";
            break;
        }
        case 102:
        {
            //颈部点击
            title = @"颈部";
            source[@"bodyCode"] = @"03";
            break;
        }
        case 103:
        {
            //全身
            title = @"全身";
            source[@"bodyCode"] = @"11";
            break;
        }
        case 880:
        case 104:
        {
            //上肢
            title = @"上肢";
            source[@"bodyCode"] = @"04";
            break;
        }
        case 105:
        {
            //胸
            title = @"胸";
            source[@"bodyCode"] = @"05";
            break;
        }
        case 106:
        {
            //腹部
            title = @"腹部";
            source[@"bodyCode"] = @"06";
            break;
        }
        case 107:
        {
            //生殖
            title = @"生殖";
            source[@"bodyCode"] = @"09";
            break;
        }
        case 108:
        {
            //下肢
            title = @"下肢";
            source[@"bodyCode"] = @"10";
            break;
        }
        case 109:
        {
            //臀
            title = @"臀";
            source[@"bodyCode"] = @"12";
            break;
        }
        case 110:
        {
            //背部
            title = @"背部";
            source[@"bodyCode"] = @"07";
            break;
        }
        case 120:
        {
            //腰部
            title = @"腰部";
            source[@"bodyCode"] = @"13";
            break;
        }
        default:
            break;
    }
    NSMutableDictionary *tdParams = [NSMutableDictionary dictionary];
    tdParams[@"点击内容"]=title;
    [QWGLOBALMANAGER statisticsEventId:@"x_zz_bw" withLable:@"症状" withParams:tdParams];
    

    source[@"sex"] = [NSString stringWithFormat:@"%d",peopleKind];
    if(peopleKind == MAN_KIND || peopleKind == WOMAN_KIND)
        source[@"population"] = @"1";
    else
        source[@"population"] = @"2";
    if(positive)
        source[@"position"] = @"1";
    else
        source[@"position"] = @"2";
    
    if(tag == 101){
        
        BodyParterTableViewController *bodyTableViewController = [[BodyParterTableViewController alloc] init];
        bodyTableViewController.title = title;
        bodyTableViewController.soureDict = [source copy];
        bodyTableViewController.containerViewController = self.containerViewController;
        [self.containerViewController.navigationController pushViewController:bodyTableViewController animated:YES];
        
    }else{
        SymptomViewController *symptomViewController = [[SymptomViewController alloc] init];
        symptomViewController.requestType = bodySym;
        symptomViewController.requsetDic = source;
        symptomViewController.title = title;
        symptomViewController.containerViewController = self.containerViewController;
        [self.containerViewController.navigationController pushViewController:symptomViewController animated:YES];
        
    }
}

- (void)backToPreviousController:(id)sender
{
    if(self.containerViewController) {
        [self.containerViewController.navigationController popViewControllerAnimated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)resetBodyImage
{
    switch (peopleKind) {
        case MAN_KIND:
        {
            UIButton *bodyButton = nil;
            if(positive) {
                bodyButton = (UIButton *)[self.manPositive viewWithTag:880];
            }else{
                bodyButton = (UIButton *)[self.manNegative viewWithTag:880];
            }
            [bodyButton setBackgroundImage:nil forState:UIControlStateNormal];
            break;
        }
        case WOMAN_KIND:
        {
            UIButton *bodyButton = nil;
            if(positive) {
                bodyButton = (UIButton *)[self.womanPositive viewWithTag:880];
            }else{
                bodyButton = (UIButton *)[self.womanNegative viewWithTag:880];
            }
            [bodyButton setBackgroundImage:nil forState:UIControlStateNormal];
            break;
        }
        case CHILD_KIND:
        {
            UIButton *bodyButton = nil;
            if(positive) {
                bodyButton = (UIButton *)[self.childPositive viewWithTag:880];
            }else{
                bodyButton = (UIButton *)[self.childNegative viewWithTag:880];
            }
            [bodyButton setBackgroundImage:nil forState:UIControlStateNormal];
            break;
        }
        default:
            break;
    }
}

- (IBAction)showBodyHighLight:(id)sender
{
    switch (peopleKind) {
        case MAN_KIND:
        {
            UIButton *bodyButton = nil;
            if(positive) {
                bodyButton = (UIButton *)[self.manPositive viewWithTag:880];
                [bodyButton setBackgroundImage:[UIImage imageNamed:@"man_front_upper-limb"] forState:UIControlStateNormal];
            }else{
                bodyButton = (UIButton *)[self.manNegative viewWithTag:880];
                [bodyButton setBackgroundImage:[UIImage imageNamed:@"man_back_upper-limb"] forState:UIControlStateNormal];
            }
            break;
        }
        case WOMAN_KIND:
        {
            UIButton *bodyButton = nil;
            if(positive) {
                bodyButton = (UIButton *)[self.womanPositive viewWithTag:880];
                [bodyButton setBackgroundImage:[UIImage imageNamed:@"woman_front_upper-limb"] forState:UIControlStateNormal];
            }else{
                bodyButton = (UIButton *)[self.womanNegative viewWithTag:880];
                [bodyButton setBackgroundImage:[UIImage imageNamed:@"woman_back_upper-limb"] forState:UIControlStateNormal];
            }
            break;
        }
        case CHILD_KIND:
        {
            UIButton *bodyButton = nil;
            if(positive) {
                bodyButton = (UIButton *)[self.childPositive viewWithTag:880];
                [bodyButton setBackgroundImage:[UIImage imageNamed:@"child_front_upper-limb"] forState:UIControlStateNormal];
            }else{
                bodyButton = (UIButton *)[self.childNegative viewWithTag:880];
                [bodyButton setBackgroundImage:[UIImage imageNamed:@"child_back_upper-limb"] forState:UIControlStateNormal];
            }
            
            break;
        }
        default:
            break;
    }
    
    
}

-(void)changeCon:(UIView *)view{
    
    if(![array containsObject:view]){
   
    //宽度的约束放大
    if(IS_IPHONE_6P||IS_IPHONE_6){
        NSArray* constrainsPositive = view.constraints;
        for (NSLayoutConstraint* constraint in constrainsPositive) {
            constraint.constant = constraint.constant*kAutoScale;
        }
        [array addObject:view];
    }
       
    //高度的约束放大
    if(IS_IPHONE_4_OR_LESS){
        NSArray* constrainsPositive = view.constraints;
        for (NSLayoutConstraint* constraint in constrainsPositive) {
            if(constraint.firstAttribute==NSLayoutAttributeTop){
              constraint.constant = constraint.constant-45;
            }
        }
        [array addObject:view];
    }
        
        
    }
    
}


- (IBAction)transformSex:(id)sender
{
    positive = YES;
    UIButton *button = (UIButton *)sender;
    switch (peopleKind) {
        case MAN_KIND:
        {
            peopleKind = WOMAN_KIND;
            [button setBackgroundImage:[UIImage imageNamed:@"sex_woman.png"] forState:UIControlStateNormal];
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.8f];
            [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:NO];
//            [self.manPositive removeFromSuperview];
//            [self.manNegative removeFromSuperview];
//            [self.view insertSubview:self.womanPositive atIndex:0];
//            [self.view insertSubview:self.womanNegative belowSubview:self.womanPositive];
            self.manPositive.hidden=YES;
            self.manNegative.hidden=YES;
        
            self.womanPositive.hidden=NO;
            self.womanNegative.hidden=YES;
            
            [self changeCon:self.womanPositive];
            
            
            
            
            [UIView commitAnimations];
            break;
        }
        case WOMAN_KIND:
        {
            peopleKind = CHILD_KIND;
            [button setBackgroundImage:[UIImage imageNamed:@"sex_child.png"] forState:UIControlStateNormal];
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.8f];
            [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:NO];
//            [self.womanPositive removeFromSuperview];
//            [self.womanNegative removeFromSuperview];
//            
//            [self.view insertSubview:self.childPositive atIndex:0];
//            [self.view insertSubview:self.childNegative belowSubview:self.childPositive];
            self.womanPositive.hidden=YES;
            self.womanNegative.hidden=YES;
            self.childPositive.hidden=NO;
            self.childNegative.hidden=YES;
            
            [self changeCon:self.childPositive];
            
            [UIView commitAnimations];
            break;
        }
        case CHILD_KIND:
        {
            peopleKind = MAN_KIND;
            [button setBackgroundImage:[UIImage imageNamed:@"sex_man.png"] forState:UIControlStateNormal];
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.8f];
            [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:NO];
//            [self.childPositive removeFromSuperview];
//            [self.childNegative removeFromSuperview];
//            
//            [self.view insertSubview:self.manPositive atIndex:0];
//            [self.view insertSubview:self.manNegative belowSubview:self.manPositive];
            
          
            self.childPositive.hidden=YES;
            self.childNegative.hidden=YES;
            self.manPositive.hidden=NO;
            self.manNegative.hidden=YES;
            
            [self changeCon:self.manPositive];
            
            [UIView commitAnimations];
            break;
        }
        default:
            break;
    }
    
}

- (void)dealloc
{
    
}


- (IBAction)turnAround:(id)sender
{
    positive = !positive;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.8f];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:NO];
    
//    [self.view exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    
    
    switch (peopleKind) {
        case MAN_KIND:
        {
            if(positive){
                self.manPositive.hidden=NO;
                self.manNegative.hidden=YES;
                [self changeCon:self.manPositive];
            }else{
                self.manPositive.hidden=YES;
                self.manNegative.hidden=NO;
                [self changeCon:self.manNegative];
            }

            break;
        }
        case WOMAN_KIND:
        {
            if(positive){
                self.womanPositive.hidden=NO;
                self.womanNegative.hidden=YES;
                [self changeCon:self.womanPositive];
            }else{
                self.womanPositive.hidden=YES;
                self.womanNegative.hidden=NO;
                [self changeCon:self.womanNegative];
            }
            break;
        }
        case CHILD_KIND:
        {
            if(positive){
                self.childPositive.hidden=NO;
                self.childNegative.hidden=YES;
                [self changeCon:self.childPositive];
            }else{
                self.childPositive.hidden=YES;
                self.childNegative.hidden=NO;
                [self changeCon:self.childNegative];
            }
            break;
        }
        default:
            break;
    }
    
    
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
