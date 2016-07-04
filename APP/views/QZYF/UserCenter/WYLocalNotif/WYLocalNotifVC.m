//
//  WYLocalNotifVC.m
//  wenyao
//
//  Created by Yan Qingyang on 15/4/2.
//  Copyright (c) 2015年 xiezhenghong. All rights reserved.
//

#import "WYLocalNotifVC.h"
#import "WYLNCell.h"
#import "WYLocalNotifModel.h"
#import "MGSwipeButton.h"
#import "AppDelegate.h"

static float kTopBarItemWidth = 40;

@interface WYLocalNotifVC ()<MGSwipeTableCellDelegate>
{
    NSMutableArray *arrData;
    NSIndexPath *indexPathDelte;
}
@end

@implementation WYLocalNotifVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"用药提醒";
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    id obj=[[QWLocalNotif instance] getLNList];
    if ([obj isKindOfClass:[NSMutableArray class]]) {
        arrData=obj;
        [self.tableMain reloadData];
    }
    
    if (!arrData || arrData.count==0) {
        [self noData];
    }
    else [self removeInfoView];
    
}

- (void)noData{
    [self showInfoView:kWarningN1 image:@"img_bg_NO_Clock"];
}

- (void)UIGlobal{
    [super UIGlobal];
    
    [self naviRightBotton];
    self.tableMain.backgroundColor=[UIColor clearColor];
    self.tableMain.footerHidden=YES;

}

//导航栏
- (void)naviRightBotton
{
    CGFloat margin=10;
    CGFloat ww=kTopBarItemWidth, hh=44;
    CGFloat bw,bh;
    
//    UIImage* imgBtn = [UIImage imageNamed:@"nav_ic_add"];//12,21 nav_btn_back
     UIImage *imgBtn = [[UIImage imageNamed:@"nav_ic_add"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    bw=imgBtn.size.width;
    bh=imgBtn.size.height;
    //    DebugLog(@"############## %f %f",bw,bh);
    CGRect frm = CGRectMake(0,0,ww,hh);
    UIButton* btn= [[UIButton alloc] initWithFrame:frm];
    
    [btn setImage:imgBtn forState:UIControlStateNormal];
    [btn setImageEdgeInsets:UIEdgeInsetsMake((hh-bh)/2, margin, (hh-bh)/2, ww-margin-bw)];
    [btn addTarget:self action:@selector(addLocalNotifAction:) forControlEvents:UIControlEventTouchUpInside];
    
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btn.backgroundColor=[UIColor clearColor];
    
    
    UIBarButtonItem *fixed = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixed.width = -16;
    //
    UIBarButtonItem* btnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItems = @[fixed,btnItem];
}

- (IBAction)addLocalNotifAction:(id)sender{
    //少于20个直接加，多余20加提示
    if (arrData.count<20) {
        [self addLN];
    }
    else {
        [self showText:kWarningN4];
        [self performSelector:@selector(addLN) withObject:nil afterDelay:1.f];
//        [self addLN];
    }

}

#pragma mark - 加提醒
- (void)addLN{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"LocalNotif" bundle:nil];
    WYLocalNotifEditVC* vc = [sb instantiateViewControllerWithIdentifier:@"WYLocalNotifEditVC"];

    
    //    vc.delegatePopVC=self.delegatePopVC;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrData.count;
}

- (NSArray *)createRightButtons
{
    NSMutableArray * result = [NSMutableArray array];
    NSArray *titles = nil;
    titles = @[@"删除"];
    
    UIColor * colors[1] = {[UIColor redColor],};
    for (int i = 0; i < 1; ++i)
    {
        MGSwipeButton * button = [MGSwipeButton buttonWithTitle:titles[i] backgroundColor:colors[i] callback:^BOOL(MGSwipeTableCell * sender){
            return YES;
        }];
        [result addObject:button];
    }
    
    return result;
}

#pragma mark -
#pragma mark MGSwipeTableCellDelegate
-(NSArray*) swipeTableCell:(MGSwipeTableCell*)cell
  swipeButtonsForDirection:(MGSwipeDirection)direction
             swipeSettings:(MGSwipeSettings*)swipeSettings
         expansionSettings:(MGSwipeExpansionSettings*)expansionSettings;
{
    if (direction == MGSwipeDirectionRightToLeft)
        return [self createRightButtons];
    return nil;
}

-(BOOL) swipeTableCell:(MGSwipeTableCell*)cell tappedButtonAtIndex:(NSInteger)index direction:(MGSwipeDirection)direction fromExpansion:(BOOL)fromExpansion
{
    indexPathDelte = [self.tableMain indexPathForCell:cell];
    NSUInteger row = indexPathDelte.row;
    if (row < arrData.count)
    {
        //删除
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:kWarningN3 message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag=33;
        [alert show];
    
    }
    return YES;
}

#pragma mark - table

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    static NSString *tableID = @"WYLNCell";

    WYLNCell *cell = [tableView dequeueReusableCellWithIdentifier:tableID];
    cell.delegate=self;
    if (row<arrData.count)
    {
        [cell setCell:[arrData objectAtIndex:row]];
        cell.swipeDelegate = self;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    if (row<arrData.count){
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"LocalNotif" bundle:nil];
        WYLocalNotifDetailVC* vc = (WYLocalNotifDetailVC*)[sb instantiateViewControllerWithIdentifier:@"WYLocalNotifDetailVC"];
            //[WYLocalNotifDetailVC alloc] initWithNibName:<#(NSString *)#> bundle:<#(NSBundle *)#>
        //    vc.delegatePopVC=self.delegatePopVC;
        vc.modLocalNotif=[arrData objectAtIndex:row];
        vc.listClock=arrData;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - table编辑样式
/*
//定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

//进入编辑模式，按下出现的编辑按钮后
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:
(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (row<arrData.count) {
            [arrData removeObjectAtIndex:row];
            
            //删除动画
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            
            [self resetL N];
//            [self.tableMain reloadData];
        }
    }
}

//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
*/
#pragma mark - alert
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==33 && buttonIndex==1) {
        //del
        if (indexPathDelte.row<arrData.count) {
            [arrData removeObjectAtIndex:indexPathDelte.row];
            
            //删除动画
            [self.tableMain deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPathDelte] withRowAnimation:UITableViewRowAnimationAutomatic];
            
            [self resetLN];
            //            [self.tableMain reloadData];
        }
    }
}
#pragma mark - QWLocalNotifDelegate
- (void)QWLocalNotifDelegate:(id)LNDelegate{
    [self resetLN];
}

#pragma mark - 修改提醒数据
- (void)resetLN{
 
    [[QWLocalNotif instance] saveLNList:arrData];
    if (arrData.count==0) {
        [self noData];
    }
    [self setLocalNotifsList:arrData];
}

#pragma mark - 设置闹钟
- (void)setLocalNotifsList:(NSArray*)list{
    [[QWLocalNotif instance] setLocalNotifications:list ok:^{

    }];
}
@end
