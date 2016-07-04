//
//  StoreExpertTableCell.h
//  APP
//
//  Created by Martin.Liu on 16/6/20.
//  Copyright © 2016年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,MARCellLocation) {
    MARCellLocationNone,
    MARCellLocationTop    = 1 << 1,
//    MARCellLocationCenter = 1 << 2,
    MARCellLocationBottom = 1 << 3,
};

@interface StoreExpertTableCell : UITableViewCell

- (void) setCell:(id)obj location:(MARCellLocation)locations;

@end
