//
//  TouchTableView.h
//  APP
//
//  Created by qw_imac on 15/12/31.
//  Copyright © 2015年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TouchTableViewDelegate <NSObject>

@optional

- (void)tableView:(UITableView *)tableView touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;

- (void)tableView:(UITableView *)tableView touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;

- (void)tableView:(UITableView *)tableView touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;

- (void)tableView:(UITableView *)tableView touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;

@end
@interface TouchTableView : UITableView{
    CGPoint gestureStartPoint;
}

@property (nonatomic,assign) id<TouchTableViewDelegate> touchDelegate;
@property (nonatomic,copy) void(^changePage)();

@end
