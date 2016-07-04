//
//  jumpHtmlViewController.m
//  APP
//
//  Created by caojing on 16/4/25.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "jumpHtmlViewController.h"
#import "WebDirectViewController.h"
#import "SVProgressHUD.h"

@interface jumpHtmlViewController ()

@end

@implementation jumpHtmlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)testHtml:(id)sender {
    
    WebDirectViewController *serverInfo = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
    WebDirectLocalModel *modelLocal = [WebDirectLocalModel new];
    modelLocal.title = @"HTML专用测试";
    NSString *url=[self.urlText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //两边去空后进行判断
    if (StrIsEmpty(url)){
        [SVProgressHUD showErrorWithStatus:@"请输入正确的链接！" duration:DURATION_SHORT];
        return;
    }
    modelLocal.url = url;
    modelLocal.typeLocalWeb = WebLocalTypeOuterLink;
    [serverInfo setWVWithLocalModel:modelLocal];
    serverInfo.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:serverInfo animated:YES];

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
