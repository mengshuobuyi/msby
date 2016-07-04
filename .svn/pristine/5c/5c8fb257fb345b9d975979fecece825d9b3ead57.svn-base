//
//  RatingViewController.h
//  RatingController
//
//  Created by Ajay on 2/28/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RatingViewDelegate
-(void)ratingChanged:(float)newRating;
-(void)ratingChangeEnded:(float)newRating;
@optional
-(void)ratingTouchedWithTag:(NSInteger)touchTag;
@end


@interface RatingView : UIView {
	UIImageView *s1, *s2, *s3, *s4, *s5;
	UIImage *unselectedImage, *partlySelectedImage, *fullySelectedImage;

	float starRating, lastRating;
	float height, width; // of each image of the star!
}


@property (nonatomic,assign) id<RatingViewDelegate> viewDelegate;
@property (nonatomic, retain) UIImageView *s1;
@property (nonatomic, retain) UIImageView *s2;
@property (nonatomic, retain) UIImageView *s3;
@property (nonatomic, retain) UIImageView *s4;
@property (nonatomic, retain) UIImageView *s5;
@property (nonatomic, assign) BOOL showFullImage;

-(void)setImagesDeselected:(NSString *)unselectedImage partlySelected:(NSString *)partlySelectedImage 
			  fullSelected:(NSString *)fullSelectedImage andDelegate:(id<RatingViewDelegate>)d;
-(void)setFullImagesDeselected:(NSString *)unselectedImage
                  fullSelected:(NSString *)fullSelectedImage andDelegate:(id<RatingViewDelegate>)d;
-(void)displayRating:(float)rating;
-(float)rating;

@end
