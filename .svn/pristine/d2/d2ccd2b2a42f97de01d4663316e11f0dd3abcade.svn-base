//
//  HealthInfoRecommendViewController.m
//  APP
//
//  Created by PerryChen on 11/9/15.
//  Copyright © 2015 carret. All rights reserved.
//

#import "HealthInfoRecommendViewController.h"
#import "InformationTableViewCell.h"
#import "SVProgressHUD.h"
#import "Healthinfo.h"
#import "WebDirectViewController.h"
#import "WebDirectModel.h"
#import "HealthModel.h"

@interface HealthAdviceSubInfo : BaseModel
@property (nonatomic, strong) NSString *titleTopicOne;
@property (nonatomic, strong) NSString *titleTopicTwo;
@property (nonatomic, strong) NSString *titleTopicThree;
@property (nonatomic, strong) TemplatePosVoModel *modelAreaOne;
@property (nonatomic, strong) TemplatePosVoModel *modelAreaTwo;
@property (nonatomic, strong) TemplatePosVoModel *modelAreaThree;
@property (nonatomic, strong) NSString *titleSectionOne;      //专区标题
@property (nonatomic, strong) NSString *titleSectionTwo;
@property (nonatomic, strong) NSString *titleSectionThree;
@property (nonatomic, strong) NSString *titleSectionFour;


@property (nonatomic, strong) NSString *strTopicSpecial;  //特刊URL
@property (nonatomic, strong) NSString *strTopicDetail;     //专题详情URL
@property (nonatomic, strong) NSString *strTopicList;       //专题列表URL

@property (nonatomic, strong) NSString *strSectionOne;      //专区URL
@property (nonatomic, strong) NSString *strSectionTwo;
@property (nonatomic, strong) NSString *strSectionThree;
@property (nonatomic, strong) NSString *strSectionFour;

@property (nonatomic, assign) BOOL isFillUpDistrict;        //有专区数据
@property (nonatomic, assign) BOOL isFillUpArea;            //有专题数据

@property (nonatomic, assign) BOOL isFilledUp;      // 判断是否全部完成了

@end

@implementation HealthAdviceSubInfo

@end

@interface HealthInfoRecommendViewController ()<UITableViewDataSource, UITableViewDelegate, WebDirectBackDelegate>
{
    dispatch_group_t groupServiceArea;
}

@property (strong, nonatomic) IBOutlet UIView *viewHeader;


@property (weak, nonatomic) IBOutlet UIImageView *imgViewTopicOne;  // 特刊
@property (weak, nonatomic) IBOutlet UIImageView *imgViewTopicDetail;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewTopicList;

@property (weak, nonatomic) IBOutlet UIImageView *imgViewSectionOne;
@property (weak, nonatomic) IBOutlet UILabel *lblSectionOne;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewSectionTwo;
@property (weak, nonatomic) IBOutlet UILabel *lblSectionTwo;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewSectionThree;
@property (weak, nonatomic) IBOutlet UILabel *lblSectionThree;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewSectionFour;
@property (weak, nonatomic) IBOutlet UILabel *lblSectionFour;



@property (nonatomic, assign) BOOL loadFromLocal;

@property (nonatomic, strong) NSMutableArray *arrList;

@property (nonatomic, assign) NSInteger curPage;

@property (nonatomic, assign) NSInteger numOfLoad;

@property (nonatomic, assign) CGFloat floatHeightHeader;

@property (nonatomic, assign) BOOL needRefresh;
@property (nonatomic, strong) SubjectOrDisvionAreaVO *modelArea;

@property (nonatomic, strong) HealthAdviceSubInfo *modelSubInfo;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consHeadHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consFootHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consHeadOneHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consHeadTwoHeight;

@property (nonatomic, assign) NSInteger loadAllAreasNum;

- (IBAction)action_topicOne:(id)sender;
- (IBAction)action_topicDetail:(UIButton *)sender;
- (IBAction)action_topicList:(UIButton *)sender;


- (IBAction)action_SectionOne:(id)sender;
- (IBAction)action_SectionTwo:(id)sender;
- (IBAction)action_SectionThree:(id)sender;
- (IBAction)action_SectionFour:(id)sender;



@end

@implementation HealthInfoRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.curPage = 1;
    self.numOfLoad = 0;
    self.strAdviceID = @"";
    self.needRefresh = YES;
    self.selectedIndex = -1;
    self.arrList = [@[] mutableCopy];

    self.modelSubInfo = [HealthAdviceSubInfo new];
    //上拉刷新
    __weak HealthInfoRecommendViewController *weakSelf = self;
    [self.tableMain addStaticImageHeader];
    [self.tableMain addFooterWithCallback:^{
        weakSelf.curPage++;
        if (QWGLOBALMANAGER.currentNetWork != kNotReachable) {
            
            HttpClientMgr.progressEnabled=NO;
            
        } else {
            [SVProgressHUD showErrorWithStatus:kWarningN2 duration:0.8f];
            [weakSelf.tableMain footerEndRefreshing];
        }
        [weakSelf getHealthyAdviceList];
    }];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ((self.strAdviceID.length > 0)&&(self.selectedIndex >= 0)) {
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"adviceId"] = self.strAdviceID;
        [Healthinfo getHealthAdviceCountWithParams:param success:^(id obj) {
            
            HealthInfoReadCountModel *modelCount = (HealthInfoReadCountModel *)obj;
            HealthinfoAdvicel *advicel = self.arrList[self.selectedIndex];
            advicel.readNum = [NSString stringWithFormat:@"%@",modelCount.readCount];
            advicel.pariseNum = [NSString stringWithFormat:@"%@",modelCount.pariseCount];
            [self.tableMain reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.selectedIndex inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
            
        } failure:^(HttpException *e) {
            
        }];
    }
}

// 更新数据
- (void) refresh
{
    self.loadAllAreasNum = 0;
    if (self.needRefresh) {
        self.strAdviceID = @"";
        [self performSelector:@selector(subRefresh) withObject:nil afterDelay:0.5f];
    }
    self.needRefresh = YES;
}

- (void)subRefresh{
    self.tableMain.hidden = NO;
    self.tableMain.footer.canLoadMore = YES;
    [self removeInfoView];
    if (QWGLOBALMANAGER.currentNetWork == NotReachable) {
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"channelId"] = self.channelInfo.channelId;
        param[@"currPage"] = [NSString stringWithFormat:@"%ld",(long)self.curPage];
        param[@"pageSize"] = @"10";
        NSString * key = [NSString stringWithFormat:@"%@_%@",param[@"channelId"],param[@"currPage"]];
        HealthinfoAdvicelPage* page = [HealthinfoAdvicelPage getObjFromDBWithKey:key];
        if (page) {
            if (self.curPage == 1)
            {
                [self.arrList removeAllObjects];
            }
            for(id obj in page.list) {
                [self.arrList addObject:obj];
            }
            [self.tableMain reloadData];
            [self.tableMain footerEndRefreshing];
        } else {
            [self showInfoView:kWarningN2 image:@"网络信号icon"];
        }
        
        return;
    } else {
        [self removeInfoView];
        self.curPage = 1;
        self.numOfLoad = 0;
        [self getHealthyAdviceList];
        // 请求专题专区的service的group
        groupServiceArea = dispatch_group_create();
        __weak typeof(self) wSelf = self;
        [self queryForumArea];
        [self queryDistrictArea];
        dispatch_group_notify(groupServiceArea, dispatch_get_main_queue(), ^{
            [wSelf setupDistrictAndAreaData];
        });
        
//        [self getHealthAdviceSubject];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark 数据请求
- (void)queryDistrictArea
{
    __weak typeof(self) wSelf = self;
    dispatch_group_enter(groupServiceArea);
    
    [Healthinfo queryDivisionAreaWithParams:[NSDictionary dictionary] success:^(id model) {
        DivisionAreaVoList *listModel = (DivisionAreaVoList *)model;
        
//        if (listModel.list.count < 4) {
//            dispatch_group_leave(groupServiceArea);
////            [wSelf setupDistrictAndAreaData];
//            return;
//        }
        DDLogVerbose(@"the list model is %@",listModel);
        NSInteger intMin = MIN(4, listModel.list.count);
        for (int i = 0; i < intMin; i++) {
            
            DivisionAreaVo *modelVO = listModel.list[i];

            NSString *strContentURL = @"";
            if ([modelVO.url hasPrefix:@"http"]) {
                
                strContentURL = modelVO.url;
            } else {
                strContentURL = [NSString stringWithFormat:@"%@%@",BASE_URL_V2,modelVO.url];
            }
            if (i == 0) {
                [wSelf.imgViewSectionOne setImageWithURL:[NSURL URLWithString:modelVO.imgUrl] placeholderImage:[UIImage imageNamed:@"icon_health_disease"]];
                wSelf.lblSectionOne.text = modelVO.title;
                wSelf.modelSubInfo.strSectionOne = strContentURL;
                wSelf.modelSubInfo.titleSectionOne = modelVO.title;
            } else if (i == 1) {
                [wSelf.imgViewSectionTwo setImageWithURL:[NSURL URLWithString:modelVO.imgUrl]placeholderImage:[UIImage imageNamed:@"icon_health_sex"]];
                wSelf.lblSectionTwo.text = modelVO.title;
                wSelf.modelSubInfo.strSectionTwo = strContentURL;
                wSelf.modelSubInfo.titleSectionTwo = modelVO.title;
            } else if (i == 2) {
                [wSelf.imgViewSectionThree setImageWithURL:[NSURL URLWithString:modelVO.imgUrl]placeholderImage:[UIImage imageNamed:@"icon_health_older"]];
                wSelf.lblSectionThree.text = modelVO.title;
                wSelf.modelSubInfo.strSectionThree = strContentURL;
                wSelf.modelSubInfo.titleSectionThree = modelVO.title;
            } else {
                [wSelf.imgViewSectionFour setImageWithURL:[NSURL URLWithString:modelVO.imgUrl]placeholderImage:[UIImage imageNamed:@"icon_health_tonic"]];
                wSelf.lblSectionFour.text = modelVO.title;
                wSelf.modelSubInfo.strSectionFour = strContentURL;
                wSelf.modelSubInfo.titleSectionFour = modelVO.title;
            }
        }
        wSelf.modelSubInfo.isFillUpDistrict = YES;
        dispatch_group_leave(groupServiceArea);
    } failure:^(HttpException *e) {
        dispatch_group_leave(groupServiceArea);
    }];
}

//获取专题接口
- (void)queryForumArea
{
    dispatch_group_enter(groupServiceArea);
    __weak typeof(self) wSelf = self;
    ConfigInfoQueryTemplateModelR *apiModelR = [ConfigInfoQueryTemplateModelR new];
    apiModelR.pos = 2;
//    [self.tableMain reloadData];
//    self.tableMain.tableHeaderView = wSelf.viewHeader;
    [ConfigInfo queryTemplete:apiModelR success:^(TemplateListVoModel *responModel) {
        if([responModel.apiStatus integerValue] == 0) {
            if (responModel.templates.count > 0) {
                TemplateVoModel *areaModel = responModel.templates[0];
                if ([areaModel.type intValue] == 1) {       // 模板1-2
                    for (int i = 0; i < areaModel.pos.count; i++) {
                        TemplatePosVoModel *model = areaModel.pos[i];
                        
                        if (i == 0) {
                            wSelf.modelSubInfo.modelAreaOne = model;
//                            [wSelf.imgViewTopicOne setImageWithURL:[NSURL URLWithString:model.imgUrl]];
                            [wSelf.imgViewTopicOne setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                                CGFloat height = (APP_W / 2) / image.size.width * image.size.height;
                                wSelf.consHeadHeight.constant = height;
                                wSelf.floatHeightHeader = height;
                                wSelf.viewHeader.frame = CGRectMake(0, 0, self.tableMain.frame.size.width, height+114.0f);
                                wSelf.tableMain.tableHeaderView = wSelf.viewHeader;
                            }];
                        } else if (i == 1) {
                            wSelf.modelSubInfo.modelAreaTwo = model;
                            [wSelf.imgViewTopicDetail setImageWithURL:[NSURL URLWithString:model.imgUrl]];
                        } else if (i == 2) {
                            wSelf.modelSubInfo.modelAreaThree = model;
                            [wSelf.imgViewTopicList setImageWithURL:[NSURL URLWithString:model.imgUrl]];
                        }
//                        if (model.special == YES) {     //特刊
//                            
//                            wSelf.modelSubInfo.strTopicSpecial = model.forwordUrl;
//                            wSelf.modelSubInfo.titleTopicSpecial = model.title;
//                        } else if (model.cls == 4) {    // 某个专题详情
//                            
//                            wSelf.modelSubInfo.strTopicDetail = model.forwordUrl;
//                            wSelf.modelSubInfo.titleTopicDetail = model.title;
//                        } else {        //更多专题
//                            
//                            wSelf.modelSubInfo.strTopicList = model.forwordUrl;
//                            wSelf.modelSubInfo.titleTopicList = model.title;
//                        }
                    }
                    wSelf.modelSubInfo.isFillUpArea = YES;
//                    [wSelf setupDistrictAndAreaData];
                }
            }
        }
        dispatch_group_leave(groupServiceArea);
//        [wSelf setupDistrictAndAreaData];
    } failure:^(HttpException *e) {
//        [wSelf setupDistrictAndAreaData];
        dispatch_group_leave(groupServiceArea);
    }];
}


- (void)setupDistrictAndAreaData
{
    [self setupTheHeadView];
    if (self.modelSubInfo.isFillUpDistrict && self.modelSubInfo.isFillUpArea) {
        // 数据全部获取到了
//        self.consHeadOneHeight.constant = 63.0f;
//        self.consHeadTwoHeight.constant = 63.0f;
        
//        [self.viewHeader setNeedsLayout];
//        [self.viewHeader layoutIfNeeded];
        
//        self.consHeadHeight.constant = 126.0f;
//        self.viewHeader.frame = CGRectMake(0, 0, self.tableMain.frame.size.width, 240.0f);
        self.consHeadHeight.constant = (self.floatHeightHeader > 0) ? self.floatHeightHeader : 126.0f;
        self.viewHeader.frame = CGRectMake(0, 0, self.tableMain.frame.size.width, 114.0f+self.floatHeightHeader);
    } else if (!self.modelSubInfo.isFillUpArea) {
        // 没有专题则不显示专题模块
//        self.consHeadOneHeight.constant = 0;
//        self.consHeadTwoHeight.constant = 0;
        self.consHeadHeight.constant = 0;
        self.viewHeader.frame = CGRectMake(0, 0, self.tableMain.frame.size.width, 106.0f);
    }
    self.tableMain.tableHeaderView = self.viewHeader;
}

- (void)setupTheHeadView
{
    self.lblSectionOne.font = self.lblSectionTwo.font = self.lblSectionThree.font = self.lblSectionFour.font = fontSystem(kFontS5);
    self.lblSectionOne.textColor = self.lblSectionTwo.textColor = self.lblSectionThree.textColor = self.lblSectionFour.textColor = RGBHex(qwColor7);
}

//上拉刷新，每次取10条数据
- (void)getHealthyAdviceList
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"channelId"] = self.channelInfo.channelId;
    param[@"currPage"] = [NSString stringWithFormat:@"%ld",(long)self.curPage];
    param[@"pageSize"] = @"10";
    
    NSString * key = [NSString stringWithFormat:@"%@_%@",param[@"channelId"],param[@"currPage"]];
    
    if ((self.curPage == 1)&&(QWGLOBALMANAGER.currentNetWork != NotReachable)) {
        [HealthinfoAdvicelPage deleteObjFromDBWithKey:key];
    }
    HealthinfoAdvicelPage* page = [HealthinfoAdvicelPage getObjFromDBWithKey:key];
    //    self.tableMain.footer.canLoadMore=[self checkTotal:page.totalRecords.integerValue pageSize:page.pageSize.integerValue pageNum:page.page.integerValue];
    if (QWGLOBALMANAGER.currentNetWork != NotReachable) {
        [self removeInfoView];
        __weak HealthInfoRecommendViewController *weakSelf = self;
        self.numOfLoad ++;
        [Healthinfo QueryHealthAdviceListWithParams:param
                                            success:^(id obj){
                                                self.numOfLoad--;

                                                if (obj) {
                                                    HealthinfoAdvicelPage* page = obj;
                                                    
                                                    page.advicePageId = key;
                                                    [HealthinfoAdvicelPage saveObjToDB:page];
                                                    HealthinfoAdvicelPage* curpage = [HealthinfoAdvicelPage getObjFromDBWithKey:key];
                                                    if (weakSelf.curPage == 1)
                                                    {
                                                        [self.arrList removeAllObjects];
                                                    }
                                                    if (page.list.count == 0) {
                                                        self.tableMain.footer.canLoadMore = NO;
                                                    } else {
                                                        for(id obj in page.list) {
                                                            [weakSelf.arrList addObject:obj];
                                                        }
                                                    }
                                                    [self.tableMain reloadData];
                                                    [self.tableMain footerEndRefreshing];
                                                }
                                            }
                                            failure:^(HttpException *e){
                                                self.numOfLoad--;
                                                if (self.arrList.count == 0) {
                                                    [self showInfoView:kWarning39 image:@"ic_img_fail"];
                                                }
                                                [self.tableMain footerEndRefreshing];
                                            }];
        
    } else {
        if (page) {
            
            if (self.curPage == 1)
            {
                [self.arrList removeAllObjects];
            }
            if (page.list.count == 0) {
                self.tableMain.footer.canLoadMore = NO;
            } else {
                for(id obj in page.list) {
                    [self.arrList addObject:obj];
                }
            }
            [self.tableMain reloadData];
            [self.tableMain footerEndRefreshing];
        }
        else
        {
        }
    }
}

- (void)viewInfoClickAction:(id)sender
{
    if (QWGLOBALMANAGER.currentNetWork != kNotReachable) {
        [self removeInfoView];
        self.numOfLoad = 0;
        [self getHealthyAdviceList];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITableView methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *InformationTableViewCellCellIdentifier = @"InformationTableViewCellCellIdentifier";
    InformationTableViewCell *cell = (InformationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:InformationTableViewCellCellIdentifier];
    if(cell == nil)
    {
        UINib *nib = [UINib nibWithNibName:@"InformationTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:InformationTableViewCellCellIdentifier];
        cell = (InformationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:InformationTableViewCellCellIdentifier];
        
    }
    if (self.arrList.count > 0) {
        HealthinfoAdvicel *mod = self.arrList[indexPath.row];
        
        [cell setCell:mod];
        [cell.introduction setLabelValue:[QWGLOBALMANAGER replaceSpecialStringWith:mod.introduction]];
        [cell.iconUrl setImageWithURL:[NSURL URLWithString:mod.iconUrl] placeholderImage:[UIImage imageNamed:@"药品默认图片"]];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 81.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)tableView:(UITableView *)atableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [atableView deselectRowAtIndexPath:indexPath animated:NO];

    self.selectedIndex = indexPath.row;
    self.needRefresh = NO;

    if (self.arrList.count > 0) {
        HealthinfoAdvicel *advicel = self.arrList[indexPath.row];
        self.strAdviceID = advicel.adviceId;
        //渠道统计
        ChannerTypeModel *modelre=[ChannerTypeModel new];
        modelre.objRemark=advicel.title;
        modelre.objId=advicel.adviceId;
        modelre.cKey=@"e_tab_zx";
        [QWGLOBALMANAGER qwChannel:modelre];
        
        WebDirectViewController *vcWebDirect = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
        
        WebHealthInfoModel *modelHealth = [[WebHealthInfoModel alloc] init];
        modelHealth.msgID = advicel.adviceId;
        
        WebDirectLocalModel *modelLocal = [[WebDirectLocalModel alloc] init];
//        modelLocal.modelHealInfo = modelHealth;
        modelLocal.typeLocalWeb = WebPageToWebTypeInfo;
        [vcWebDirect setWVWithLocalModel:modelLocal];
        
        vcWebDirect.callBackDelegate = self;
        vcWebDirect.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vcWebDirect animated:YES];

    }
}

#pragma mark - Delgate of the Health Information ViewCotroller
- (void)needUpdateList:(BOOL)needUp
{
    if (needUp) {
        [self.tableMain reloadData];
    }
}

- (void)needUpdateInfoList:(BOOL)needUp
{
    if (needUp) {
        [self.tableMain reloadData];
    }
}

- (void)pushIntoWebViewControllerWithURL:(NSString *)url cls:(NSString *)cls isSpecial:(NSString *)isSpecial title:(NSString *)strTitle canShare:(BOOL)canShare
{
    WebDirectViewController *vcWebDirect = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
    WebDirectLocalModel *modelLocal = [WebDirectLocalModel new];
    modelLocal.title = strTitle;
    
    if ([isSpecial isEqualToString:@"Y"]) {
        vcWebDirect.isSpecial = YES;
    }
    if (([cls intValue] == 1) || ([cls intValue] == 2)) {       // 1 慢病  2 专题列表
        if ([url hasPrefix:@"http"]) {
            modelLocal.url = url;
        } else {
            modelLocal.url = @"";
            modelLocal.strParams = url;
        }
        if ([cls intValue] == 1) {
            // 慢病专区
            modelLocal.typeLocalWeb = WebLocalTypeSlowDiseaseArea;
        } else if ([cls intValue] == 2) {
            // 专题列表
            modelLocal.typeLocalWeb = WebLocalTypeTopicList;
            
        }
        [vcWebDirect setWVWithLocalModel:modelLocal];
    } else if (([cls intValue] == 3)||([cls intValue] == 4)){
        if ([url hasPrefix:@"http"]) {
            modelLocal.url = url;
        } else {
            modelLocal.url = @"";
            modelLocal.strParams = url;
        }
        if ([cls intValue] == 3) {
            //专区
            modelLocal.typeLocalWeb = WebLocalTypeDivision;
            [vcWebDirect setWVWithLocalModel:modelLocal];
            
        } else if ([cls intValue] == 4) {
            // 某个专题详情
            modelLocal.typeLocalWeb = WebPageToWebTypeTopicDetail;
            [vcWebDirect setWVWithLocalModel:modelLocal];
        }
    } else {
        NSString *strUrl = @"";
        if (![url hasPrefix:@"http"]) {
            url = [NSString stringWithFormat:@"%@%@",H5_BASE_URL,url];
        }
        strUrl = [NSString stringWithFormat:@"%@",url];
        modelLocal.url = strUrl;
        modelLocal.typeLocalWeb = WebLocalTypeOuterLink;
        vcWebDirect.isOtherLinks = YES;
        modelLocal.title = @"";
        [vcWebDirect setWVWithLocalModel:modelLocal];
    }
    
    __weak typeof(self) weakSelf = self;
    vcWebDirect.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vcWebDirect animated:YES];
}

- (IBAction)action_topicOne:(id)sender {        //特刊
    if (!self.modelSubInfo.isFillUpArea) {
        return;
    }
    [self pushIntoWebViewControllerWithURL:self.modelSubInfo.modelAreaOne.forwordUrl  cls:[NSString stringWithFormat:@"%d",self.modelSubInfo.modelAreaOne.cls] isSpecial:[NSString stringWithFormat:@"%d",self.modelSubInfo.modelAreaOne.special] title:self.modelSubInfo.modelAreaOne.title canShare:YES];
}

- (IBAction)action_topicDetail:(UIButton *)sender {
    if (!self.modelSubInfo.isFillUpArea) {
        return;
    }
    [self pushIntoWebViewControllerWithURL:self.modelSubInfo.modelAreaTwo.forwordUrl  cls:[NSString stringWithFormat:@"%d",self.modelSubInfo.modelAreaTwo.cls] isSpecial:[NSString stringWithFormat:@"%d",self.modelSubInfo.modelAreaTwo.special] title:self.modelSubInfo.modelAreaTwo.title canShare:YES];
}

- (IBAction)action_topicList:(UIButton *)sender {
    if (!self.modelSubInfo.isFillUpArea) {
        return;
    }
    [self pushIntoWebViewControllerWithURL:self.modelSubInfo.modelAreaThree.forwordUrl  cls:[NSString stringWithFormat:@"%d",self.modelSubInfo.modelAreaThree.cls] isSpecial:[NSString stringWithFormat:@"%d",self.modelSubInfo.modelAreaThree.special] title:self.modelSubInfo.modelAreaThree.title canShare:YES];
}

- (IBAction)action_SectionOne:(id)sender {
    
    if (!self.modelSubInfo.isFillUpDistrict) {
        return;
    }
    if (self.modelSubInfo.strSectionOne.length <= 0) {
        return;
    }
    self.needRefresh = NO;
    WebDirectViewController *vcWebDirect = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
    vcWebDirect.zhuanQuId = 1;
    WebDirectLocalModel *modelLocal = [WebDirectLocalModel new];
    if ([self.lblSectionOne.text isEqualToString:@"慢病专区"]) {
        modelLocal.typeLocalWeb = WebLocalTypeSlowDiseaseArea;
    } else {
        modelLocal.typeLocalWeb = WebLocalTypeDivision;
    }
    modelLocal.url = self.modelSubInfo.strSectionOne;
    modelLocal.title = self.modelSubInfo.titleSectionOne;
    vcWebDirect.isSpecial = NO;
    __weak typeof(self) weakSelf = self;
    [vcWebDirect setWVWithLocalModel:modelLocal];
    vcWebDirect.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:vcWebDirect animated:YES];
}

- (IBAction)action_SectionTwo:(id)sender {
    if (!self.modelSubInfo.isFillUpDistrict) {
        return;
    }
    
    if (self.modelSubInfo.strSectionTwo.length <= 0) {
        return;
    }
    self.needRefresh = NO;
    WebDirectViewController *vcWebDirect = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
    vcWebDirect.zhuanQuId = 2;
    WebDirectLocalModel *modelLocal = [WebDirectLocalModel new];
    if ([self.lblSectionTwo.text isEqualToString:@"慢病专区"]) {
        modelLocal.typeLocalWeb = WebLocalTypeSlowDiseaseArea;
    } else {
        modelLocal.typeLocalWeb = WebLocalTypeDivision;
    }
    modelLocal.url = self.modelSubInfo.strSectionTwo;
    modelLocal.title = self.modelSubInfo.titleSectionTwo;
    vcWebDirect.isSpecial = NO;
    __weak typeof(self) weakSelf = self;
    [vcWebDirect setWVWithLocalModel:modelLocal];
    vcWebDirect.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vcWebDirect animated:YES];
}

- (IBAction)action_SectionThree:(id)sender {
    if (!self.modelSubInfo.isFillUpDistrict) {
        return;
    }
    if (self.modelSubInfo.strSectionThree.length <= 0) {
        return;
    }
    self.needRefresh = NO;
    //    NSString *strEventID = [NSString stringWithFormat:@"e_index_zt_%@",cls];
    //    [QWGLOBALMANAGER statisticsEventId:strEventID];
    WebDirectViewController *vcWebDirect = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
    vcWebDirect.zhuanQuId = 3;
    WebDirectLocalModel *modelLocal = [WebDirectLocalModel new];
    if ([self.lblSectionThree.text isEqualToString:@"慢病专区"]) {
        modelLocal.typeLocalWeb = WebLocalTypeSlowDiseaseArea;
    } else {
        modelLocal.typeLocalWeb = WebLocalTypeDivision;
    }
    modelLocal.url = self.modelSubInfo.strSectionThree;
    modelLocal.title = self.modelSubInfo.titleSectionThree;
    vcWebDirect.isSpecial = NO;
    __weak typeof(self) weakSelf = self;
    [vcWebDirect setWVWithLocalModel:modelLocal];
    vcWebDirect.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vcWebDirect animated:YES];
}

- (IBAction)action_SectionFour:(id)sender {
    if (!self.modelSubInfo.isFillUpDistrict) {
        return;
    }
    if (self.modelSubInfo.strSectionFour.length <= 0) {
        return;
    }
    self.needRefresh = NO;
    WebDirectViewController *vcWebDirect = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
    vcWebDirect.zhuanQuId = 4;
    WebDirectLocalModel *modelLocal = [WebDirectLocalModel new];
    if ([self.lblSectionFour.text isEqualToString:@"慢病专区"]) {
        modelLocal.typeLocalWeb = WebLocalTypeSlowDiseaseArea;
    } else {
        modelLocal.typeLocalWeb = WebLocalTypeDivision;
    }
    modelLocal.url = self.modelSubInfo.strSectionFour;
    modelLocal.title = self.modelSubInfo.titleSectionFour;
    vcWebDirect.isSpecial = NO;
    __weak typeof(self) weakSelf = self;
    [vcWebDirect setWVWithLocalModel:modelLocal];
    vcWebDirect.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vcWebDirect animated:YES];
}

// 获取专题等（弃用）
/*
- (void)getHealthAdviceSubject
{
    __weak typeof(self) wSelf = self;
    [Healthinfo getHealthAdviceSubjectWithParams:[NSDictionary dictionary] success:^(id model) {
        wSelf.modelArea = (SubjectOrDisvionAreaVO *)model;
        if (wSelf.modelArea.channelSubjectsVO.count <= 2) {
            return ;
        }
        //设置专题
        for (ChannelSubjectsVO *channelModel in wSelf.modelArea.channelSubjectsVO) {
            if ([channelModel.type intValue] == 3) {
                // 特刊
                [wSelf.imgViewTopicOne setImageWithURL:[NSURL URLWithString:channelModel.imgUrl]];
                wSelf.modelSubInfo.strTopicSpecial = channelModel.contentUrl;
                wSelf.modelSubInfo.titleTopicSpecial = channelModel.title;
            } else if ([channelModel.type intValue] == 1) {
                // 专题详情
                [wSelf.imgViewTopicDetail setImageWithURL:[NSURL URLWithString:channelModel.imgUrl]];
                wSelf.modelSubInfo.strTopicDetail = channelModel.contentUrl;
                wSelf.modelSubInfo.titleTopicDetail = channelModel.title;
            } else if ([channelModel.type intValue] == 4) {
                // 专题列表
                [wSelf.imgViewTopicList setImageWithURL:[NSURL URLWithString:channelModel.imgUrl]];
                wSelf.modelSubInfo.strTopicList = channelModel.contentUrl;
                wSelf.modelSubInfo.titleTopicList = channelModel.title;
            }
        }
        for (int i = 0; i < 4; i++) {
            DisvionVO *modelVO = wSelf.modelArea.disvionVO[i];
            if (i == 0) {
                [wSelf.imgViewSectionOne setImageWithURL:[NSURL URLWithString:modelVO.imgUrl] placeholderImage:[UIImage imageNamed:@"icon_health_disease"]];
                wSelf.lblSectionOne.text = modelVO.title;
                wSelf.modelSubInfo.strSectionOne = modelVO.contentUrl;
                wSelf.modelSubInfo.titleSectionOne = modelVO.title;
            } else if (i == 1) {
                [wSelf.imgViewSectionTwo setImageWithURL:[NSURL URLWithString:modelVO.imgUrl]placeholderImage:[UIImage imageNamed:@"icon_health_sex"]];
                wSelf.lblSectionTwo.text = modelVO.title;
                wSelf.modelSubInfo.strSectionTwo = modelVO.contentUrl;
                wSelf.modelSubInfo.titleSectionTwo = modelVO.title;
            } else if (i == 2) {
                [wSelf.imgViewSectionThree setImageWithURL:[NSURL URLWithString:modelVO.imgUrl]placeholderImage:[UIImage imageNamed:@"icon_health_older"]];
                wSelf.lblSectionThree.text = modelVO.title;
                wSelf.modelSubInfo.strSectionThree = modelVO.contentUrl;
                wSelf.modelSubInfo.titleSectionThree = modelVO.title;
            } else {
                [wSelf.imgViewSectionFour setImageWithURL:[NSURL URLWithString:modelVO.imgUrl]placeholderImage:[UIImage imageNamed:@"icon_health_tonic"]];
                wSelf.lblSectionFour.text = modelVO.title;
                wSelf.modelSubInfo.strSectionFour = modelVO.contentUrl;
                wSelf.modelSubInfo.titleSectionFour = modelVO.title;
            }
        }
//        [wSelf setupDistrictAndAreaData];
        wSelf.modelSubInfo.isFilledUp = YES;
        
    } failure:^(HttpException *e) {
        wSelf.tableMain.tableHeaderView = nil;
    }];
}
*/
@end
