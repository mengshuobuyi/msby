//
//  TouchTableView.m
//  APP
//
//  Created by qw_imac on 15/12/31.
//  Copyright © 2015年 carret. All rights reserved.
//

#import "TouchTableView.h"
#define kMinimumGestureLength 20.0f
@implementation TouchTableView
@synthesize touchDelegate = _touchDelegate;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    
    gestureStartPoint = [touch locationInView:self];//开始触摸
    
    if ([_touchDelegate conformsToProtocol:@protocol(TouchTableViewDelegate)] &&
        [_touchDelegate respondsToSelector:@selector(tableView:touchesBegan:withEvent:)])
    {
        [_touchDelegate tableView:self touchesBegan:touches withEvent:event];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    if ([_touchDelegate conformsToProtocol:@protocol(TouchTableViewDelegate)] &&
        [_touchDelegate respondsToSelector:@selector(tableView:touchesCancelled:withEvent:)])
    {
        [_touchDelegate tableView:self touchesCancelled:touches withEvent:event];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint currentPosition = [touch locationInView:self];
    CGFloat deltaX = fabs(gestureStartPoint.x - currentPosition.x);
    
    if (deltaX >= kMinimumGestureLength){
        if (self.changePage) {
            self.changePage();
        }
    }
    if ([_touchDelegate conformsToProtocol:@protocol(TouchTableViewDelegate)] &&
        [_touchDelegate respondsToSelector:@selector(tableView:touchesEnded:withEvent:)])
    {
        [_touchDelegate tableView:self touchesEnded:touches withEvent:event];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    if ([_touchDelegate conformsToProtocol:@protocol(TouchTableViewDelegate)] &&
        [_touchDelegate respondsToSelector:@selector(tableView:touchesMoved:withEvent:)])
    {
        [_touchDelegate tableView:self touchesMoved:touches withEvent:event];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
