//
//  KnowLedgeViewController.m
//  wenyao
//
//  Created by Meng on 14-9-29.
//  Copyright (c) 2014年 xiezhenghong. All rights reserved.
//

#import "KnowLedgeViewController.h"
#import "ZhPMethod.h"

@interface KnowLedgeViewController ()

@end

@implementation KnowLedgeViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
       self.title = @"用药小知识";
    [self initView];
}

- (void)initView{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, APP_W, APP_H)];
    scrollView.backgroundColor = [UIColor whiteColor];

    NSString * title = [QWGLOBALMANAGER replaceSpecialStringWith:self.knowledgeTitle];
    CGSize titleSize = getTempTextSize(title, fontSystem(kFontS1), APP_W-20);
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 19, APP_W, titleSize.height)];
    titleLabel.font = fontSystem(kFontS2);
    titleLabel.textColor =RGBHex(qwColor6);
    titleLabel.text = title;
    [scrollView addSubview:titleLabel];
    
    UIView * line1 = [[UIView alloc] initWithFrame:CGRectMake(10, titleLabel.frame.origin.y + titleLabel.frame.size.height + 8, APP_W-20, 0.5)];
    line1.backgroundColor = RGBHex(qwColor10);
    [scrollView addSubview:line1];
    
    NSString * content = [QWGLOBALMANAGER replaceSpecialStringWith:self.knowledgeContent];
    CGSize size = getTempTextSize(content, fontSystem(kFontS4), APP_W-20);
    UILabel * contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, line1.frame.origin.y + line1.frame.size.height + 8, APP_W-20, size.height + 10)];
    contentLabel.textColor = RGBHex(qwColor7);
    contentLabel.numberOfLines = 0;
    contentLabel.font =fontSystem(kFontS4);
    contentLabel.text = content;
    [scrollView addSubview:contentLabel];

    
    
    [self.view addSubview:scrollView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
