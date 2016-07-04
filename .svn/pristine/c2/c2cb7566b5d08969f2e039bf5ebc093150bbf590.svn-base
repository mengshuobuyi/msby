//
//  BodyPartViewController.m
//  APP
//
//  Created by qwfy0006 on 15/3/11.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "BodyPartHalfViewController.h"
#import "BodyParterTableViewController.h"
#import "SymptomViewController.h"
#import "SVProgressHUD.h"


@interface BodyPartHalfViewController ()
{
    HALF_PeopleKind      peopleKind;
    BOOL            positive;
}
@end

@implementation BodyPartHalfViewController

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
    peopleKind = HALF_MAN_KIND;
    positive = YES;
    [self.view insertSubview:self.manPositive atIndex:0];
    [self.view insertSubview:self.manNegative belowSubview:self.manPositive];
    self.view.backgroundColor = RGBHex(qwColor11);
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
    source[@"sex"] = [NSString stringWithFormat:@"%d",peopleKind];
    if(peopleKind == HALF_MAN_KIND || peopleKind == HALF_WOMAN_KIND)
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
        case HALF_MAN_KIND:
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
        case HALF_WOMAN_KIND:
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
        case HALF_CHILD_KIND:
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
        case HALF_MAN_KIND:
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
        case HALF_WOMAN_KIND:
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
        case HALF_CHILD_KIND:
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

- (IBAction)transformSex:(id)sender
{
    positive = YES;
    UIButton *button = (UIButton *)sender;
    switch (peopleKind) {
        case HALF_MAN_KIND:
        {
            peopleKind = HALF_WOMAN_KIND;
            [button setBackgroundImage:[UIImage imageNamed:@"sex_woman.png"] forState:UIControlStateNormal];
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.8f];
            [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:NO];
            [self.manPositive removeFromSuperview];
            [self.manNegative removeFromSuperview];
            [self.view insertSubview:self.womanPositive atIndex:0];
            [self.view insertSubview:self.womanNegative belowSubview:self.womanPositive];
            [UIView commitAnimations];
            break;
        }
        case HALF_WOMAN_KIND:
        {
            peopleKind = HALF_CHILD_KIND;
            [button setBackgroundImage:[UIImage imageNamed:@"sex_child.png"] forState:UIControlStateNormal];
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.8f];
            [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:NO];
            [self.womanPositive removeFromSuperview];
            [self.womanNegative removeFromSuperview];
            
            [self.view insertSubview:self.childPositive atIndex:0];
            [self.view insertSubview:self.childNegative belowSubview:self.childPositive];
            [UIView commitAnimations];
            break;
        }
        case HALF_CHILD_KIND:
        {
            peopleKind = HALF_MAN_KIND;
            [button setBackgroundImage:[UIImage imageNamed:@"sex_man.png"] forState:UIControlStateNormal];
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.8f];
            [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:NO];
            [self.childPositive removeFromSuperview];
            [self.childNegative removeFromSuperview];
            
            [self.view insertSubview:self.manPositive atIndex:0];
            [self.view insertSubview:self.manNegative belowSubview:self.manPositive];
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
    
    [self.view exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
