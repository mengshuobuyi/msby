//
//  MessageBoxListTwoViewController.m
//  APP
//
//  Created by PerryChen on 6/5/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "MessageBoxListTwoViewController.h"
#import "MsgConsultListViewController.h"
#import "MsgPharListViewController.h"
#import "MsgNotifyListViewController.h"
#import "ReturnIndexView.h"
#import "QWUnreadCountModel.h"
#import "PanGestureInteractiveTransition.h"

@interface PrivateTransitionContext : NSObject <UIViewControllerContextTransitioning>
- (instancetype)initWithFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController goingRight:(BOOL)goingRight; /// Designated initializer.
@property (nonatomic, copy) void (^completionBlock)(BOOL didComplete); /// A block of code we can set to execute after having received the completeTransition: message.
@property (nonatomic, assign, getter=isAnimated) BOOL animated; /// Private setter for the animated property.
@property (nonatomic, assign, getter=isInteractive) BOOL interactive; /// Private setter for the interactive property.
@end

@interface PrivateAnimatedTransition : NSObject <UIViewControllerAnimatedTransitioning>
@end

@interface MessageBoxListTwoViewController ()

@property (nonatomic, copy, readwrite) NSArray *vcArray;
@property (weak, nonatomic) IBOutlet UIButton *btnConsult;
@property (weak, nonatomic) IBOutlet UIButton *btnPharmacy;
@property (weak, nonatomic) IBOutlet UIButton *btnNotify;
@property (assign, nonatomic) NSInteger intVCSelected;
@property (weak, nonatomic) IBOutlet UIView *viewContainer;
@property (nonatomic, strong) UIViewController *vcCurSelected;

@property (nonatomic, weak) IBOutlet UIImageView *imgViewConsultNew;
@property (nonatomic, weak) IBOutlet UIImageView *imgViewPTPNew;
@property (nonatomic, weak) IBOutlet UIImageView *imgNotifyNew;

@property (weak, nonatomic) IBOutlet UIView *viewConsult;
@property (weak, nonatomic) IBOutlet UIView *viewPhar;
@property (weak, nonatomic) IBOutlet UIView *viewNotify;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewGreenLine;
@property (weak, nonatomic) IBOutlet UIView *viewTopBar;

@property (weak, nonatomic) IBOutlet UILabel *lblConsult;
@property (weak, nonatomic) IBOutlet UILabel *lblPhar;
@property (weak, nonatomic) IBOutlet UILabel *lblNotify;


@property (nonatomic, strong) MsgConsultListViewController *vcConsultList;
@property (nonatomic, strong) MsgPharListViewController *vcPharList;
@property (nonatomic, strong) MsgNotifyListViewController *vcNotiList;

@property (nonatomic, strong) ReturnIndexView *indexView;

@property (nonatomic, strong) PanGestureInteractiveTransition *defaultInteractionController;

- (IBAction)btnPressedChangeMsgType:(id)sender;

@end

@implementation MessageBoxListTwoViewController
- (void)updateNaveBar
{
    QWUnreadCountModel *modelUnread = [QWGLOBALMANAGER getUnreadModel];
    self.imgViewConsultNew.hidden = YES;
    self.imgViewPTPNew.hidden = YES;
    self.imgNotifyNew.hidden = YES;
//    if (modelUnread.bool_ConsultShouldShowRed) {
//        self.imgViewConsultNew.hidden = NO;
//    }
//    if (modelUnread.bool_PTPShouldShowRed) {
//        self.imgViewPTPNew.hidden = NO;
//    }
//    if (modelUnread.bool_NotiShouldShowRed) {
//        self.imgNotifyNew.hidden = NO;
//    }
    if ((self.intVCSelected == 0)&&[self.vcCurSelected isKindOfClass:[MsgConsultListViewController class]]) {
        self.imgViewConsultNew.hidden = YES;
    }
    if ((self.intVCSelected == 1)&&[self.vcCurSelected isKindOfClass:[MsgPharListViewController class]]) {
        self.imgViewConsultNew.hidden = YES;
    }
    if ((self.intVCSelected == 2)&&[self.vcCurSelected isKindOfClass:[MsgNotifyListViewController class]]) {
        self.imgViewConsultNew.hidden = YES;
    }
     
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.vcConsultList = [self.storyboard instantiateViewControllerWithIdentifier:@"MsgConsultListViewController"];
    self.vcPharList = [self.storyboard instantiateViewControllerWithIdentifier:@"MsgPharListViewController"];
    self.vcNotiList = [self.storyboard instantiateViewControllerWithIdentifier:@"MsgNotifyListViewController"];
    NSArray *tempArr = [NSArray arrayWithObjects:self.vcConsultList,self.vcPharList,self.vcNotiList, nil];
    self.vcArray = [tempArr copy];
    
    __weak typeof(self) wself = self;
    self.defaultInteractionController = [[PanGestureInteractiveTransition alloc] initWithGestureRecognizerInView:self.viewContainer recognizedBlock:^(UIPanGestureRecognizer *recognizer) {
        BOOL leftToRight = [recognizer velocityInView:recognizer.view].x > 0;
        if (self.vcCurSelected == nil) {
            return ;
        }
        NSUInteger currentVCIndex = [self.vcArray indexOfObject:self.vcCurSelected];
        if (!leftToRight && currentVCIndex != self.vcArray.count-1) {
            [wself setVcCurSelected:self.vcArray[currentVCIndex+1]];
        } else if (leftToRight && currentVCIndex > 0) {
            [wself setVcCurSelected:self.vcArray[currentVCIndex-1]];
        }
    }];
    NSInteger intSelectVC = QWGLOBALMANAGER.intSelectVCIndex;
    NSLog(@"%d",intSelectVC);
    self.vcCurSelected = (self.vcCurSelected ?: [self.vcArray objectAtIndex:intSelectVC]);
    self.intVCSelected = intSelectVC;
    [self updateTabbarStatus];
    [self setUpRightItem];
    self.navigationItem.title = @"消息盒子";
    [(MsgConsultListViewController *)self.vcCurSelected refreshContent];
    [(MsgPharListViewController *)self.vcCurSelected refreshContent];
    [(MsgNotifyListViewController *)self.vcCurSelected refreshContent];
    // Do any additional setup after loading the view.
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.vcCurSelected;
}

#pragma mark - Setup methods
- (void)setUpRightItem
{
    UIBarButtonItem *fixed = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixed.width = -6;
   
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon-unfold.PNG"] style:UIBarButtonItemStylePlain target:self action:@selector(returnIndex)];
    self.navigationItem.rightBarButtonItems = @[fixed,rightItem];
}
- (void)setAllMsgReaded
{
    NSArray *array =  [OfficialMessages getArrayFromDBWithWhere:nil];
    for (OfficialMessages *msg in array) {
        msg.issend = @"1";
        [OfficialMessages updateObjToDB:msg WithKey:msg.UUID];
    }
    NSArray *arrConsultList = [HistoryMessages getArrayFromDBWithWhere:nil];
    for (HistoryMessages *modelMsg in arrConsultList) {
        modelMsg.unreadCounts = @"0";
        modelMsg.systemUnreadCounts = @"0";
        if ([modelMsg.isShowRedPoint isEqualToString:@"1"]) {
            modelMsg.isShowRedPoint = @"0";
        }
        [HistoryMessages updateObjToDB:modelMsg WithKey:modelMsg.relatedid];
    }
    
    NSArray *arrP2PList = [PharMsgModel getArrayFromDBWithWhere:nil];
    for (PharMsgModel *modelPhar in arrP2PList) {
        modelPhar.unreadCounts = @"0";
        modelPhar.systemUnreadCounts = @"0";
        [PharMsgModel updateObjToDB:modelPhar WithKey:modelPhar.branchId];
    }
    
    QWUnreadCountModel *modelUnread = [QWGLOBALMANAGER getUnreadModel];
    self.imgViewConsultNew.hidden = YES;
    self.imgViewPTPNew.hidden = YES;
    self.imgNotifyNew.hidden = YES;
    modelUnread.count_CounsultUnread = @"0";
    modelUnread.count_NotiUnread = @"0";
    modelUnread.count_PTPUnread = @"0";
    modelUnread.bool_ConsultShouldShowRed = NO;
    modelUnread.bool_NotiShouldShowRed = NO;
    modelUnread.bool_PTPShouldShowRed = NO;
    [QWUnreadCountModel updateObjToDB:modelUnread WithKey:modelUnread.passport];
    
}
- (void)returnIndex
{
    self.indexView = [ReturnIndexView sharedManagerWithImage:@[@"icon home.PNG",@"icon mark.PNG"] title:@[@"首页",@"全部已读"] passValue:-1];
    self.indexView.delegate = self;
    [self.indexView show];
}
- (void)RetunIndexView:(ReturnIndexView *)ReturnIndexView didSelectedIndex:(NSIndexPath *)indexPath
{
    [self.indexView hide];
    if (indexPath.row == 0) {
        [self.navigationController popToRootViewControllerAnimated:YES];
        [self performSelector:@selector(delayPopToHome) withObject:nil afterDelay:0.01];
    } else if (indexPath.row == 1) {
        [self setAllMsgReaded];
    }
}

- (void)delayPopToHome
{
    [QWGLOBALMANAGER.tabBar setSelectedIndex:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnPressedChangeMsgType:(id)sender {
    UIButton *btnTapped = (UIButton *)sender;
    if (btnTapped == self.btnConsult) {
        self.intVCSelected = 0;
    } else if (btnTapped == self.btnPharmacy) {
        self.intVCSelected = 1;
    } else {
        self.intVCSelected = 2;
    }
    QWGLOBALMANAGER.intSelectVCIndex = self.intVCSelected;
    CGPoint pointToGo = CGPointZero;
    if (self.intVCSelected == 0) {
        pointToGo = self.viewConsult.center;
    } else if (self.intVCSelected == 1) {
        pointToGo = self.viewPhar.center;
    } else {
        pointToGo = self.viewNotify.center;
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.imgViewGreenLine.center = pointToGo;
        
    } completion:^(BOOL finished) {
        UIViewController *selectedViewController =  self.vcArray[self.intVCSelected];
        self.vcCurSelected = selectedViewController;
        if ([self.delegate respondsToSelector:@selector (containerViewController:didSelectViewController:)]) {
            [self.delegate containerViewController:self didSelectViewController:selectedViewController];
        }
        [self updateNaveBar];
        [self updateTopbarButtonsStatus];
    }];
}

- (void)vcChanged
{
    QWUnreadCountModel *modelUnread = [QWGLOBALMANAGER getUnreadModel];
    if (self.intVCSelected == 0) {
        modelUnread.bool_ConsultShouldShowRed = NO;
        [(MsgConsultListViewController *)self.vcCurSelected refreshContent];
    } else if (self.intVCSelected == 1) {
        modelUnread.bool_PTPShouldShowRed = NO;
        [(MsgPharListViewController *)self.vcCurSelected refreshContent];
    } else {
        modelUnread.bool_NotiShouldShowRed = NO;
        [(MsgNotifyListViewController *)self.vcCurSelected refreshContent];
    }
    [QWUnreadCountModel updateObjToDB:modelUnread WithKey:modelUnread.passport];
    
    [self updateNaveBar];
}

- (void)setVcCurSelected:(UIViewController *)vcCurSelected
{
    NSParameterAssert (vcCurSelected);
    [self _transitionToChildViewController:vcCurSelected];
}

- (void)_transitionToChildViewController:(UIViewController *)toViewController {
    UIViewController *fromViewController = self.vcCurSelected;
    if (toViewController == fromViewController || ![self isViewLoaded]) {
        return;
    }
    
    UIView *toView = toViewController.view;
    //    	[toView setTranslatesAutoresizingMaskIntoConstraints:YES];
    //    	toView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    toView.frame = self.viewContainer.bounds;
    
    [fromViewController willMoveToParentViewController:nil];
    [self addChildViewController:toViewController];
    
    if (!fromViewController) {
        [self.viewContainer addSubview:toViewController.view];
        [toViewController didMoveToParentViewController:self];
        [self _finishTransitionToChildViewController:toViewController];
        return;
    }
    
    id<UIViewControllerAnimatedTransitioning>animator = nil;
    if ([self.delegate respondsToSelector:@selector (containerViewController:animationControllerForTransitionFromViewController:toViewController:)]) {
        animator = [self.delegate containerViewController:self animationControllerForTransitionFromViewController:fromViewController toViewController:toViewController];
    }
    animator = (animator ?: [[PrivateAnimatedTransition alloc] init]);
    
    NSUInteger fromIndex = [self.vcArray indexOfObject:fromViewController];
    NSUInteger toIndex = [self.vcArray indexOfObject:toViewController];
    PrivateTransitionContext *transitionContext = [[PrivateTransitionContext alloc] initWithFromViewController:fromViewController toViewController:toViewController goingRight:toIndex > fromIndex];
    
    transitionContext.animated = YES;
    
    id<UIViewControllerInteractiveTransitioning> interactionController = [self _interactionControllerForAnimator:animator];
    
    transitionContext.interactive = (interactionController != nil);
    transitionContext.completionBlock = ^(BOOL didComplete) {
        
        if (didComplete) {
            [fromViewController.view removeFromSuperview];
            [fromViewController removeFromParentViewController];
            [toViewController didMoveToParentViewController:self];
            [self _finishTransitionToChildViewController:toViewController];
            
        } else {
            [toViewController.view removeFromSuperview];
        }
        
        if ([animator respondsToSelector:@selector (animationEnded:)]) {
            [animator animationEnded:didComplete];
        }
        self.viewTopBar.userInteractionEnabled = YES;
    };
    self.viewTopBar.userInteractionEnabled = NO;
    if ([transitionContext isInteractive]) {
        [interactionController startInteractiveTransition:transitionContext];
    } else {
        [animator animateTransition:transitionContext];
//        [self _finishTransitionToChildViewController:toViewController];
    }
    
}

- (void)updateTabbarStatus
{
    CGPoint pointToGo = CGPointZero;
    if (self.intVCSelected == 0) {
        pointToGo = self.viewConsult.center;
    } else if (self.intVCSelected == 1) {
        pointToGo = self.viewPhar.center;
    } else {
        pointToGo = self.viewNotify.center;
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.imgViewGreenLine.center = pointToGo;
        
    } completion:^(BOOL finished) {
        
        self.imgViewGreenLine.center = pointToGo;
        [self updateTopbarButtonsStatus];
        
    }];
}

- (void)updateTopbarButtonsStatus
{
    self.lblConsult.textColor = RGBHex(kColor12);
    self.lblPhar.textColor = RGBHex(kColor12);
    self.lblNotify.textColor = RGBHex(kColor12);
    if (self.intVCSelected == 0) {
        self.lblConsult.textColor = RGBHex(kColor3);
    } else if (self.intVCSelected == 1) {
        self.lblPhar.textColor = RGBHex(kColor3);
    } else {
        self.lblNotify.textColor = RGBHex(kColor3);
    }
    
}

- (void)_finishTransitionToChildViewController:(UIViewController *)toViewController {
    _vcCurSelected = toViewController;
    NSInteger intSelect = [self.vcArray indexOfObject:_vcCurSelected];
    self.intVCSelected = intSelect;
    QWGLOBALMANAGER.intSelectVCIndex = intSelect;
    [self updateTabbarStatus];
    [self vcChanged];
    // TODO: need modify
}

- (id<UIViewControllerInteractiveTransitioning>)_interactionControllerForAnimator:(id<UIViewControllerAnimatedTransitioning>)animationController {
    
    if (self.defaultInteractionController.recognizer.state == UIGestureRecognizerStateBegan) {
        self.defaultInteractionController.animator = animationController;
        return self.defaultInteractionController;
    } else {
        return nil;
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


#pragma mark - Private Transitioning Classes

@interface PrivateTransitionContext ()
@property (nonatomic, strong) NSDictionary *privateViewControllers;
@property (nonatomic, assign) CGRect privateDisappearingFromRect;
@property (nonatomic, assign) CGRect privateAppearingFromRect;
@property (nonatomic, assign) CGRect privateDisappearingToRect;
@property (nonatomic, assign) CGRect privateAppearingToRect;
@property (nonatomic, weak) UIView *containerView;
@property (nonatomic, assign) UIModalPresentationStyle presentationStyle;
@property (nonatomic, assign) BOOL transitionWasCancelled;
@end

@implementation PrivateTransitionContext

- (instancetype)initWithFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController goingRight:(BOOL)goingRight {
    NSAssert ([fromViewController isViewLoaded] && fromViewController.view.superview, @"The fromViewController view must reside in the container view upon initializing the transition context.");
    
    if ((self = [super init])) {
        self.presentationStyle = UIModalPresentationCustom;
        self.containerView = fromViewController.view.superview;
        _transitionWasCancelled = NO;
        self.privateViewControllers = @{
                                        UITransitionContextFromViewControllerKey:fromViewController,
                                        UITransitionContextToViewControllerKey:toViewController,
                                        };
        
        // Set the view frame properties which make sense in our specialized ContainerViewController context. Views appear from and disappear to the sides, corresponding to where the icon buttons are positioned. So tapping a button to the right of the currently selected, makes the view disappear to the left and the new view appear from the right. The animator object can choose to use this to determine whether the transition should be going left to right, or right to left, for example.
        CGFloat travelDistance = (goingRight ? -self.containerView.bounds.size.width : self.containerView.bounds.size.width);
        self.privateDisappearingFromRect = self.privateAppearingToRect = self.containerView.bounds;
        self.privateDisappearingToRect = CGRectOffset (self.containerView.bounds, travelDistance, 0);
        self.privateAppearingFromRect = CGRectOffset (self.containerView.bounds, -travelDistance, 0);
    }
    
    return self;
}

- (CGRect)initialFrameForViewController:(UIViewController *)viewController {
    if (viewController == [self viewControllerForKey:UITransitionContextFromViewControllerKey]) {
        return self.privateDisappearingFromRect;
    } else {
        return self.privateAppearingFromRect;
    }
}

- (CGRect)finalFrameForViewController:(UIViewController *)viewController {
    if (viewController == [self viewControllerForKey:UITransitionContextFromViewControllerKey]) {
        return self.privateDisappearingToRect;
    } else {
        return self.privateAppearingToRect;
    }
}

- (UIViewController *)viewControllerForKey:(NSString *)key {
    return self.privateViewControllers[key];
}

- (void)completeTransition:(BOOL)didComplete {
    if (self.completionBlock) {
        self.completionBlock (didComplete);
    }
}

//- (BOOL)transitionWasCancelled { return NO; } // Our non-interactive transition can't be cancelled (it could be interrupted, though)

// Supress warnings by implementing empty interaction methods for the remainder of the protocol:

- (void)updateInteractiveTransition:(CGFloat)percentComplete {}
- (void)finishInteractiveTransition {self.transitionWasCancelled = NO;}
- (void)cancelInteractiveTransition {self.transitionWasCancelled = YES;}

@end

@implementation PrivateAnimatedTransition

static CGFloat const kChildViewPadding = 16;
static CGFloat const kDamping = 0.75;
static CGFloat const kInitialSpringVelocity = 0.5;

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

/// Slide views horizontally, with a bit of space between, while fading out and in.
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    // When sliding the views horizontally in and out, figure out whether we are going left or right.
    BOOL goingRight = ([transitionContext initialFrameForViewController:toViewController].origin.x < [transitionContext finalFrameForViewController:toViewController].origin.x);
    CGFloat travelDistance = [transitionContext containerView].bounds.size.width + kChildViewPadding;
    CGAffineTransform travel = CGAffineTransformMakeTranslation (goingRight ? travelDistance : -travelDistance, 0);
    
    [[transitionContext containerView] addSubview:toViewController.view];
    toViewController.view.alpha = 0;
    toViewController.view.transform = CGAffineTransformInvert (travel);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:kDamping initialSpringVelocity:kInitialSpringVelocity options:0x00 animations:^{
        fromViewController.view.transform = travel;
        fromViewController.view.alpha = 0;
        toViewController.view.transform = CGAffineTransformIdentity;
        toViewController.view.alpha = 1;
    } completion:^(BOOL finished) {
        fromViewController.view.transform = CGAffineTransformIdentity;
        fromViewController.view.alpha = 1;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end


