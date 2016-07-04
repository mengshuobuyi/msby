

#import "AWPercentDrivenInteractiveTransition.h"
@interface PanGestureInteractiveTransition : AWPercentDrivenInteractiveTransition

- (id)initWithGestureRecognizerInView:(UIView *)view recognizedBlock:(void (^)(UIPanGestureRecognizer *recognizer))gestureRecognizedBlock;

@property (nonatomic, readonly) UIPanGestureRecognizer *recognizer;
@property (nonatomic, copy) void (^gestureRecognizedBlock)(UIPanGestureRecognizer *recognizer);

@end
