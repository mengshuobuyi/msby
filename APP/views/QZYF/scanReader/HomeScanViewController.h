//
//  HomeScanViewController.h
//  APP
//  首页扫码，V4.0UI调整重新构造UI
//  Created by 李坚 on 16/6/24.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "QWBaseVC.h"
#import "IOSScanView.h"

@interface HomeScanViewController : QWBaseVC<IOSScanViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *readerView;

@property (nonatomic, assign) BOOL torchMode;          //控制闪光灯的开关

@end
