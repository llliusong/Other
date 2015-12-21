//
//  SecondViewController.h
//  StoryBoard
//
//  Created by lius on 15/9/9.
//  Copyright (c) 2015年 LiuS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
