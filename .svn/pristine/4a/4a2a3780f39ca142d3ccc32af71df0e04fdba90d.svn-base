//
//  CustomAnnotationView.m
//  CustomAnnotationDemo
//
//  Created by songjian on 13-3-11.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import "CustomAnnotationView.h"
#import <MAMapKit/MAPointAnnotation.h>
#import "DetailLocationCalloutView.h"

#define kWidth  30.f
#define kHeight 30.f

#define kHoriMargin 5.f
#define kVertMargin 5.f

#define kPortraitWidth  50.f
#define kPortraitHeight 50.f

#define kCalloutWidth   200.0
#define kCalloutHeight  70.0

@interface CustomAnnotationView ()

@property (nonatomic, strong) UIImageView *portraitImageView;
@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation CustomAnnotationView
@synthesize calloutView;
@synthesize portraitImageView   = _portraitImageView;
@synthesize nameLabel           = _nameLabel;

#pragma mark - Interface

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

#pragma mark - Override

- (void)prepareForReuse
{
    [super prepareForReuse];
}

- (void)setSelected:(BOOL)selected
{
    [self setSelected:selected animated:NO];
}


#pragma mark - Life Cycle

- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.bounds = CGRectMake(0.f, 0.f, kWidth, kHeight);
        
        self.backgroundColor = [UIColor clearColor];
        
        /* Create portrait image view and add to view hierarchy. */
        self.portraitImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:self.portraitImageView];
        DetailLocationCalloutView *detailCalloutView = [[DetailLocationCalloutView alloc] initWithFrame:CGRectZero];
        detailCalloutView.addressDescription = [(MAPointAnnotation *)self.annotation title];
        self.calloutView = detailCalloutView;
        [self addSubview:self.calloutView];
    }
    
    return self;
}


@end
