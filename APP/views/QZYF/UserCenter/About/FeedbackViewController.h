//
//  FeedbackViewController.h
//  APP
//
//  Created by qwfy0006 on 15/3/16.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "QWBaseVC.h"

@interface FeedbackViewController : QWBaseVC<UITextViewDelegate,UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UIScrollView     *scrollView;

@end
