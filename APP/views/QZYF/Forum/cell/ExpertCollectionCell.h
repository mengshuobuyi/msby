//
//  ExpertCollectionCell.h
//  APP
//
//  Created by Martin.Liu on 16/4/7.
//  Copyright © 2016年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAButtonWithTouchBlock.h"
@interface ExpertCollectionCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet MAButtonWithTouchBlock *careBtn;

- (void)setIndexPath:(NSIndexPath*)indexPath;
- (void)hiddenCareBtn:(BOOL)hidden;
- (void)setCell:(id)obj;
@end
