//
//  StoreDetailHeadView.m
//  APP
//
//  Created by Meng on 15/6/4.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "StoreDetailHeadView.h"
#import "UIView+LoadFromNib.h"

#import "StoreModel.h"

#define kImageWidth  13
#define kLabelWidth1 47
#define kLabelWidth2 16
#define kHeigth      25

#define kTagLabelFont 10


@interface StoreDetailHeadView()
//UIView

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *LineViewHeightConstant;


@end

@implementation StoreDetailHeadView

- (void)layoutTagsWith:(NSArray *)tagArray
{
    
    CGFloat x = -7;
//    UIImage *image = [UIImage imageNamed:@"小图标打钩"]; 
    for (int i = 0; i<tagArray.count; i++) {
        StoreNearByTagModel *tagModel = [tagArray objectAtIndex:i];
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, 0, kImageWidth, kImageWidth)];
//        imageView.image = image;
//        [self.bgView addSubview:imageView];
        
        x += 8;
        
        UILabel *tagLabel = [[UILabel alloc] init];
        CGFloat tagWidth = 0;
        if ([tagModel.key isEqualToString:@"1"]) {//24H
            tagWidth = kLabelWidth2;
        }else{
            tagWidth = kLabelWidth1;
        }
        [tagLabel setFrame:CGRectMake(x, 0, kLabelWidth1, kHeigth)];
        tagLabel.font = fontSystem(kTagLabelFont);
        tagLabel.text = tagModel.tag;
        tagLabel.textAlignment = NSTextAlignmentCenter;
        tagLabel.backgroundColor = [UIColor clearColor];
        tagLabel.textColor = RGBHex(qwColor4);
        tagLabel.layer.masksToBounds = YES;
        tagLabel.layer.cornerRadius = 2.0f;
        tagLabel.layer.borderWidth = 0.5f;
        tagLabel.layer.borderColor = RGBHex(qwColor4).CGColor;
        [self.bgView addSubview:tagLabel];
        x += kLabelWidth1;
    }
    
//    UIImageView *imageView    = [[UIImageView alloc] initWithFrame:CGRectMake(x, 0, kImageWidth, kImageWidth)];
//    imageView.image = image;
//    [self.bgView addSubview:imageView];
    
    x += 8;
    
    UILabel *tagLabel = [[UILabel alloc] init];
    [tagLabel setFrame:CGRectMake(x, 0, kLabelWidth1, kHeigth)];
    tagLabel.font = fontSystem(kTagLabelFont);
    tagLabel.text = @"免费咨询";
    tagLabel.textAlignment = NSTextAlignmentCenter;
    tagLabel.backgroundColor = [UIColor clearColor];
    tagLabel.textColor = RGBHex(qwColor4);
    tagLabel.layer.masksToBounds = YES;
    tagLabel.layer.cornerRadius = 2.0f;
    tagLabel.layer.borderWidth = 0.5f;
    tagLabel.layer.borderColor = RGBHex(qwColor4).CGColor;
    [self.bgView addSubview:tagLabel];
    x += kLabelWidth1;

    self.bgViewWidth.constant = x;
}

- (void)UITags:(NSArray *)tags{
    
    CGFloat x = -7;
    //    UIImage *image = [UIImage imageNamed:@"小图标打钩"];
    for (int i = 0; i<tags.count; i++) {
        StoreNearByTagModel *model = tags[i];
        //        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, 0, kImageWidth, kImageWidth)];
        //        imageView.image = image;
        //        [self.bgView addSubview:imageView];
        
        x += 8;
        
        UILabel *tagLabel = [[UILabel alloc] init];
 
    
        [tagLabel setFrame:CGRectMake(x, 0, kLabelWidth1, kHeigth)];
        tagLabel.font = fontSystem(kFontS6);
        if([model.tag isEqualToString:@""]){
            tagLabel.text = @"RT";
        }else{
            tagLabel.text = model.tag;
        }
        
        tagLabel.textAlignment = NSTextAlignmentCenter;
        tagLabel.backgroundColor = [UIColor clearColor];
        tagLabel.textColor = RGBHex(qwColor4);
        tagLabel.layer.masksToBounds = YES;
        tagLabel.layer.cornerRadius = 2.0f;
        tagLabel.layer.borderWidth = 0.5f;
        tagLabel.layer.borderColor = RGBHex(qwColor4).CGColor;
        [self.bgView addSubview:tagLabel];
        x += kLabelWidth1;
    }
    
    //    UIImageView *imageView    = [[UIImageView alloc] initWithFrame:CGRectMake(x, 0, kImageWidth, kImageWidth)];
    //    imageView.image = image;
    //    [self.bgView addSubview:imageView];
    
    x += 8;
    
    UILabel *tagLabel = [[UILabel alloc] init];
    [tagLabel setFrame:CGRectMake(x, 0, kLabelWidth1, kHeigth)];
    tagLabel.font = fontSystem(kFontS6);
    tagLabel.text = @"免费咨询";
    tagLabel.textAlignment = NSTextAlignmentCenter;
    tagLabel.backgroundColor = [UIColor clearColor];
    tagLabel.textColor = RGBHex(qwColor4);
    tagLabel.layer.masksToBounds = YES;
    tagLabel.layer.cornerRadius = 2.0f;
    tagLabel.layer.borderWidth = 0.5f;
    tagLabel.layer.borderColor = RGBHex(qwColor4).CGColor;
    [self.bgView addSubview:tagLabel];
    x += kLabelWidth1;
    
    self.bgViewWidth.constant = x;
}


- (void)awakeFromNib
{
    self.LineViewHeightConstant.constant = 0.5f;
    [self.titleLabel systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    self.titleLabel.font = fontSystem(kFontS2);
    self.clipsToBounds = YES;
    self.titleLabel.backgroundColor = [UIColor clearColor];
    
    [self.addressButton setTitleColor:RGBHex(qwColor8) forState:UIControlStateNormal];
    self.addressButton.titleLabel.font = fontSystem(kFontS5);
}

@end
