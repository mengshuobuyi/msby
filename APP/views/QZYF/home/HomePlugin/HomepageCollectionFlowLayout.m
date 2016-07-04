//
//  HomepageCollectionFlowLayout.m
//  APP
//
//  Created by garfield on 15/12/30.
//  Copyright © 2015年 carret. All rights reserved.
//

#import "HomepageCollectionFlowLayout.h"

@implementation HomepageCollectionFlowLayout


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.itemSize = CGSizeMake(APP_W / 4.0,92.0);
        self.minimumLineSpacing = 0.0f;
        self.minimumInteritemSpacing = 0.0f;
    }
    
    return self;
}


@end
