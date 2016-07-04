//
//  RightIndexView.m
//  APP
//
//  Created by 李坚 on 16/6/16.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "RightIndexView.h"
#import "AppDelegate.h"
#import "RightIndexTableViewCell.h"

#define  BOUNDS [[UIScreen mainScreen] bounds]

@implementation RightIndexView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titleArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.0f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ReturnIndexCellIdentifier = @"RightIndexTableViewCell";
    RightIndexTableViewCell *cell = (RightIndexTableViewCell *)[tableView dequeueReusableCellWithIdentifier:ReturnIndexCellIdentifier];
    if(cell == nil){
        UINib *nib = [UINib nibWithNibName:@"RightIndexTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:ReturnIndexCellIdentifier];
        cell = (RightIndexTableViewCell *)[tableView dequeueReusableCellWithIdentifier:ReturnIndexCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.mainLabel.text = _titleArray[indexPath.row];
    cell.mainImageView.image = [UIImage imageNamed:_imageArray[indexPath.row]];
    cell.backgroundColor = RGBHex(0x434950);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(self.callback){
        self.callback(indexPath.row);
    }
    [self hide];
}

+ (RightIndexView *)showIndexViewWithImage:(NSArray *)images title:(NSArray *)titles SelectCallback:(selectCallback)callBack
{
    RightIndexView *RIView = [[RightIndexView alloc]initWithFrame:CGRectMake(0, 0, BOUNDS.size.width, BOUNDS.size.height)];
    RIView.imageArray = images;
    RIView.titleArray = titles;
    
    RIView.callback = callBack;
    [RIView.mainTableView reloadData];
    
    [APPDelegate.window addSubview:RIView];
    [APPDelegate.window bringSubviewToFront:RIView];
    
    
    RIView.isShow = YES;
    
    
    return RIView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self == [super initWithFrame:frame]){
        
        self.backView = [[UIView alloc]initWithFrame:frame];
        self.backView.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
        [self.backView addGestureRecognizer:tap];
        [self addSubview:self.backView];
        
        UIImageView *topImage = [[UIImageView alloc]initWithFrame:CGRectMake(BOUNDS.size.width - 38.0f, 65, 10, 5)];
        topImage.image = [UIImage imageNamed:@"img_triangle"];
        [self addSubview:topImage];
        
        self.mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(BOUNDS.size.width - 161.0f, 70, 145, 90)];
        self.mainTableView.dataSource = self;
        self.mainTableView.delegate = self;
        self.mainTableView.layer.masksToBounds = YES;
        self.mainTableView.layer.cornerRadius = 3.5f;
        self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:self.mainTableView];
    }
    
    return self;
}


- (void)hide
{
    self.callback = nil;
    [self removeFromSuperview];
    self.isShow = NO;
}
@end
