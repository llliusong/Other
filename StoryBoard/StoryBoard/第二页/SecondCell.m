//
//  SecondCell.m
//  StoryBoard
//
//  Created by lius on 15/9/17.
//  Copyright (c) 2015年 LiuS. All rights reserved.
//

#import "SecondCell.h"

@implementation SecondCell

- (void)awakeFromNib {
    // Initialization code
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"SecondCell";
    SecondCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"SecondCell" owner:nil options:nil][0];
    }
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
