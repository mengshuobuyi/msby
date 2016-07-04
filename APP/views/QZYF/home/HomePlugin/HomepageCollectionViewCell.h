//
//  HomepageCollectionViewCell.h
//  APP
//
//  Created by garfield on 15/12/30.
//  Copyright © 2015年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomepageCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) IBOutlet UIImageView  *itemImage;
@property (nonatomic, strong) IBOutlet UILabel      *itemLabel;

- (void)setCellData:(id)data;

@end
