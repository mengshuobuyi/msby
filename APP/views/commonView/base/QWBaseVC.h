//
//  basePage.h
//  Show
//
//  Created by YAN Qingyang on 15-2-11.
//  Copyright (c) 2015年 YAN Qingyang. All rights reserved.
//

#import "QWBaseViewController.h"
#import "MBProgressHUD.h"
#import "Constant.h"
#import "QWGlobalManager.h"
#import "MJRefresh.h"
#import "UMSocial.h"
//#import "UIScrollView+MJRefreshExt.h"
//#import "MJRefreshFooterView+MJFooterNoData.h"
#import "Notification.h"
#import "ShareContentModel.h"
#import "SRRefreshView.h"
#import "MyTableView.h"
#import "SystemModelR.h"

typedef void (^CallBack) (BOOL finished);



@interface QWBaseVC : QWBaseViewController
<MBProgressHUDDelegate,UITextFieldDelegate,UIScrollViewDelegate,UIAlertViewDelegate,UIActionSheetDelegate>
{
    MBProgressHUD *HUD;
    
    IBOutlet UIButton *btnPopVC;
}

@property (nonatomic, strong) UIButton* LeftItemBtn;
@property (nonatomic, strong) UIButton* RightItemBtn;

@property (nonatomic, strong) UIView *vInfo;
@property (nonatomic, strong) IBOutlet UITableView               *tableMain;
/* delegate */
@property (nonatomic, assign) id delegate;
@property (strong, nonatomic) NSMutableArray *refreshTops;
/**
 *  传递需要返回到的页面位置
 */
@property (nonatomic, assign) id delegatePopVC;

@property (assign) BOOL backButtonEnabled;

/**
 *  app的UI全局设置，包括背景色，top bar背景等
 */
- (void)UIGlobal;

/**
 *  获取全局通知
 *
 *  @param type 通知类型
 *  @param data 数据
 *  @param obj  通知来源
 */
- (void)getNotifType:(Enum_Notification_Type)type data:(id)data target:(id)obj;

/**
 *  touch up inside动作，返回上一页
 *
 *  @param sender 触发返回动作button
 */
- (IBAction)popVCAction:(id)sender;

/**
 *  创建统一标准返回按钮
 *
 */
- (void)naviBackBotton;
/**
 *  等待并显示文字
 *
 *  @param msg 文字
 */
- (void)showLoadingWithMessage:(NSString*)msg;
/**
 *  关闭等待
 */
- (void)didLoad;

/**
 *  显示成功/失败
 *
 *  @param msg 文字
 */
- (void)showSuccess:(NSString *)msg;
- (void)showSuccess:(NSString *)msg completion:(CallBack)completion;
- (void)showError:(NSString *)msg;
- (void)enableSimpleRefresh:(UIScrollView *)scrollView  block:(SRRefreshBlock)block;
- (void)endHeaderRefresh;
- (void)removeSimpleRefresh;
/**
 *  显示提示信息
 *
 *  @param txt 显示内容
 */
- (void)showText:(NSString*)txt;

/**
 *  显示提示信息
 *
 *  @param txt   内容
 *  @param delay 延迟几秒后消失
 */
- (void)showText:(NSString*)txt delay:(double)delay;

/**
 *  显示错误信息
 *
 *  @param error 错误对象
 */
- (void)showErrorMessage:(NSError*)error;

/**
 *  调试用
 *
 *  @param msg 多字符串参数，结尾加nil
 */
- (void)showLog:(NSString*)msg, ...;


- (void)zoomClick;
- (void)backToPreviousController:(id)sender;

//滑动

- (void)viewDidCurrentView;

/**
 *  导航栏加空格
 *
 */
- (void)naviSpaceWidth:(float)width pos:(UIRectEdge)edge;

/**
 *  导航栏标题
 *
 *  @param vTitle <#vTitle description#>
 *
 *  @return <#return value description#>
 */
- (id)naviTitleView:(UIView*)vTitle;
//- (id)naviTitleView:(UIView*)vTitle width:(float)width;
/**
 *  是否联网
 *
 *  @return <#return value description#>
 */
- (BOOL)isNetWorking;
/**
 *  显示无数据状态，断网状态，需要登录提示
 *
 *  @param text      说明文字
 *  @param imageName 图片名字

 */
-(void)showInfoView:(NSString *)text image:(NSString*)imageName;

-(void)showInfoInView:(UITableView *)showView
           offsetSize:(CGFloat)offset
                 text:(NSString *)text
                image:(NSString*)imageName;

// *  @return 返回蒙层,可以自定义添加别的控件
-(UIView *)showInfoView:(NSString *)text image:(NSString*)imageName tag:(NSInteger)tag;
//立即登录背景提示
- (void)showLoginView:(NSString *)str image:(NSString *)imageName action:(SEL)selector;
/**
 *  移除上面的东西
 */
- (void)removeInfoView;

/**
 *  点击后调用该空方法
 *
 *  @param sender nil
 */
- (IBAction)viewInfoClickAction:(id)sender;

- (void)naviRightBotton:(NSString*)aTitle action:(SEL)action;
- (void)naviLeftBottonImage:(UIImage*)aImg highlighted:(UIImage*)hImg action:(SEL)action;
- (void)naviRightBottonImage:(NSString *)imageStr action:(SEL)action;

/**
 用于修改导航栏颜色以及显示或隐藏分割线
 @param color     导航栏颜色，如果传空值则显示白色
 @param Shadow    导航栏分割线，YES显示，NO不显示
 */
- (void)setNavigationBarColor:(UIColor *)color Shadow:(BOOL)flag;
/**
 判断数组里对象是否包含某个值，返回值判断isNotFound
 @param key     数组中对象里的某个需要判断的属性
 @param value   值
 @param arrOri  判断的数组
 */
- (NSUInteger)valueExists:(NSString *)key withValue:(NSString *)value withArr:(NSMutableArray *)arrOri;

/**
 对数组根据包含的对象的某个值进行排序
 @param key   数组中对象进行排序的属性
 @param isAscend  是否升序排列
 @param oriArr   进行排序的数组
 */
- (NSMutableArray *)sortArrWithKey:(NSString *)strKey isAscend:(BOOL)isAscend oriArray:(NSMutableArray *)oriArr;

- (BOOL)checkTotal:(NSInteger)total pageSize:(NSInteger)pSize pageNum:(NSInteger)pNum;

/**
 弹出分享界面
 */
- (void)shareService:(ShareContentModel *)modelShare;
- (void)popUpShareView:(ShareContentModel *)modelShare;

- (void)callSaveLogRequest:(RptShareSaveLogModelR *)modelSave;

- (void)shareFeedbackSuccess;
- (void)shareFeedbackFailed;

- (void)reloadDataAfterShare;

/**
*   加入购物车动画
*/
@property (nonatomic,strong) CALayer *dotLayer;
@property (nonatomic,assign) CGPoint EndPoint;
@property (nonatomic,strong) UIBezierPath *path;

-(void)JoinCartAnimationWithStratPoint:(CGPoint)sPoint endPoint:(CGPoint)EPoint middlePoint:(CGPoint)MPoint withImage:(UIImage *)image;

- (void)removeFromLayer:(CALayer *)layerAnimation;


// 自定义点击顶部事件
- (void)clickStatusBar;

@end
