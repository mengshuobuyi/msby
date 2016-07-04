
#import <UIKit/UIKit.h>

/**
 A drop-in replacement for UIPercentDrivenInteractiveTransition
 for use in custom container view controllers
 
 @see UIPercentDrivenInteractiveTransition
 */
@interface AWPercentDrivenInteractiveTransition : NSObject <UIViewControllerInteractiveTransitioning>

- (instancetype)initWithAnimator:(id<UIViewControllerAnimatedTransitioning>)animator;

@property (nonatomic, readonly) CGFloat duration;
@property (readonly) CGFloat percentComplete;

/**
 The animated transitioning that this percent driven interaction should control.
 This property must be set prior to the start of a transition.
 */
@property (nonatomic, weak) id<UIViewControllerAnimatedTransitioning>animator;

@property (nonatomic, readonly) CGFloat completionSpeed; // Only works for completionSpeed = 1
// Not yet implemented
// @property (nonatomic, assign) UIViewAnimationCurve animationCurve;

- (void)updateInteractiveTransition:(CGFloat)percentComplete;
- (void)cancelInteractiveTransition;
- (void)finishInteractiveTransition;

@end
