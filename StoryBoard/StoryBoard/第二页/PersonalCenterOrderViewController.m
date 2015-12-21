//
//  PersonalCenterOrderViewController.m
//  StoryBoard
//
//  Created by lius on 15/12/17.
//  Copyright © 2015年 teemax. All rights reserved.
//

#import "PersonalCenterOrderViewController.h"
#import "OrderTableViewCell.h"

@interface PersonalCenterOrderViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation PersonalCenterOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"我的订单";
    self.orderListTableView.dataSource = self;
    self.orderListTableView.delegate = self;
}

- (IBAction)RefreshOrderList:(UIButton *)sender {
    
}

#pragma mark - UITableView DataSource and Delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderTableViewCell *orderCell = [OrderTableViewCell cellWithTableView:tableView];
    return orderCell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
