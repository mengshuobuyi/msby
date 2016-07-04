//
//  BodyPartViewController.h
//  APP
//
//  Created by qwfy0006 on 15/3/11.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "QWBaseVC.h"

typedef enum HALF_PeopleKind{
    HALF_CHILD_KIND,
    HALF_MAN_KIND,
    HALF_WOMAN_KIND
} HALF_PeopleKind;

@interface BodyPartHalfViewController : QWBaseVC

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

- (void)refresh;

@end
