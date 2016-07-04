//
//  CusAnnotationView.m
//  MAMapKit_static_demo
//
//  Created by songjian on 13-10-16.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import "CusAnnotationView.h"
#import "CustomCalloutView.h"
#import "Constant.h"
#import "ZhPMethod.h"
#import "QWGlobalManager.h"

//#define kWidth  150.f
//#define kHeight 60.f
#define kWidth  21.f
#define kHeight 32.f

#define kHoriMargin 5.f
#define kVertMargin 5.f

#define kPortraitWidth  50.f
#define kPortraitHeight 50.f

#define kCalloutWidth   200.0
#define kCalloutHeight  70.0

@interface CusAnnotationView ()

@property (nonatomic, strong) UIImageView *portraitImageView;
@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation CusAnnotationView

@synthesize calloutView;
@synthesize portraitImageView   = _portraitImageView;
@synthesize nameLabel           = _nameLabel;

#pragma mark - Handle Action


#pragma mark - Override

- (NSString *)name
{
    return self.nameLabel.text;
}

- (void)setName:(NSString *)name
{
    self.nameLabel.text = name;
}

- (UIImage *)portrait
{
    return self.portraitImageView.image;
}

- (void)setPortrait:(UIImage *)portrait
{
    self.portraitImageView.image = portrait;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (selected)
    {
        if (self.calloutView == nil)
        {
            NSString * title = self.annTitle;
            CGSize size = [QWGLOBALMANAGER getTextSizeWithContent:title WithUIFont:fontSystem(16) WithWidth:APP_W-20];
            UIView * bgView = [[UIView alloc] init];
            
            CGFloat height = 8;
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10, height, size.width, size.height)];
            label.text = title;
            label.numberOfLines = 0;
            label.textColor = [UIColor whiteColor];
            label.font = fontSystem(16);
            [bgView addSubview:label];
            height += size.height + 8;
            
            [bgView setFrame:CGRectMake(0, 0, size.width + 20, height)];
            

            UIImage * redImage = [UIImage imageNamed:@"地图"];
            /* Construct custom callout. */
            self.calloutView = [[CustomCalloutView alloc] initWithFrame:CGRectMake(0, 0, bgView.frame.size.width, bgView.frame.size.height + 10)];
//            self.calloutView.layer.masksToBounds = YES;
//            self.calloutView.layer.cornerRadius = 3;
            self.calloutView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f + self.calloutOffset.x,-CGRectGetHeight(self.calloutView.bounds) / 2.f-(redImage.size.height/2));
            // + self.calloutOffset.y
            [self.calloutView addSubview:bgView];
            
            CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
            popAnimation.duration = 0.4;
            popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                                    [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                                    [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                                    [NSValue valueWithCATransform3D:CATransform3DIdentity]];
            popAnimation.keyTimes = @[@0.2f, @0.5f, @0.75f, @1.0f];
            popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                             [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                             [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
            [self.calloutView.layer addAnimation:popAnimation forKey:nil];
            
            
        }
        
        if (self.annTitle.length > 0) {
            [self addSubview:self.calloutView];
        }
    }
    else
    {
        [self.calloutView removeFromSuperview];
        self.calloutView = nil;
    }
    
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    BOOL inside = [super pointInside:point withEvent:event];
    /* Points that lie outside the receiver’s bounds are never reported as hits, 
     even if they actually lie within one of the receiver’s subviews. 
     This can occur if the current view’s clipsToBounds property is set to NO and the affected subview extends beyond the view’s bounds.
     */
    if (!inside && self.selected)
    {
        inside = [self.calloutView pointInside:[self convertPoint:point toView:self.calloutView] withEvent:event];
    }
    
    return inside;
}

#pragma mark - Life Cycle

- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        UIImage * redImage = [UIImage imageNamed:@"地图"];
        //self.bounds = RECT(0, 0, redImage.size.width*2, redImage.size.height*2);
        //[self setImage:redImage];
        self.iconView = [[UIImageView alloc] initWithFrame:RECT(0, -(redImage.size.height/2), redImage.size.width, redImage.size.height)];
        self.iconView.userInteractionEnabled = YES;
        [self.iconView setImage:redImage];
        [self addSubview:self.iconView];
        
        self.bounds = RECT(0, 0, redImage.size.width, redImage.size.height);
    }
    
    return self;
}

@end
