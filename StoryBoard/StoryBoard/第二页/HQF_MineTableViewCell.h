//
//  HQF_MineTableViewCell.h
//  High_Quality_Fabric
//
//  Created by 黎金 on 15/11/5.
//  Copyright © 2015年 sixgui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HQF_MineTableViewCell : UITableViewCell
{

    UIImageView *headImage;
    UILabel *titelLabel;
}

@property (nonatomic, strong) UIView *grayView;
-(void)HQF_MineTableViewCell:(NSString *)imageStr Title:(NSString *)titleStr;
@end
