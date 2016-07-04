//
//  CarePharmacistViewController.m
//  APP
//  "专家"页面
//  由我关注的专家和推荐专家组成，点击任意专家进入专家专栏
//  Created by Martin.Liu on 15/12/30.
//  Copyright © 2015年 carret. All rights reserved.
//

#import "CarePharmacistViewController.h"
#import "TitleCollectionReusableView.h"
//#import "PharmacistCollectionCell.h"
#import "NoCarePharmacistCollectionCell.h"
#import "LoginToCarePharmacistCollectionCell.h"
#import "LoginViewController.h"
#import "Forum.h"
#import "SVProgressHUD.h"
#import "ExpertPageViewController.h"
#import "QWProgressHUD.h"
#import "ExpertCollectionCell.h"
//#import "CarePharmacistCollectionLayout.h"
@interface CarePharmacistViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) IBOutlet UICollectionViewFlowLayout *flowlayout;

@end

@implementation CarePharmacistViewController
{
    NSArray* attnExpertArray;
    NSArray* expertArray;
    
    BOOL needLodaData;      // 刷新页面的时候用， 如果push到下一个页面，设置YES
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"专家";
    self.flowlayout.headerReferenceSize = CGSizeMake(APP_W, 44);
    self.collectionView.backgroundColor = RGBHex(qwColor11);
    [self.collectionView registerNib:[UINib nibWithNibName:@"TitleCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"TitleCollectionReusableView"];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"ExpertCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"ExpertCollectionCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"NoCarePharmacistCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"NoCarePharmacistCollectionCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"LoginToCarePharmacistCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"LoginToCarePharmacistCollectionCell"];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [self enableSimpleRefresh:self.collectionView block:^(SRRefreshView *sender) {
        [self loadDataWithoutProgress];
    }];
    [self loadData];
}

- (void)UIGlobal
{
//    self.flowlayout.itemSize = CGSizeMake(160, 220);
    self.flowlayout.itemSize = CGSizeMake(APP_W/2, 230);
    self.flowlayout.sectionInset = UIEdgeInsetsZero;
    // 王娟老大不喜欢这种的
//    if (APP_W > 320) {
//        CGFloat flowLayoutWidth = (APP_W - MAX(self.flowlayout.sectionInset.left, self.flowlayout.sectionInset.right) * 3) / 2;
//        self.flowlayout.itemSize = CGSizeMake(flowLayoutWidth, flowLayoutWidth * self.flowlayout.itemSize.height / self.flowlayout.itemSize.width);
//        UIEdgeInsets sectionInset = self.flowlayout.sectionInset;
//        sectionInset.left = sectionInset.right = (APP_W - self.flowlayout.itemSize.width * 2) / 3 ;
//        self.flowlayout.sectionInset = sectionInset;
//    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (needLodaData) {
        [self loadData];
        needLodaData = NO;
    }
}

- (void)loadData
{
    GetExpertListInfoR* getExpertListInfoR = [GetExpertListInfoR new];
    getExpertListInfoR.token = QWGLOBALMANAGER.configure.userToken;
    [Forum getAttenAndRecommendExpertListInfo:getExpertListInfoR success:^(QWAttnAndRecommendExpertList *expertList) {
        [self removeInfoView];
        attnExpertArray = expertList.attnExpertList;
        expertArray = expertList.expertList;
        
        if (attnExpertArray.count == 0 && expertArray.count == 0) {
            [self showInfoView:@"暂无关注的专家" image:@"ic_img_fail"];
        }
        else
        {
            [self removeInfoView];
        }
        
        [self.collectionView reloadData];
        [self endHeaderRefresh];
    } failure:^(HttpException *e) {
        if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
            [self showInfoView:kWarning12 image:@"网络信号icon"];
        }else
        {
            if(e.errorCode!=-999){
                if(e.errorCode == -1001){
                    [self showInfoView:kWarning215N26 image:@"ic_img_fail"];
                }else{
                    [self showInfoView:kWarning39 image:@"ic_img_fail"];
                }
            }
        }
        [self endHeaderRefresh];
         DebugLog(@"getAttenAndRecommendExpertListInfo : %@", e);;
    }];
}

- (void)loadDataWithoutProgress
{
    GetExpertListInfoR* getExpertListInfoR = [GetExpertListInfoR new];
    getExpertListInfoR.token = QWGLOBALMANAGER.configure.userToken;
    [Forum getAttenAndRecommendExpertListInfoWithoutProgress:getExpertListInfoR success:^(QWAttnAndRecommendExpertList *expertList) {
        [self removeInfoView];
        attnExpertArray = expertList.attnExpertList;
        expertArray = expertList.expertList;
        
        if (attnExpertArray.count == 0 && expertArray.count == 0) {
            [self showInfoView:@"暂无关注的圈子" image:@"ic_img_fail"];
        }
        else
        {
            [self removeInfoView];
        }
        
        [self.collectionView reloadData];
        [self endHeaderRefresh];
    } failure:^(HttpException *e) {
        if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
            [self showInfoView:kWarning12 image:@"网络信号icon"];
        }else
        {
            if(e.errorCode!=-999){
                if(e.errorCode == -1001){
                    [self showInfoView:kWarning215N26 image:@"ic_img_fail"];
                }else{
                    [self showInfoView:kWarning39 image:@"ic_img_fail"];
                }
            }
        }
        [self endHeaderRefresh];
        DebugLog(@"getAttenAndRecommendExpertListInfo : %@", e);;
    }];

}

- (void)viewInfoClickAction:(id)sender
{
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (expertArray.count == 0) {
        return 1;
    }
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        if (QWGLOBALMANAGER.loginStatus) {
            // 如果是奇数个，那么多添加一个 UI需要。
            NSInteger numberVisial = attnExpertArray.count % 2 == 0 ? attnExpertArray.count : attnExpertArray.count + 1;
            return MAX(numberVisial, 1);
        }
        else
            return 1;
    }
    return expertArray.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    TitleCollectionReusableView* header = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        header = (TitleCollectionReusableView*)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"TitleCollectionReusableView" forIndexPath:indexPath];
        header.backgroundColor = RGBHex(qwColor11);
        NSString* titleString = nil;
        switch (indexPath.section) {
            case 0:
                titleString = @"我关注的专家";
//                header.backgroundColor = [UIColor whiteColor];
                break;
            case 1:
                titleString = @"推荐专家";
                break;
            default:
                break;
        }
        header.titleTextLabel.text = titleString;
    }
    return header;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    if (indexPath.section == 0) {
        if (QWGLOBALMANAGER.loginStatus) {
            if (attnExpertArray.count == 0) {
                NoCarePharmacistCollectionCell* noCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NoCarePharmacistCollectionCell" forIndexPath:indexPath];
//                noCell.backgroundColor = [UIColor whiteColor];
                return noCell;
            }
            else
            {
                if (indexPath.row >= attnExpertArray.count) {
                    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
//                    cell.backgroundColor = [UIColor whiteColor];
                    return cell;
                }
                ExpertCollectionCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ExpertCollectionCell" forIndexPath:indexPath];
                [cell setIndexPath:indexPath];
                QWExpertInfoModel* expertInfoModel = attnExpertArray[row];
                /* 没有取消按钮行为
                cell.careBtn.touchUpInsideBlock = ^{
                    
                    [QWGLOBALMANAGER statisticsEventId:@"x_qz_zj_gz" withLable:@"圈子-专家-关注" withParams:[NSMutableDictionary dictionaryWithDictionary:@{@"是否登录":StrFromInt(QWGLOBALMANAGER.loginStatus),@"专家名":StrDFString(expertInfoModel.nickName, @"专家名"), @"专家类型":@"关注", @"药房":StrDFString(expertInfoModel.groupName, @"药房"), @"擅长":StrDFString(expertInfoModel.expertise, @"营养保健，疾病调养"),@"鲜花":StrFromInt(expertInfoModel.upVoteCount),@"帖子":StrFromInt(expertInfoModel.postCount),@"用户等级":StrFromInt(QWGLOBALMANAGER.configure.mbrLvl),@"点击时间":[QWGLOBALMANAGER timeStrNow],@"类型":@"取消关注"}]];
                    
                    if (!QWGLOBALMANAGER.loginStatus) {
                        [QWGLOBALMANAGER statisticsEventId:@"x_qz_zj_dj" withLable:@"圈子-专家-点击某个专家" withParams:[NSMutableDictionary dictionaryWithDictionary:@{@"是否登录":StrFromInt(QWGLOBALMANAGER.loginStatus),@"用户等级":StrFromInt(QWGLOBALMANAGER.configure.mbrLvl),@"点击时间":[QWGLOBALMANAGER timeStrNow],@"专家名":StrDFString(expertInfoModel.nickName, @"专家名"), @"药房":StrDFString(expertInfoModel.groupName, @"药房"), @"擅长":StrDFString(expertInfoModel.expertise, @"营养保健，疾病调养"),@"鲜花":StrFromInt(expertInfoModel.upVoteCount),@"帖子":StrFromInt(expertInfoModel.postCount),@"专家类型":expertInfoModel.userType == PosterType_YaoShi ? @"药师" : @"营养师"}]];
                        
                        LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
                        UINavigationController *navgationController = [[QWBaseNavigationController alloc] initWithRootViewController:loginViewController];
                        loginViewController.isPresentType = YES;
                        [self presentViewController:navgationController animated:YES completion:NULL];
                        return;
                    }
                    
                    if (QWGLOBALMANAGER.configure.flagSilenced) {
                        [SVProgressHUD showErrorWithStatus:@"您已被禁言"];
                        return;
                    }
                    
                    AttentionMbrR* attentionMbrR = [AttentionMbrR new];
                    attentionMbrR.objId = expertInfoModel.id;
                    attentionMbrR.reqBizType = 1;
                    attentionMbrR.token = QWGLOBALMANAGER.configure.userToken;
                    [Forum attentionMbr:attentionMbrR success:^(QWAttentionMbrModel *attentionMbrModel) {
                        if ([attentionMbrModel.apiStatus integerValue] == 0) {
                            [self loadData];
                            if (attentionMbrModel.rewardScore > 0) {
                                [QWProgressHUD showSuccessWithStatus:@"关注成功" hintString:[NSString stringWithFormat:@"+%ld", (long)attentionMbrModel.rewardScore] duration:DURATION_CREDITREWORD];
                            }
                        }
                        else
                        {
                            [SVProgressHUD showErrorWithStatus:attentionMbrModel.apiMessage];
                        }
                    } failure:^(HttpException *e) {
                        DebugLog(@"cancel attention expert error : %@", e);
                    }];
                };
                */
//                cell.careBtn.hidden = YES;
                [cell hiddenCareBtn:YES];
                [cell setCell:expertInfoModel];
//                cell.careBtn.enabled = YES;
//                cell.careBtn.backgroundColor = RGBHex(qwColor9);
//                [cell.careBtn setTitle:@"取消关注" forState:UIControlStateNormal];
                return cell;
            }
        }
        else
        {
            LoginToCarePharmacistCollectionCell* loginCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LoginToCarePharmacistCollectionCell" forIndexPath:indexPath];
//            loginCell.backgroundColor = [UIColor whiteColor];
            loginCell.loginBtn.touchUpInsideBlock = ^{
                [QWGLOBALMANAGER statisticsEventId:@"x_qz_zj_dl" withLable:@"圈子-专家-登录" withParams:[NSMutableDictionary dictionaryWithDictionary:@{@"是否登录":StrFromInt(QWGLOBALMANAGER.loginStatus),@"用户等级":StrFromInt(QWGLOBALMANAGER.configure.mbrLvl),@"点击时间":[QWGLOBALMANAGER timeStrNow]}]];
                
                LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
                UINavigationController *navgationController = [[QWBaseNavigationController alloc] initWithRootViewController:loginViewController];
                loginViewController.isPresentType = YES;
                [self presentViewController:navgationController animated:YES completion:NULL];
                
            };
            return loginCell;
        }
        
    }
    ExpertCollectionCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ExpertCollectionCell" forIndexPath:indexPath];
    [cell setIndexPath:indexPath];
    QWExpertInfoModel* expertInfoModel = expertArray[row];
    cell.careBtn.touchUpInsideBlock = ^{
        [QWGLOBALMANAGER statisticsEventId:@"x_qz_zj_gz" withLable:@"圈子-专家-关注" withParams:[NSMutableDictionary dictionaryWithDictionary:@{@"是否登录":StrFromInt(QWGLOBALMANAGER.loginStatus),@"专家名":StrDFString(expertInfoModel.nickName, @"专家名"), @"专家类型":@"推荐", @"药房":StrDFString(expertInfoModel.groupName, @"药房"), @"擅长":StrDFString(expertInfoModel.expertise, @"营养保健，疾病调养"),@"鲜花":StrFromInt(expertInfoModel.upVoteCount),@"帖子":StrFromInt(expertInfoModel.postCount),@"用户等级":StrFromInt(QWGLOBALMANAGER.configure.mbrLvl),@"点击时间":[QWGLOBALMANAGER timeStrNow],@"类型":@"关注"}]];
        
        if (QWGLOBALMANAGER.configure.flagSilenced) {
            [SVProgressHUD showErrorWithStatus:@"您已被禁言"];
            return;
        }
        if (!QWGLOBALMANAGER.loginStatus) {
            LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
            UINavigationController *navgationController = [[QWBaseNavigationController alloc] initWithRootViewController:loginViewController];
            loginViewController.isPresentType = YES;
            [self presentViewController:navgationController animated:YES completion:NULL];
            return;
        }
        
        AttentionMbrR* attentionMbrR = [AttentionMbrR new];
        attentionMbrR.objId = expertInfoModel.id;
        attentionMbrR.reqBizType = 0;
        attentionMbrR.token = QWGLOBALMANAGER.configure.userToken;
        [Forum attentionMbr:attentionMbrR success:^(QWAttentionMbrModel *attentionMbrModel) {
            if ([attentionMbrModel.apiStatus integerValue] == 0) {
                [self loadData];
                if (attentionMbrModel.rewardScore > 0) {
                    [QWProgressHUD showSuccessWithStatus:@"关注成功" hintString:[NSString stringWithFormat:@"+%ld", (long)attentionMbrModel.rewardScore] duration:DURATION_CREDITREWORD];
                }
            }
            else
            {
                [SVProgressHUD showErrorWithStatus:attentionMbrModel.apiMessage];
            }
        } failure:^(HttpException *e) {
            DebugLog(@"cancel attention expert error : %@", e);
        }];
    };
//    cell.careBtn.hidden = NO;
    [cell hiddenCareBtn:NO];
    [cell setCell:expertInfoModel];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && (!QWGLOBALMANAGER.loginStatus || attnExpertArray.count == 0)) {
        return CGSizeMake(APP_W, 100);
    }
    else
    {
        /**
         *  3.1.1 UI优化
         */
        if (indexPath.section == 0) {
            return CGSizeMake(self.flowlayout.itemSize.width, self.flowlayout.itemSize.height - 15);
        }
        return CGSizeMake(self.flowlayout.itemSize.width, self.flowlayout.itemSize.height + AutoValue(16));
        // 王娟老大不喜欢这种的
//        if (APP_W == 320 && indexPath.section == 0) {
//            return CGSizeMake(self.flowlayout.itemSize.width, self.flowlayout.itemSize.height - (AutoValue(15)));
//        }
//        return CGSizeMake(self.flowlayout.itemSize.width, self.flowlayout.itemSize.height + 16);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && (attnExpertArray.count == 0 || !QWGLOBALMANAGER.loginStatus)) {
        return;
    }
    
    NSString* eventParamValue = @"关注";
    
    NSInteger row = indexPath.row;
    QWExpertInfoModel* expertInfoModel = nil;
    if (indexPath.section == 0 && attnExpertArray.count > 0) {
        if (row < attnExpertArray.count) {
            expertInfoModel = attnExpertArray[row];
            eventParamValue = @"关注";
        }
    }
    else
    {
        if (row < expertArray.count) {
            expertInfoModel = expertArray[indexPath.row];
            eventParamValue = @"推荐";
        }
    }

    if (expertInfoModel) {
        
        if ([expertInfoModel.id isEqualToString:QWGLOBALMANAGER.configure.passPort]) {
            return;
        }
        
        [QWGLOBALMANAGER statisticsEventId:@"x_qz_zj_dj" withLable:@"圈子-专家-点击某个专家" withParams:[NSMutableDictionary dictionaryWithDictionary:@{@"是否登录":StrFromInt(QWGLOBALMANAGER.loginStatus),@"用户等级":StrFromInt(QWGLOBALMANAGER.configure.mbrLvl),@"点击时间":[QWGLOBALMANAGER timeStrNow],@"专家名":StrDFString(expertInfoModel.nickName, @"专家名"), @"药房":StrDFString(expertInfoModel.groupName, @"药房"), @"擅长":StrDFString(expertInfoModel.expertise, @"营养保健，疾病调养"),@"鲜花":StrFromInt(expertInfoModel.upVoteCount),@"帖子":StrFromInt(expertInfoModel.postCount)}]];
        
        ExpertPageViewController *vc = [[UIStoryboard storyboardWithName:@"ExpertPage" bundle:nil] instantiateViewControllerWithIdentifier:@"ExpertPageViewController"];
        vc.hidesBottomBarWhenPushed = YES;
        vc.posterId = expertInfoModel.id;
        vc.expertType = (int)expertInfoModel.userType;
        vc.preVCNameStr = @"专家页面";
        vc.nickName = expertInfoModel.nickName;
        needLodaData = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)getNotifType:(Enum_Notification_Type)type data:(id)data target:(id)obj
{
    if (type == NotifLoginSuccess || type == NotifQuitOut) {
        [self loadData];
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

@end
