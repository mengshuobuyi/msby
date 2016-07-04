//
//  SymptomViewController.m
//  APP
//
//  Created by qwfy0006 on 15/3/11.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "SymptomViewController.h"
#import "ReturnIndexView.h"
#import "SpmApi.h"
#import "QWFileManager.h"
#import "WebDirectViewController.h"
#import "MessageBoxListViewController.h"
#import "LoginViewController.h"

@interface SymptomViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,ReturnIndexViewDelegate,BATableViewDelegate>

{
    BATableView * myTableView;
    UIView * _nodataView;
}
@property (nonatomic ,strong) NSMutableArray *rightIndexArray;
//设置每个section下的cell内容
@property (nonatomic ,strong) NSMutableArray *LetterResultArr;

@property (nonatomic ,strong) NSMutableArray * usualArray;
@property (nonatomic ,strong) NSMutableArray * unusualArray;
@property (nonatomic ,strong) NSMutableArray * dataSource;
@property (nonatomic, strong) ReturnIndexView *indexView;
@property (nonatomic, strong) UILabel *numLabel;   //数字角标
@property (nonatomic, strong) UILabel *redLabel;   //小红点
@property (assign, nonatomic) int passNumber;


@end

@implementation SymptomViewController

@synthesize rightIndexArray,LetterResultArr;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}


- (void)backToPreviousController:(id)sender
{
    @try {
        [self.navigationController popViewControllerAnimated:YES];
    }
    @catch (NSException *exception) {

    }
    @finally {
        
    }
}

- (void)dealloc
{
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.passNumber = [QWGLOBALMANAGER updateRedPoint];
//    [self setUpRightItem];
    
    [self subViewWillAppear];
    
}

- (void)viewInfoClickAction:(id)sender
{
    if (QWGLOBALMANAGER.currentNetWork != kNotReachable) {
        [self removeInfoView];
        self.passNumber = [QWGLOBALMANAGER updateRedPoint];
//        [self setUpRightItem];
        [self subViewWillAppear];
    }
}

- (void)subViewWillAppear{
    
    if (self.dataSource.count > 0) {
        return;
    }
    if (self.requestType == wikiSym) {
        [self refresh];
    }else if (self.requestType == bodySym){
        [self getDataFromBodySym];
    }
}

-(void)popVCAction:(id)sender {
    [super popVCAction:sender];
    [QWGLOBALMANAGER statisticsEventId:@"x_zz_2_fh" withLable:@"症状" withParams:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.requestType == wikiSym) {
        self.title = @"症状百科";
    }
    if (iOSv7 && self.view.frame.origin.y==0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    self.dataSource = [NSMutableArray array];
    self.usualArray = [NSMutableArray array];
    self.unusualArray = [NSMutableArray array];
    self.rightIndexArray = [NSMutableArray array];
    self.LetterResultArr = [NSMutableArray array];
    [self makeTableView];
    
}


- (void)makeTableView
{
    myTableView = [[BATableView alloc] init];
    if (self.requestType == wikiSym) {
        myTableView = [[BATableView alloc]initWithFrame:CGRectMake(0, 0, APP_W, APP_H-NAV_H-35)];
    }else{
        myTableView = [[BATableView alloc]initWithFrame:CGRectMake(0, 0, APP_W, APP_H-NAV_H)];
    }
    
    myTableView.backgroundColor = RGBHex(qwColor11);
    myTableView.delegate = self;
    [self.view addSubview:myTableView];
}


#pragma mark---------------------------------------------跳转到首页-----------------------------------------------

- (void)setUpRightItem
{
    UIBarButtonItem *fixed = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixed.width = -15;
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    
    //三个点button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(5, -2, 50, 40);
    [button setImage:[UIImage imageNamed:@"icon-unfold.PNG"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(returnIndex) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:button];
    
    //数字角标
    self.numLabel = [[UILabel alloc] initWithFrame:CGRectMake(38, 1, 18, 18)];
    self.numLabel.backgroundColor = RGBHex(qwColor3);
    self.numLabel.layer.cornerRadius = 9.0;
    self.numLabel.textColor = [UIColor whiteColor];
    self.numLabel.font = [UIFont systemFontOfSize:11];
    self.numLabel.textAlignment = NSTextAlignmentCenter;
    self.numLabel.layer.masksToBounds = YES;
    self.numLabel.text = @"10";
    self.numLabel.hidden = YES;
    [rightView addSubview:self.numLabel];
    
    //小红点
    self.redLabel = [[UILabel alloc] initWithFrame:CGRectMake(43, 10, 8, 8)];
    self.redLabel.backgroundColor = RGBHex(qwColor3);
    self.redLabel.layer.cornerRadius = 4.0;
    self.redLabel.layer.masksToBounds = YES;
    self.redLabel.hidden = YES;
    [rightView addSubview:self.redLabel];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    self.navigationItem.rightBarButtonItems = @[fixed,rightItem];

    if (self.passNumber > 0)
    {
        //显示数字
        self.numLabel.hidden = NO;
        self.redLabel.hidden = YES;
        if (self.passNumber > 99) {
            self.passNumber = 99;
        }
        self.numLabel.text = [NSString stringWithFormat:@"%d",self.passNumber];
        
    }else if (self.passNumber == 0)
    {
        //显示小红点
        self.numLabel.hidden = YES;
        self.redLabel.hidden = NO;
        
    }else if (self.passNumber < 0)
    {
        //全部隐藏
        self.numLabel.hidden = YES;
        self.redLabel.hidden = YES;
    }

}
- (void)returnIndex
{
      self.indexView = [ReturnIndexView sharedManagerWithImage:@[@"ic_img_notice",@"icon home.PNG"] title:@[@"消息",@"首页"] passValue:self.passNumber];
    self.indexView.delegate = self;
    [self.indexView show];
}
- (void)RetunIndexView:(ReturnIndexView *)ReturnIndexView didSelectedIndex:(NSIndexPath *)indexPath
{
    [self.indexView hide];
    
    if (indexPath.row == 0)
    {
        if(!QWGLOBALMANAGER.loginStatus) {
            LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
            UINavigationController *navgationController = [[QWBaseNavigationController alloc] initWithRootViewController:loginViewController];
            loginViewController.isPresentType = YES;
            [self presentViewController:navgationController animated:YES completion:NULL];
            return;
        }
        
        MessageBoxListViewController *vcMsgBoxList = [[UIStoryboard storyboardWithName:@"MessageBoxListViewController" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"MessageBoxListViewController"];
        
        vcMsgBoxList.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vcMsgBoxList animated:YES];
        
    }else if (indexPath.row == 1)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
        [self performSelector:@selector(delayPopToHome) withObject:nil afterDelay:0.01];
    }

}
- (void)delayPopToHome
{
    [[QWGlobalManager sharedInstance].tabBar setSelectedIndex:0];
}
#pragma mark---------------------------------------------跳转到首页-----------------------------------------------



#pragma mark - UITableViewDataSource-------------------------------------------------------
- (NSArray *) sectionIndexTitlesForABELTableView:(BATableView *)tableView {
    return self.rightIndexArray;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.0f;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return self.rightIndexArray.count;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = self.LetterResultArr[section];
    return [array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellName = @"SymptomListCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        UIView *bkView = [[UIView alloc]initWithFrame:cell.frame];
        bkView.backgroundColor = RGBHex(qwColor10);
        cell.selectedBackgroundView = bkView;
        
        cell.selectedBackgroundView = [[UIView alloc]init];
        cell.selectedBackgroundView.backgroundColor = RGBHex(qwColor10);
    }
    cell.textLabel.frame = CGRectMake(10, cell.textLabel.frame.origin.y, cell.textLabel.frame.size.width, cell.textLabel.frame.size.height);
    cell.textLabel.text = self.LetterResultArr[indexPath.section][indexPath.row][@"name"];
    cell.textLabel.font = fontSystem(kFontS3);
    cell.textLabel.textColor = RGBHex(qwColor6);
    
    
    UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(0, 44-0.5, APP_W, 0.5)];
    [separator setBackgroundColor:RGBHex(qwColor10)];
    [cell.contentView addSubview:separator];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 28;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * v = [[UIView alloc]initWithFrame:CGRectMake(0, 0 , APP_W, 28)];
    v.backgroundColor = RGBHex(qwColor11);
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 200, 28)];
    label.font = fontSystem(kFontS5);
    label.textColor = RGBHex(qwColor8);
    if (section == 0 && self.usualArray.count > 0) {
        label.text = @"常见症状";
    }else{
        label.text = self.rightIndexArray[section];
    }
    [v addSubview:label];
    return v;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath*    selection = [myTableView.tableView indexPathForSelectedRow];
    
    if (selection) {
        [myTableView.tableView deselectRowAtIndexPath:selection animated:YES];
    }
    NSString *title = self.LetterResultArr[indexPath.section][indexPath.row][@"name"];
    NSString *symbolId = self.LetterResultArr[indexPath.section][indexPath.row][@"spmCode"];
    WebDirectViewController *vcWebDirect = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
    vcWebDirect.showConsultBtn = YES;
    
    WebSymptomDetailModel *modelSymptom = [[WebSymptomDetailModel alloc] init];
    modelSymptom.symptomId = symbolId;
    
    WebDirectLocalModel *modelLocal = [[WebDirectLocalModel alloc] init];
    modelLocal.modelSymptom = modelSymptom;
    modelLocal.typeLocalWeb = WebPageToWebTypeSympton;
    modelLocal.title = @"详情";
    [vcWebDirect setWVWithLocalModel:modelLocal];
    
    NSMutableDictionary *tdParams = [NSMutableDictionary dictionary];
    tdParams[@"点击内容"]=title;
    [QWGLOBALMANAGER statisticsEventId:@"x_zz_2" withLable:@"症状" withParams:tdParams];

    vcWebDirect.hidesBottomBarWhenPushed = YES;
    if (self.containerViewController) {
        [self.containerViewController.navigationController pushViewController:vcWebDirect animated:YES];
    }else{
        [self.navigationController pushViewController:vcWebDirect animated:YES];
    }
}

#pragma mark ---------table的代理--------------------------------------------------------------------



#pragma mark ====== 缓存------------------------------------------

//点击刚进入的时候刷新
- (void)refresh
{
    if (self.dataSource.count) {
        return;
    }
    if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
        //read缓存
        if ([QWFileManager IsFileExists:[NSString stringWithFormat:@"%@/symptomList.plist",[QWFileManager GetCachePath]]]) {
            NSDictionary *subDict = [NSDictionary dictionaryWithContentsOfFile:[NSString stringWithFormat:@"%@/symptomList.plist",[QWFileManager GetCachePath]]];
            [self httpRequestResult:subDict];
        }else
        {
            [self showInfoView:kWarning12 image:@"网络信号icon"];
            return;
        }
    } else {
        [self performSelector:@selector(getDataFromVikiSpm) withObject:nil afterDelay:0.25f];
    }
}



- (void)getDataFromBodySym
{
    
    SpmListByBodyModelR *model = [SpmListByBodyModelR new];
    model.currPage = @"1";
    model.pageSize = @"0";
    model.bodyCode = self.requsetDic[@"bodyCode"];
    model.population = self.requsetDic[@"population"];
    model.position = self.requsetDic[@"position"];
    model.sex = self.requsetDic[@"sex"];
    if (self.spmCode.length > 0) {
        model.bodyCode = self.spmCode;
    }
    
    NSString *bodySome=[NSString stringWithFormat:@"%@_%@_%@_%@",model.bodyCode,model.population,model.position,model.sex];
    NSString * where = [NSString stringWithFormat:@"detailSpm = '%@'",bodySome];
    NSArray *arrObj=[SpmListModel getArrayFromDBWithWhere:where];
    
    if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
       
        if(arrObj.count>0){
            [self httpRequestResult:arrObj];
        }else{
            [self showInfoView:kWarning12 image:@"网络信号icon"];
            return;
        }
    }else{
        
        if(arrObj.count>0){
            //实时刷新  先读缓存
            [self httpRequestResult:arrObj];
            [SpmApi QuerySpmInfoListByBodyWithParams:model success:^(id obj) {
                //加入缓存
                SpmListByBodyPage *model=[SpmListByBodyPage parse:obj Elements:[SpmListModel class] forAttribute:@"list"];
                for(SpmListModel* mod in model.list){
                    mod.detailSpm = bodySome;
                    mod.spmCodeSpm=[NSString stringWithFormat:@"%@_%@",mod.spmCode,mod.detailSpm];
                    [SpmListModel updateObjToDB:mod WithKey:mod.spmCodeSpm];
                }
                
                
            } failure:^(HttpException *e) {
                if(e.errorCode!=-999){
                    if(e.errorCode == -1001){
                        [self showInfoView:kWarning215N26 image:@"ic_img_fail"];
                    }else{
                        [self showInfoView:kWarning39 image:@"ic_img_fail"];
                    }
                    
                }
                return;
            }];
        }else{
            [SpmApi QuerySpmInfoListByBodyWithParams:model success:^(id obj) {
                [self httpRequestResult:obj];
                //加入缓存
                SpmListByBodyPage *model=[SpmListByBodyPage parse:obj Elements:[SpmListModel class] forAttribute:@"list"];
                for(SpmListModel* mod in model.list){
                    mod.detailSpm = bodySome;
                    mod.spmCodeSpm=[NSString stringWithFormat:@"%@_%@",mod.spmCode,mod.detailSpm];
                    [SpmListModel updateObjToDB:mod WithKey:mod.spmCodeSpm];
                }
                
                
            } failure:^(HttpException *e) {
                if(e.errorCode!=-999){
                    if(e.errorCode == -1001){
                        [self showInfoView:kWarning215N26 image:@"ic_img_fail"];
                    }else{
                        [self showInfoView:kWarning39 image:@"ic_img_fail"];
                    }
                    
                }
                return;
            }];
        
        }
        
        
        
        
    }
    
    
}




//加载数据
- (void)getDataFromVikiSpm
{
    SpmListModelR *model = [SpmListModelR new];
    model.currPage = @"1";
    model.pageSize = @"0";
    
    [SpmApi QuerySpmInfoListWithParams:model success:^(id obj) {
        [self httpRequestResult:obj];
        //缓存数据
        NSDictionary *subDict = obj;
        [QWFileManager WriteFileDictionary:subDict SpecifiedFile:[NSString stringWithFormat:@"%@/symptomList.plist",[QWFileManager GetCachePath]]];
        
    } failure:^(HttpException *e) {
        if(e.errorCode!=-999){
            if(e.errorCode == -1001){
                [self showInfoView:kWarning215N26 image:@"ic_img_fail"];
            }else{
                [self showInfoView:kWarning39 image:@"ic_img_fail"];
            }
            
        }
        return;
        
    }];
    
}



- (void)httpRequestResult:(id)resultObj
{
    if([resultObj isKindOfClass:[NSArray class]]){
        NSMutableArray *ayy=[NSMutableArray array];
        for(SpmListModel* mod in resultObj){
            [ayy addObject:[mod dictionaryModel]];
        }
        self.dataSource = ayy;
    }else{
        self.dataSource = resultObj[@"list"];
    }
    
    if (self.dataSource.count == 0) {
        [self showInfoView:kWarning35 image:@"无可能疾病icon.png"];
        
        return;
    }
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        for (NSDictionary * dic in self.dataSource) {
            if ([[dic objectForKey:@"usual"] intValue] == 1) {
                [self.usualArray addObject:dic];//常见
            }
            else{
                [self.unusualArray addObject:dic];//不常见
            }
        }
        
        NSArray * letters = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
        
        if (self.usualArray.count > 0) {
            //对常见症状进行排序
            NSMutableArray *changArr = [NSMutableArray arrayWithArray:self.usualArray];
            NSMutableArray *uArr = [NSMutableArray array];
            NSArray *arr = [NSArray arrayWithArray:self.usualArray];
            [self.usualArray removeAllObjects];
            //遍历字母
            for (int i = 0; i<letters.count; i++) {
                //根据字母 遍历所有dic
                for (int j = 0 ; j<arr.count; j++) {
                    NSDictionary *dic = arr[j];
                    if ([dic[@"liter"] isEqualToString:letters[i]]) {
                        [uArr addObject:dic];
                        [changArr removeObject:dic];
                    }else
                        continue;
                }
            }
            
            [self.usualArray removeAllObjects];
            [self.usualArray addObjectsFromArray:uArr];
            [self.usualArray addObjectsFromArray:changArr];
            
            [self.rightIndexArray insertObject:@"常" atIndex:0];
            [self.LetterResultArr insertObject:self.usualArray atIndex:0];
        }
        
        NSMutableArray * currArray = [[NSMutableArray alloc]initWithArray:self.unusualArray];
        for (int i=0; i<letters.count; i++) {
            NSMutableArray * arr = [NSMutableArray array];//存放当前字母所对应dic的数组
            for (int j = 0; j < self.unusualArray.count; j++) {
                NSDictionary * dic = self.unusualArray[j];//当前的字典
                if ([dic[@"liter"] isEqualToString:letters[i]]) {
                    [arr addObject:dic];
                    [currArray removeObject:dic];
                }else
                    continue;
            }
            //遍历完一次之后
            if (arr.count > 0) {
                [self.rightIndexArray addObject:letters[i]];
                [self.LetterResultArr addObject:arr];
            }
        }
        
        if (currArray.count > 0) {
            [self.rightIndexArray addObject:@"#"];
            [self.LetterResultArr addObject:currArray];
        }
        
        
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [myTableView reloadData];
        });
    });
    
    
}


#pragma mark --------------------------------------------------------------------------------

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (self.scrollBlock) {
        self.scrollBlock();
    }
}

- (void)getNotifType:(Enum_Notification_Type)type data:(id)data target:(id)obj{
    if (NotiWhetherHaveNewMessage == type) {
        
        NSString *str = data;
        self.passNumber = [str integerValue];
        self.indexView.passValue = self.passNumber;
        [self.indexView.tableView reloadData];
        if (self.passNumber > 0)
        {
            //显示数字
            self.numLabel.hidden = NO;
            self.redLabel.hidden = YES;
            if (self.passNumber > 99) {
                self.passNumber = 99;
            }
            self.numLabel.text = [NSString stringWithFormat:@"%d",self.passNumber];
            
        }else if (self.passNumber == 0)
        {
            //显示小红点
            self.numLabel.hidden = YES;
            self.redLabel.hidden = NO;
            
        }else if (self.passNumber < 0)
        {
            //全部隐藏
            self.numLabel.hidden = YES;
            self.redLabel.hidden = YES;
        }
    }
}



@end
