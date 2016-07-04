//
//  SubSearchPharmacyViewController.m
//  wenyao
//
//  Created by xiezhenghong on 14-10-24.
//  Copyright (c) 2014年 xiezhenghong. All rights reserved.
//

#import "SubSearchPharmacyViewController.h"
#import "MyPharmacyTableViewCell.h"
#import "Constant.h"
#import "UIImageView+WebCache.h"
#import "Box.h"
#import "QueryMyBoxModel.h"
#import "AppDelegate.h"
#import "Constant.h"
#import "AddNewMedicineViewController.h"
#import "PharmacyDetailViewController.h"
#import "SVProgressHUD.h"
#import "TagCollectionView.h"
#import "TagCollectionFlowLayout.h"
#import "FamilyMedicine.h"
#import "FamilyMedicineR.h"
@interface SubSearchPharmacyViewController ()<UITableViewDataSource,
UITableViewDelegate,UISearchBarDelegate,TagCollectionViewDelegate,MGSwipeTableCellDelegate>

@property (nonatomic, strong) UISearchBar   *searchBar;
@property (nonatomic, strong) UISearchDisplayController *searchDisplay;
@property (nonatomic, strong) TagCollectionView     *tagCollectionView;
@property (nonatomic, strong) NSMutableArray    *tagsList;
@property (nonatomic,strong)NSString *keywords;
@end

@implementation SubSearchPharmacyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (iOSv7 && self.view.frame.origin.y==0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
//    self.navVIew.backgroundColor = RGBHex(qwColor4);
//    self.navigationController.navigationBar.hidden = YES;
    self.myMedicineList = [NSMutableArray arrayWithCapacity:15];
    self.tagsList = [NSMutableArray arrayWithCapacity:15];
    [self setupCollection];
    [self setupSearchBar];
    self.title = @"搜索用药";
    [self queryTagLists];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self.navigationController.navigationBar addSubview:self.searchBar];
//    [self.searchBar becomeFirstResponder];
    [self.searchDisplay.searchResultsTableView reloadData];
    if (self.keywords) {
        ByKeywordR * modle = [ByKeywordR new];
        modle.memberId = self.memberId;
        modle.keyword = self.keywords;
        
        [FamilyMedicine byKeyword:modle success:^(id array) {
            
            self.myMedicineList = array;
            [self.searchDisplay.searchResultsTableView reloadData];
        } failure:^(HttpException *e) {
            
        }];
    }

}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [self.searchBar resignFirstResponder];
//    [self.searchBar removeFromSuperview];
    ((QWBaseNavigationController *)self.navigationController).canDragBack = YES;
}
- (void)setupSearchBar
{
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width  , 44)];
    self.searchBar.backgroundColor = [UIColor clearColor];
    self.searchBar.placeholder = @"搜索用药";
    self.searchBar.delegate = self;
//     [self.navVIew addSubview:self.searchBar];
    
//    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc]initWithCustomView:self.searchBar];
//
//    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObject:searchButton];
//
    [self.view addSubview:self.searchBar];
    self.searchDisplay = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
    self.searchDisplay.searchResultsDataSource = self;
    self.searchDisplay.searchResultsDelegate = self;
    self.searchDisplay.searchResultsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.navigationController = self.searchDisplay;
//    [self.view addSubview:self.searchDisplay];
}

- (void)setupCollection
{
    CGRect rect = self.view.frame;
    rect.origin.y = 44;
    rect.size.height -= 64 + 44;
    self.tagCollectionView = [[TagCollectionView alloc] initWithFrame:rect collectionViewLayout:[[TagCollectionFlowLayout alloc] init]];
    self.tagCollectionView.collectionDelegate = self;
    [self.view addSubview:self.tagCollectionView];
}

- (void)queryTagLists
{
    if(self.tagsList.count > 0)
        return;

//    QueryAllTagsR *queryAllTagsR = [QueryAllTagsR new];
//    queryAllTagsR.token = QWGLOBALMANAGER.configure.userToken;
//    
//    [Box QueryAllTagsWithParams:queryAllTagsR success:^(id array) {
//        self.tagsList = array;
//        [self.tagCollectionView reloadData];
//        
//    } failure:NULL];
    QueryTagsR *model = [QueryTagsR new];
    model.memberId = self.memberId;
    [FamilyMedicine queryTags:model success:^(id array) {
        self.tagsList = array;
        [self.tagCollectionView reloadData];
        
    }  failure:^(HttpException *e) {
    
    }];
}
- (void)UIGlobal{
    //    [super UIGlobal];
}
#pragma mark -
#pragma mark UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if(searchText.length == 0)
        return;

    ByKeywordR * modle = [ByKeywordR new];
    modle.memberId = self.memberId;
    modle.keyword = searchText;
    self.keywords = searchText;
    [FamilyMedicine byKeyword:modle success:^(id array) {
        
        self.myMedicineList = array;
        [self.searchDisplay.searchResultsTableView reloadData];
    } failure:^(HttpException *e) {
        
    }];
}

#pragma mark -
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120.0f;
}

- (NSInteger)tableView:(UITableView *)atableView numberOfRowsInSection:(NSInteger)section
{
    return self.myMedicineList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)atableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)atableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    MyPharmacyTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"MyPharmacyTableViewCell" owner:self options:nil] objectAtIndex:0];

    QueryMyBoxModel *boxModel = self.myMedicineList[indexPath.row];
    [cell setCell:boxModel];
    cell.tag = indexPath.row + 2000;
   
//    BOOL showAlarm = [app.dataBase checkAlarmClock:dict[@"boxId"]];
//    if(showAlarm) {
//        cell.alarmClockImage.hidden = NO;
//    }else{
//        cell.alarmClockImage.hidden = YES;
//    }
    
    NSString *strMedicine = boxModel.productName;
    
    NSMutableAttributedString *strAttributeMedicine = [[NSMutableAttributedString alloc] initWithString:strMedicine];
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:self.searchBar.text options:kNilOptions error:nil];
    
    NSRange range = NSMakeRange(0,strMedicine.length);
    
    [regex enumerateMatchesInString:strMedicine options:kNilOptions range:range usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        NSRange subStringRange = [result rangeAtIndex:0];
        [strAttributeMedicine addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0/255.0f green:183/255.0f blue:45/255.0f alpha:1] range:subStringRange];
    }];

    cell.productName.attributedText = strAttributeMedicine;

    cell.swipeDelegate = self;
    [self layoutTableView:atableView withTableViewCell:cell WithTag:boxModel];
    
    return cell;
}

- (void)tableView:(UITableView *)atableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *selection = [atableView indexPathForSelectedRow];
    if (selection) {
        [atableView deselectRowAtIndexPath:selection animated:YES];
    }
    [atableView deselectRowAtIndexPath:indexPath animated:YES];
    if(QWGLOBALMANAGER.currentNetWork == kNotReachable)
    {
        [SVProgressHUD showErrorWithStatus:kWarning12 duration:0.8f];
        return;
    }
    QueryMyBoxModel *myBoxModel = self.myMedicineList[indexPath.row];
//    if(myBoxModel.useMethod && ![myBoxModel.useMethod isEqualToString:@""] && myBoxModel.perCount && ![myBoxModel.perCount isEqualToString:@""] && myBoxModel.unit && ![myBoxModel.unit isEqualToString:@""] && myBoxModel.useName && ![myBoxModel.useName isEqualToString:@""])
//    {
                PharmacyDetailViewController *pharmacyDetailViewController = [[UIStoryboard storyboardWithName:@"FamilyMedicineListViewController" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"PharmacyDetailViewController"];
        pharmacyDetailViewController.boxModel = myBoxModel;
    pharmacyDetailViewController.memberId = self.memberId;
        pharmacyDetailViewController.changeMedicineInformation = ^(QueryMyBoxModel *boxModel)
        {
//            if([dict[@"intervalDay"] integerValue] == 0)
//            {
//                [app.dataBase deleteAlarmClock:dict[@"boxId"]];
//                return;
//            }
//            BOOL showAlarm = [app.dataBase checkAlarmClock:dict[@"boxId"]];
//            if(showAlarm) {
//                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:[NSString stringWithFormat:@"您的用药%@已更新,该用药闹钟已失效,是否手动修改?",dict[@"productName"]] delegate:self cancelButtonTitle:@"删除" otherButtonTitles:@"修改", nil];
//                alertView.tag = indexPath.row;
//                [alertView show];
//            }
        };
        [self.navigationController pushViewController:pharmacyDetailViewController animated:YES];
        
//    }else{
//        __weak __typeof(self) weakSelf = self;
//        AddNewMedicineViewController *addNewMedicineViewController = [[UIStoryboard storyboardWithName:@"FamilyMedicineListViewController" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"AddNewMedicineViewController"];
//        addNewMedicineViewController.editMode = 1;
//        addNewMedicineViewController.InsertNewPharmacy = ^(QueryMyBoxModel *myBoxModel) {
//            NSUInteger row = [weakSelf.myMedicineList indexOfObject:myBoxModel];
//            
//            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
//            [weakSelf.searchDisplay.searchResultsTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//        };
//        addNewMedicineViewController.queryMyBoxModel =  myBoxModel ;
//        [self.navigationController pushViewController:addNewMedicineViewController animated:YES];
//        return;
//    }
}



- (void)layoutTableView:(UITableView *)atableView withTableViewCell:(UITableViewCell *)cell WithTag:(QueryMyBoxModel *)tagsDict
{
    CGFloat offset = 84;
    UIButton *button = nil;
    NSUInteger index = 0;
    index = [self.myMedicineList indexOfObject:tagsDict];
    NSInteger tagBtnDrug = index * 1000 + DrugTag;
    UIButton *btnExistDrug = (UIButton *)[cell.contentView viewWithTag:tagBtnDrug];
    if (btnExistDrug) {
        [btnExistDrug removeFromSuperview];
    }
    NSInteger tagBtnUsrName = index * 1000 + UseNameTag;
    UIButton *btnExistUsrName = (UIButton *)[cell.contentView viewWithTag:tagBtnUsrName];
    if (btnExistUsrName) {
        [btnExistUsrName removeFromSuperview];
    }
    NSInteger tagBtnEffect = index * 1000 + EffectTag;
    UIButton *btnExistEffect = (UIButton *)[cell.contentView viewWithTag:tagBtnEffect];
    if (btnExistEffect) {
        [btnExistEffect removeFromSuperview];
    }
    //if(tagsDict.drugTag && ![tagsDict.drugTag isEqualToString:@""])
    if(!StrIsEmpty(tagsDict.drugTag))
    {
        button = [self createTagButtonWithTitle:tagsDict.drugTag WithIndex:index tagType:DrugTag withOffset:offset];
        [cell.contentView addSubview:button];
        offset += button.frame.size.width + 10;
    }
//    if(tagsDict.useName && ![tagsDict.useName isEqualToString:@""])
//    {
//        button = [self createTagButtonWithTitle:tagsDict.useName WithIndex:index tagType:UseNameTag withOffset:offset];
//        [cell.contentView addSubview:button];
//        offset += button.frame.size.width + 10;
//    }
   // if(tagsDict.effect && ![tagsDict.effect isEqualToString:@""])
    if(!StrIsEmpty(tagsDict.effect))
    {
        button = [self createTagButtonWithTitle:tagsDict.effect WithIndex:index tagType:EffectTag withOffset:offset];
        [cell.contentView addSubview:button];
        offset += button.frame.size.width + 10;
    }
}

- (UIButton *)createTagButtonWithTitle:(NSString *)title WithIndex:(NSUInteger)index tagType:(TagType)tagType withOffset:(CGFloat)offset
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:[UIColor clearColor]];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:RGBHex(qwColor6) forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13.0];
    UIImage *resizeImage = nil;
    if(tagType == AddTag) {
        resizeImage = [UIImage imageNamed:@"btn_bg_tag"];
        [button setTitleColor:RGBHex(qwColor1) forState:UIControlStateNormal];
        resizeImage = [resizeImage resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch];
    }else{
        resizeImage = [UIImage imageNamed:@"btn_bg_tag"];
        //        DDLogVerbose(@"%@",NSStringFromCGSize(resizeImage.size));
        resizeImage = [resizeImage resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10,10, 10) resizingMode:UIImageResizingModeStretch];
    }
    CGSize size = [title sizeWithFont:button.titleLabel.font constrainedToSize:CGSizeMake(300, 20)];
    button.frame = CGRectMake(offset, 67, size.width + 2 * 10, 25);
    button.tag = index * 1000 + tagType;
    [button setBackgroundImage:resizeImage forState:UIControlStateNormal];
       button.enabled = NO;
    return button;
}

#pragma mark -
#pragma mark TagCollectionViewDelegate
- (NSUInteger)numberOfItemsInCollectionView
{
    return self.tagsList.count;
}

- (NSString *)contentForIndexPath:(NSIndexPath *)indexPath
{
    return self.tagsList[indexPath.row];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *tagName = self.tagsList[indexPath.row];
    MyPharmacyViewController *myPharmacyViewController = [[UIStoryboard storyboardWithName:@"FamilyMedicineListViewController" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"MyPharmacyViewController"];
    myPharmacyViewController.hidesBottomBarWhenPushed = YES;
    myPharmacyViewController.familyMembersVo  = self.familyMembersVo;
    myPharmacyViewController.memberId = self.memberId;
    
     myPharmacyViewController.subType = YES;
    [self.navigationController pushViewController:myPharmacyViewController animated:YES];
    myPharmacyViewController.title = tagName;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
}
@end
