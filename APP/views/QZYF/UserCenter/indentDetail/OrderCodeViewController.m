//
//  OrderCodeViewController.m
//  APP
//
//  Created by qw_imac on 16/1/20.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "OrderCodeViewController.h"
#import "QRCodeGenerator.h"
@interface OrderCodeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *codeImg;
@property (weak, nonatomic) IBOutlet UILabel *codeLabel;
@property (nonatomic,copy) dispatch_source_t checkTimer;
@end

@implementation OrderCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单二维码";
    _codeLabel.text = [NSString stringWithFormat:@"%@",_receiveCode];
    _codeImg.image = [QRCodeGenerator qrImageForString:_code imageSize:_codeImg.bounds.size.width Topimg:nil];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //[self loopCheckUseStatus];
}

-(void)loopCheckUseStatus {
    _checkTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    dispatch_source_set_timer(_checkTimer, dispatch_time(DISPATCH_TIME_NOW, 5ull*NSEC_PER_SEC), 5ull*NSEC_PER_SEC, DISPATCH_TIME_FOREVER);
    dispatch_source_set_event_handler(_checkTimer, ^{
        DDLogVerbose(@"1");
    });
    dispatch_source_set_cancel_handler(_checkTimer, ^{
        DDLogVerbose(@"has been canceled");
    });
    dispatch_resume(_checkTimer);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
