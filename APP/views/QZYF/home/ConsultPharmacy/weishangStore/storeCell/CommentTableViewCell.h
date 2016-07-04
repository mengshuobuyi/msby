//
//  CommentTableViewCell.h
//  APP
//
//  Created by 李坚 on 16/4/18.
//  Copyright © 2016年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *serviceScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodScoreLabel;

+ (CGFloat)getCellHeight:(id)data;

@end
