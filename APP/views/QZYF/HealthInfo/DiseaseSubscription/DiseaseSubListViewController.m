//
//  DiseaseSubListViewController.m
//  APP
//
//  Created by chenzhipeng on 3/12/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "DiseaseSubListViewController.h"

@interface DiseaseSubListViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tbViewContent;

@end

@implementation DiseaseSubListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DebugLog(@"%s, %@",__func__, NSStringFromCGRect(self.view.frame));
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) refresh
{
//    self.view.backgroundColor = [UIColor redColor];
    [self.tbViewContent reloadData];
    DebugLog(@"%s, %@",__func__, NSStringFromCGRect(self.view.frame));
}

#pragma mark - UITableView Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DiseaseSubCell"];
    cell.textLabel.text = [NSString stringWithFormat:@"%d",indexPath.row];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

@end
