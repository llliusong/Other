//
//  SecondCell.h
//  StoryBoard
//
//  Created by lius on 15/9/17.
//  Copyright (c) 2015年 LiuS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *name;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
