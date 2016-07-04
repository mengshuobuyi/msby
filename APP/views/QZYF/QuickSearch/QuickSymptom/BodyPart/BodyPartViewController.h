//
//  BodyPartViewController.h
//  APP
//
//  Created by qwfy0006 on 15/3/11.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "QWBaseVC.h"

typedef enum PeopleKind{
    CHILD_KIND,
    MAN_KIND,
    WOMAN_KIND
} PeopleKind;

@interface BodyPartViewController : QWBaseVC

//- (void)viewDidCurrentView;
- (IBAction)showBodyHighLight:(id)sender;
- (IBAction)didSelectDifferentBodyPart:(id)sender;
- (IBAction)transformSex:(id)sender;
- (IBAction)turnAround:(id)sender;
@property (nonatomic, weak) UIViewController      *containerViewController;


@property (nonatomic, strong) IBOutlet  UIView   *manPositive;
@property (nonatomic, strong) IBOutlet  UIView   *manNegative;
@property (nonatomic, strong) IBOutlet  UIView   *womanPositive;
@property (nonatomic, strong) IBOutlet  UIView   *womanNegative;
@property (nonatomic, strong) IBOutlet  UIView   *childPositive;
@property (nonatomic, strong) IBOutlet  UIView   *childNegative;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *frontButtom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backButtom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *childFront;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *womanBack;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *childBack;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *womanFront;


- (void)refresh;

@end
