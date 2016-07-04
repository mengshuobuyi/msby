//
//  MarketDetailViewController.m
//  quanzhi
//
//  Created by xiezhenghong on 14-7-3.
//  Copyright (c) 2014年 xiezhenghong. All rights reserved.
//

#import "MarketDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "ReturnIndexView.h"
#import "Activity.h"
#import "MessageBoxListViewController.h"
#import "LoginViewController.h"

@interface MarketDetailViewController ()<ReturnIndexViewDelegate>
{
    float imageViewheight;
    ActivityDataModel *dataModel;
}
@property (strong, nonatomic) ReturnIndexView *indexView;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (strong,nonatomic)NSMutableArray *imageArrayUrl;
@property (strong, nonatomic) IBOutlet UIView *setimageViews;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintWidth;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeight;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *kly;
@property (nonatomic, strong) UILabel *numLabel;   //数字角标
@property (nonatomic, strong) UILabel *redLabel;   //小红点
@property (assign, nonatomic) int passNumber;


@end

@implementation MarketDetailViewController

- (id)init
{
    if (self = [super init])
    {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    imageViewheight=0;
    self.constraintWidth.constant = APP_W;
    self.setimageViews.backgroundColor= RGBHex(qwColor11);
    if (iOSv7 && self.view.frame.origin.y==0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    self.contentLabel.textColor = RGBHex(qwColor7);
    self.contentLabel.font = fontSystem(kFontS4);
    self.titleLabel.textColor = RGBHex(qwColor6);
    self.titleLabel.font = fontSystem(kFontS2);
//    self.dateLabel.textColor = RGBHex(qwColor8);
//    self.dateLabel.font = fontSystem(kFontS5);
    self.view.backgroundColor = RGBHex(qwColor4);
    self.title = @"活动详情";
    if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
        [self showInfoView:@"网络未连接，请重试" image:@"网络信号icon.png"];
        return;
    }
    
}

#pragma mark - 分享
- (void)shareClick{
    
    ShareContentModel *modelShare = [[ShareContentModel alloc] init];
    modelShare.typeShare    = ShareTypeCommonActivity;
    modelShare.shareID      = dataModel.activityId;
    modelShare.title        = dataModel.title;
    modelShare.imgURL       = dataModel.imgUrl;
    
    if(dataModel.content.length > 15){
       modelShare.content   = [dataModel.content substringToIndex:14];
    }else{
        modelShare.content  = dataModel.content;
    }

    [self popUpShareView:modelShare];
}


#pragma mark---------------------------------------------跳转到首页-----------------------------------------------

- (void)setUpRightItem
{
    
    
    UIView *ypDetailBarItems=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 55)];
    UIButton * zoomButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [zoomButton setFrame:CGRectMake(23, -2, 55,55)];
    [zoomButton addTarget:self action:@selector(shareClick) forControlEvents:UIControlEventTouchUpInside];
    [zoomButton setImage:[UIImage imageNamed:@"icon_share"] forState:UIControlStateNormal];
    [zoomButton setImage:[UIImage imageNamed:@"icon_share_click"] forState:UIControlStateHighlighted];
    [ypDetailBarItems addSubview:zoomButton];
    UIBarButtonItem *fixed = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixed.width = -15;
    self.navigationItem.rightBarButtonItems=@[fixed,[[UIBarButtonItem alloc]initWithCustomView:ypDetailBarItems]];
    
    
    
    
    
    
//    UIBarButtonItem *fixed = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    fixed.width = -15;
//    
//    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
//    
//    //三个点button
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = CGRectMake(5, -2, 50, 40);
//    [button setImage:[UIImage imageNamed:@"icon-unfold.PNG"] forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(returnIndex) forControlEvents:UIControlEventTouchUpInside];
//    [rightView addSubview:button];
//    
//    //数字角标
//    self.numLabel = [[UILabel alloc] initWithFrame:CGRectMake(38, 1, 18, 18)];
//    self.numLabel.backgroundColor = RGBHex(qwColor3);
//    self.numLabel.layer.cornerRadius = 9.0;
//    self.numLabel.textColor = [UIColor whiteColor];
//    self.numLabel.font = [UIFont systemFontOfSize:11];
//    self.numLabel.textAlignment = NSTextAlignmentCenter;
//    self.numLabel.layer.masksToBounds = YES;
//    self.numLabel.text = @"10";
//    self.numLabel.hidden = YES;
//    [rightView addSubview:self.numLabel];
//    
//    //小红点
//    self.redLabel = [[UILabel alloc] initWithFrame:CGRectMake(43, 10, 8, 8)];
//    self.redLabel.backgroundColor = RGBHex(qwColor3);
//    self.redLabel.layer.cornerRadius = 4.0;
//    self.redLabel.layer.masksToBounds = YES;
//    self.redLabel.hidden = YES;
//    [rightView addSubview:self.redLabel];
//    
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
//    self.navigationItem.rightBarButtonItems = @[fixed,rightItem];
//    
//    if (self.passNumber > 0)
//    {
//        //显示数字
//        self.numLabel.hidden = NO;
//        self.redLabel.hidden = YES;
//        if (self.passNumber > 99) {
//            self.passNumber = 99;
//        }
//        self.numLabel.text = [NSString stringWithFormat:@"%d",self.passNumber];
//        
//    }else if (self.passNumber == 0)
//    {
//        //显示小红点
//        self.numLabel.hidden = YES;
//        self.redLabel.hidden = NO;
//        
//    }else if (self.passNumber < 0)
//    {
//        //全部隐藏
//        self.numLabel.hidden = YES;
//        self.redLabel.hidden = YES;
//    }

}
- (void)returnIndex
{
    self.indexView = [ReturnIndexView sharedManagerWithImage:@[@"ic_img_notice",@"icon home.PNG",@"icon_share_new"] title:@[@"消息",@"首页",@"分享"] passValue:self.passNumber];
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
        
    }else if (indexPath.row == 1){
        [self.navigationController popToRootViewControllerAnimated:YES];
        [self performSelector:@selector(delayPopToHome) withObject:nil afterDelay:0.01];
    }else{
        [self shareClick];
    }

}
- (void)delayPopToHome
{
    [QWGLOBALMANAGER.tabBar setSelectedIndex:0];
}
#pragma mark---------------------------------------------跳转到首页-----------------------------------------------

-(void)getInfomation
{
    QueryActivityModelR *activityModelR = [[QueryActivityModelR alloc] init];
    activityModelR.activityId = self.infoDict[@"activityId"];

    [Activity getActivityWithParam:activityModelR success:^(id DFModel) {
        dataModel = (ActivityDataModel *)DFModel;
        if(dataModel.activityId==nil){
            if(self.bannerStatus==1){
                [self showInfoView:@"暂无数据" image:@"ic_img_fail"];
            }else{
                [self infoNew];//查不出来的肯定物理删除了，就直接盖删除的章
                UIImageView *deleted=[[UIImageView alloc]initWithFrame:CGRectMake(APP_W-120, 100, 100, 100)];
                [deleted setImage:[UIImage imageNamed:@"bg-activity delete.PNG"]];
                [self.view addSubview:deleted];
            }
            return;
        }else{
            if(self.bannerStatus==1&&((dataModel.deleted &&[dataModel.deleted intValue] == 1)||(dataModel.expired &&[dataModel.expired intValue] == 1))){
                [self showInfoView:@"暂无数据" image:@"ic_img_fail"];
                return;
            }else{
            self.contentLabel.text = [QWGLOBALMANAGER replaceSpecialStringWith:dataModel.content];
            self.titleLabel.text = [QWGLOBALMANAGER replaceSpecialStringWith:dataModel.title];
                
            if(dataModel.publishTime&&dataModel.publishTime.length>=10){
                self.lblSource.text = [dataModel.publishTime substringToIndex:10];
            }
                
//            NSInteger source = [dataModel.source integerValue];
//            
//            if (source == 1) {
//                self.lblSource.text = @"来源: 全维";
//            } else if (source == 2) {
//                self.lblSource.text = @"来源: 商户";
//            } else if (source == 3){
//                self.lblSource.text = @"来源: 门店";
//            }else {
//                self.kly.priority = 601;
//                self.dateLabel.textAlignment=NSTextAlignmentLeft;
//            }
            UIImageView *deleted=[[UIImageView alloc]initWithFrame:CGRectMake(APP_W-120, 100, 100, 100)];
            if(dataModel.deleted &&([dataModel.deleted intValue] == 1)){
                [deleted setImage:[UIImage imageNamed:@"bg-activity delete.PNG"]];
                [self.view addSubview:deleted];
                [self.imageArrayUrl removeAllObjects];
            }else{
                if(dataModel.expired  &&([dataModel.expired intValue] == 1)){
                    [deleted setImage:[UIImage imageNamed:@"bg-activity expired.PNG"]];
                    [self.view addSubview:deleted];
                    [self.imageArrayUrl removeAllObjects];
                }
            }

            if(dataModel.imgs.count==0) {
                self.setimageViews.hidden = YES;
            }else{
                self.setimageViews.hidden = NO;
                [self.imageArrayUrl addObjectsFromArray:dataModel.imgs];
                [self getimages];
            }
        }
        
        }
       
    } failure:^(HttpException *e) {
        DebugLog(@"%@",e);
    }];
        
    }
    

-(void)getimages
{
    imageViewheight=0;
    for (int i=0; i<self.imageArrayUrl.count; i++) {
        UIImageView *imageView=[[UIImageView alloc] init];
        [self.setimageViews addSubview:imageView];
        [self.setimageViews setBackgroundColor:[UIColor clearColor]];
        ActivityImgsModel *imageModel = self.imageArrayUrl[i];
        __weak UIImageView *weakImgView = imageView;
        [SDWebImageManager.sharedManager downloadWithURL:[NSURL URLWithString:imageModel.normalImg] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished) {
            if (image.size.width>self.setimageViews.frame.size.width) {
                CGFloat imageh=image.size.height*self.setimageViews.frame.size.width/image.size.width;
                weakImgView.frame=CGRectMake(0,0+imageViewheight, self.setimageViews.frame.size.width, imageh);
                imageViewheight+=imageh+8;
            }else{
                weakImgView.frame=CGRectMake((self.setimageViews.frame.size.width-image.size.width)/2, 0+imageViewheight, image.size.width , image.size.height);;
                imageViewheight+=image.size.height+8;
            }
            [weakImgView setImage:image];
            [self changeCons];
        }];
    }
}

-(void)gotoback:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.passNumber = [QWGLOBALMANAGER updateRedPoint];
    [self setUpRightItem];
  
    self.imageArrayUrl=[NSMutableArray array];
    //请求数据
    [self getInfomation];
}

-(void)infoNew{
    self.contentLabel.text = [QWGLOBALMANAGER replaceSpecialStringWith:self.infoNewDict[@"content"]];
    if(self.infoNewDict[@"publishTime"]){//防止空值
        NSString *stringLen= self.infoNewDict[@"publishTime"];
        if(stringLen.length>=10){
            self.lblSource.text = [self.infoNewDict[@"publishTime"] substringToIndex:10];
        }
    }
    self.titleLabel.text = [QWGLOBALMANAGER replaceSpecialStringWith:self.infoNewDict[@"title"]];
//    [self setSourceLabel];
}

-(void)changeCons{
    
    if(imageViewheight!=0){
        CGFloat heightMIn=self.contentLabel.frame.size.height;
        //遍历view约束
        NSArray* constrains2 = self.setimageViews.constraints;
        for (NSLayoutConstraint* constraint in constrains2) {
            if (constraint.firstAttribute == NSLayoutAttributeHeight) {
                constraint.constant = imageViewheight;
            }
        }
        self.viewHeight.constant=imageViewheight+heightMIn+100;
    }
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    if(imageViewheight!=0){
        CGFloat heightMIn=self.contentLabel.frame.size.height;
        //遍历view约束
        NSArray* constrains2 = self.setimageViews.constraints;
        for (NSLayoutConstraint* constraint in constrains2) {
            if (constraint.firstAttribute == NSLayoutAttributeHeight) {
                constraint.constant = imageViewheight;
            }
        }
        self.viewHeight.constant=imageViewheight+heightMIn+100;
    }
}


- (void)setSourceLabel
{
//    if ([self.infoNewDict[@"source"] intValue]==1) {
//        self.lblSource.text = @"来源: 全维";
//    } else if ([self.infoNewDict[@"source"] intValue]==2) {
//        self.lblSource.text = @"来源: 商户";
//    } else if ([self.infoNewDict[@"source"] intValue]==3) {
//        self.lblSource.text = @"来源: 门店";
//    } else {
//        self.kly.priority = 601;
//        self.dateLabel.textAlignment=NSTextAlignmentLeft;
//    }
    
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

- (void)popVCAction:(id)sender{
    
    [super popVCAction:sender];
}
@end
