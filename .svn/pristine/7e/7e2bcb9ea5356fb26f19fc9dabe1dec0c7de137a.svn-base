//
//  HomepageCollectionView.h
//  APP
//
//  Created by garfield on 15/12/30.
//  Copyright © 2015年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TemplatePosVoModel;

@protocol HomepageCollectionViewDelegate <UICollectionViewDelegate>

@optional

- (NSUInteger)numberOfItemsInHomepageCollectionView;
- (id)contentForHomepageIndexPath:(NSIndexPath *)indexPath;
- (void)collectionViewHomepage:(UICollectionView *)collectionView didSelectAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface HomepageCollectionView : UICollectionView<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, assign) id<HomepageCollectionViewDelegate>    collectionDelegate;
@property (nonatomic, assign) BOOL                                  weChatBusiness;
@end
