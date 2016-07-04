//
//  AnalyzeMedicineViewController.m
//  APP
//
//  Created by garfield on 15/12/16.
//  Copyright © 2015年 carret. All rights reserved.
//

#import "AnalyzeMedicineViewController.h"
#import "FamilyMedicine.h"
#import "QWH5Loading.h"
#import "SBJson.h"

@interface AnalyzeMedicineViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation AnalyzeMedicineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用药分析";
    _dataArray = [NSMutableArray arrayWithObjects:[NSNull null],[NSNull null], nil];
    [QWH5LOADING showLoading];
    [self initWebView];
}

- (void)initWebView
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"familystatisticscharts" ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, APP_W, APP_H)];
    self.webView.delegate = self;
    _webView.scalesPageToFit = YES;
    [self.view addSubview:self.webView];
    [_webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:filePath]];
    
    
}

- (void)queryAnalyze
{
    AnalystByTypeModelR *modelR = [AnalystByTypeModelR new];
    modelR.token = QWGLOBALMANAGER.configure.userToken;
    [FamilyMedicine analystByType:modelR success:^(AnalystByTypeList *model) {
        if([model.apiStatus intValue] == 0) {
            _dataArray[1] = model.list;
            [self callJavaScriptToupDateChart];
        }
    } failure:NULL];
    
    [FamilyMedicine analystByMember:modelR success:^(AnalystByMemberList *model) {
        if([model.apiStatus intValue] == 0) {
            _dataArray[0] = model.list;
            [self callJavaScriptToupDateChart];
        }
    } failure:^(HttpException *e) {
        
    }];
    
}

- (void)hideProgressBar
{
    [QWH5LOADING closeLoading];
}

- (void)getChartsData:(NSString *)type
{
    if([type isEqualToString:@"familytatisticscharts"]) {
        [self queryAnalyze];
    }
}

- (void)callJavaScriptToupDateChart
{
    if(![_dataArray[0] isKindOfClass:[NSNull class]] && ![_dataArray[1] isKindOfClass:[NSNull class]])
    {
        if(((NSArray *)_dataArray[0]).count == 0 && ((NSArray *)_dataArray[1]).count == 0)
        {
            [QWH5LOADING closeLoading];
            [self showInfoView:kWarning30 image:@"ic_img_fail"];
            return;
        }
        NSMutableDictionary *jsonDictonary = [NSMutableDictionary dictionaryWithCapacity:2];
        NSMutableArray *subArray = [NSMutableArray arrayWithCapacity:10];
        
        for(AnalystByMemberVOModel *model in _dataArray[0]) {
            NSMutableDictionary *subConvertDict = [NSMutableDictionary dictionary];
            subConvertDict[@"label"] = model.name;
            subConvertDict[@"value"] = model.amount;
            [subArray addObject:subConvertDict];
        }
        jsonDictonary[@"labels"] =subArray;
        subArray = [NSMutableArray arrayWithCapacity:10];
        for(AnalystByTypeVOModel *model in _dataArray[1]) {
            NSMutableDictionary *subConvertDict = [NSMutableDictionary dictionary];
            subConvertDict[@"label"] = model.medicineType;
            subConvertDict[@"value"] = model.amount;
            [subArray addObject:subConvertDict];
        }
        jsonDictonary[@"charts"] = subArray;
        NSString *json = [jsonDictonary JSONRepresentation];
        
        NSString *callMethod = [NSString stringWithFormat:@"showCharts(%@)",json];

        [_webView stringByEvaluatingJavaScriptFromString:callMethod];
    }
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *requestString = [[request URL] absoluteString];
    NSArray *components = [requestString componentsSeparatedByString:@":"];
    if ([components count] > 1 && [(NSString *)[components objectAtIndex:0] isEqualToString:@"objc"]) {
        if([components[1] rangeOfString:@"getChartsData"].location != NSNotFound) {
            NSString *param = [[components[1] componentsSeparatedByString:@"/"] lastObject];
            [self getChartsData:param];
        }else if ([components[1] rangeOfString:@"hideProgressBar"].location != NSNotFound) {
            [self hideProgressBar];
        }
        return NO;
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

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
