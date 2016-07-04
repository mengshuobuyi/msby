//
//  LeveyPopListView.h
//  LeveyPopListViewDemo
//
//  Created by Levey on 2/21/12.
//  Copyright (c) 2012 Levey. All rights reserved.
//


@protocol LeveyPopListViewDelegate;
@interface LeveyPopListViewNew : UIView <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
    NSString *_title;
    NSArray *_options;
}
@property (nonatomic ,strong)UIView *addMemberView;
@property (nonatomic ,strong)UIView *insertFootView;
@property (nonatomic, assign) NSInteger            selectedIndex;
@property (nonatomic, assign) id<LeveyPopListViewDelegate> delegate;

// The options is a NSArray, contain some NSDictionaries, the NSDictionary contain 2 keys, one is "img", another is "text".
- (id)initWithTitle:(NSString *)aTitle options:(NSArray *)aOptions;
// If animated is YES, PopListView will be appeared with FadeIn effect.
- (void)showInView:(UIView *)aView animated:(BOOL)animated;
@end

@protocol LeveyPopListViewDelegate <NSObject>
- (void)leveyPopListView:(LeveyPopListViewNew *)popListView didSelectedIndex:(NSInteger)anIndex select:(BOOL)select;
- (void)leveyPopListViewDidCancel;
-(void)reloadTable;
@end