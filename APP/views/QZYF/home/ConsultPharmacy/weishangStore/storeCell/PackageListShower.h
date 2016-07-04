//
//  PackageListShower.h
//  APP
//
//  Created by 李坚 on 16/6/15.
//  Copyright © 2016年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^AddCallback) (NSInteger obj);


@interface PackageListShower : UIView<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *headLabel;
@property (copy,nonatomic) AddCallback callback;
@property (strong, nonatomic) NSArray *dataArr;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UITableView *PKTableView;
@property (weak, nonatomic) IBOutlet UILabel *mainPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *lessPriceLabel;
- (IBAction)closeAction:(id)sender;

- (IBAction)AddAction:(id)sender;
- (IBAction)ReduceAction:(id)sender;
- (IBAction)addToShoppingCar:(id)sender;

+ (PackageListShower *)showPackageContent:(NSString *)content andDataList:(NSArray *)array callBack:(AddCallback)callBack;

@end
