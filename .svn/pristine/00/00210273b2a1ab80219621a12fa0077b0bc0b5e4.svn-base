//
//  ReportConsultViewController.m
//  APP
//  举报药房页面

//  api/complaint/queryReasons  举报原因List
//  api/complaint/complaint     举报提交

//  Created by 李坚 on 16/1/6.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "ReportConsultViewController.h"
#import "ConsultStore.h"
#import "SVProgressHUD.h"
#import "ReportConsultTableViewCell.h"

static NSString *const CellIdentifier = @"ReportConsultTableViewCell";


@interface ReportConsultViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UITextViewDelegate>{
    
    BOOL scrollFalg;
    CGFloat scrollHeight;
}
@property (strong, nonatomic) IBOutlet UIView *headView;
@property (strong, nonatomic) IBOutlet UIView *footView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *placHolderText;

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@end

@implementation ReportConsultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"反馈";
    
    self.textView.delegate = self;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(sumitReport:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    _dataArray = [NSMutableArray array];
    
    [_mainTableView registerNib:[UINib nibWithNibName:CellIdentifier bundle:nil] forCellReuseIdentifier:CellIdentifier];
    _mainTableView.backgroundColor = RGBHex(qwColor11);
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _headView.frame = CGRectMake(0, 0, APP_W, 110.0f);
    _mainTableView.tableHeaderView = _headView;
    _footView.frame = CGRectMake(0, 0, APP_W, 185.0f);
    _mainTableView.tableFooterView = _footView;
    
    [self loadReportReason];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //添加键盘弹出收起事件通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //移除键盘弹出收起事件通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - 投诉原因请求
- (void)loadReportReason{
    
    ReportReasonModelR *modelR = [ReportReasonModelR new];
    //投诉对象类型：1.未开通微商的药房，2.社会药房，3.微商药房
    modelR.objType = [NSString stringWithFormat:@"%d",(int)self.objType];
    
    [ConsultStore reportReasonList:modelR success:^(ComplaintReasonList *model) {
        
        [_dataArray removeAllObjects];
        [_dataArray addObjectsFromArray:model.list];
        [_mainTableView reloadData];
    } failure:^(HttpException *e) {
        if(e.errorCode!=-999){
            if(e.errorCode == -1001){
                [self showInfoView:kWarning215N26 image:@"ic_img_fail"];
            }else{
                [self showInfoView:kWarning39 image:@"ic_img_fail"];
            }
        }
    }];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if(scrollFalg){
        [self.textView resignFirstResponder];
    }
    
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    //处理placeHold文字显示/隐藏
    if(textView.text.length > 0){
        self.placHolderText.hidden = YES;
    }else{
        self.placHolderText.hidden = NO;
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    //处理placeHold文字显示/隐藏
    if(textView.text.length > 0){
        self.placHolderText.hidden = YES;
    }else{
        self.placHolderText.hidden = NO;
    }
}

#pragma mark - 键盘弹出回调
-(void)keyboardWillShow:(NSNotification*)notification{
    
    NSDictionary*info=[notification userInfo];
    CGSize kbSize=[[info objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue].size;
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    DDLogVerbose(@"keyboard changed, keyboard width = %f, height = %f",
          kbSize.width,kbSize.height);
    
    CGFloat TableViewScrollHeight = 110.0f + _dataArray.count*44.0f;
    
    
    [UIView animateWithDuration:animationDuration animations:^{
        [_mainTableView setContentOffset:CGPointMake(0, TableViewScrollHeight) animated:NO];
//        CGRect rect = self.view.frame;
//        rect.origin.y -= kbSize.height;
//        self.view.frame = rect;
    } completion:^(BOOL finished) {
        scrollFalg = YES;
    }];
}

#pragma mark - 键盘隐藏回调
-(void)keyboardWillHide:(NSNotification*)notification{
    NSDictionary*info=[notification userInfo];
    CGSize kbSize=[[info objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue].size;
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    DDLogVerbose(@"keyboard changed, keyboard width = %f, height = %f",
          kbSize.width,kbSize.height);
    
    [UIView animateWithDuration:animationDuration animations:^{
        
//        CGRect rect = self.view.frame;
//        rect.origin.y += kbSize.height;
//        self.view.frame = rect;
    } completion:^(BOOL finished) {
        scrollFalg = NO;
    }];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ReportConsultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ComplaintReasonVO *VO = _dataArray[indexPath.row];
    cell.reasonLabel.text = VO.content;
    
    if(VO.selected){
        cell.selectImage.image = [UIImage imageNamed:@"marquee_check"];
    }else{
       cell.selectImage.image = [UIImage imageNamed:@"marquee_uncheck"];
    }
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 43.5, APP_W, 0.5)];
    line.backgroundColor = RGBHex(qwColor10);
    [cell addSubview:line];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.textView resignFirstResponder];
    ComplaintReasonVO *VO = _dataArray[indexPath.row];
    if(VO.selected){
        VO.selected = NO;
    }else{
        VO.selected = YES;
    }
    [_mainTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - 点击提交Action
- (void)sumitReport:(id)sender{
    
    if(QWGLOBALMANAGER.currentNetWork == kNotReachable){
        [SVProgressHUD showSuccessWithStatus:kWarning12 duration:DURATION_SHORT];
        return;
    }
    
    NSString *reasonStr = @"";
    for(ComplaintReasonVO *VO in _dataArray){
        
        if(VO.selected){
            if(reasonStr.length == 0){
                reasonStr = VO.content;
            }else{
                reasonStr = [NSString stringWithFormat:@"%@;%@",reasonStr,VO.content];
            }
        }
    }
    if(StrIsEmpty(reasonStr)){
        [SVProgressHUD showErrorWithStatus:@"请至少选择一个投诉原因" duration:DURATION_LONG];
        return;
    }
    [QWGLOBALMANAGER statisticsEventId:@"x_dnyp_jbtj" withLable:@"投诉药房" withParams:[NSMutableDictionary dictionaryWithDictionary:@{@"投诉内容":reasonStr,@"药房名称":self.branchName == nil?@"":self.branchName}]];
    ReportBranchModelR *modelR = [ReportBranchModelR new];
    modelR.objType = @"3";
    
    modelR.objId        = self.branchId;
    if(QWGLOBALMANAGER.loginStatus){
    modelR.token        = QWGLOBALMANAGER.configure.userToken;
    }
    modelR.reason       = reasonStr;
    modelR.reasonRemark = self.textView.text;
    
    [ConsultStore reportBranch:modelR success:^(BaseAPIModel *model) {
        if([model.apiStatus intValue] == 0){
            [SVProgressHUD showSuccessWithStatus:kWarning38 duration:DURATION_SHORT];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:model.apiMessage duration:DURATION_LONG];
        }
    } failure:^(HttpException *e) {
        if(e.errorCode!=-999){
            if(e.errorCode == -1001){
                [SVProgressHUD showErrorWithStatus:kWarning215N26 duration:DURATION_LONG];
            }else{
                [SVProgressHUD showErrorWithStatus:kWarning39 duration:DURATION_LONG];
            }
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
