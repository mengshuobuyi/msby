//
//  HomepageCollectionView.m
//  APP
//
//  Created by garfield on 15/12/30.
//  Copyright © 2015年 carret. All rights reserved.
//

#import "HomepageCollectionView.h"
#import "HomepageCollectionViewCell.h"
#import "ConfigInfoModel.h"

static NSString *const CollectionViewCellIdentifier = @"CollectionViewCellIdentifier";


@implementation HomepageCollectionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.backgroundColor = [UIColor whiteColor];
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    [self registerNib:[UINib nibWithNibName:@"HomepageCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:CollectionViewCellIdentifier];
    self.dataSource = self;
    self.delegate = self;
}

- (void)setWeChatBusiness:(BOOL)weChatBusiness
{
    _weChatBusiness = weChatBusiness;
    [self reloadData];
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if([self.collectionDelegate respondsToSelector:@selector(numberOfItemsInHomepageCollectionView)])
        return [self.collectionDelegate numberOfItemsInHomepageCollectionView];
    else
        return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomepageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewCellIdentifier forIndexPath:indexPath];
    if([self.collectionDelegate respondsToSelector:@selector(contentForHomepageIndexPath:)])
    {
        TemplatePosVoModel *model = [self.collectionDelegate contentForHomepageIndexPath:indexPath];
        [cell setCellData:model];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.collectionDelegate respondsToSelector:@selector(collectionViewHomepage:didSelectAtIndexPath:)]){
        [self.collectionDelegate collectionViewHomepage:self didSelectAtIndexPath:indexPath];
    }
}

#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(APP_W / 4.0, 92);
}

@end
