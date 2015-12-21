//
//  YDPersonalTableViewController.h
//  SASSEUR
//
//  Created by lius on 15/9/6.
//  Copyright (c) 2015年 lius. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YDPersonalTableViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UIImageView *headImage;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *phonenumLabel;
@property (strong, nonatomic) IBOutlet UILabel *companyNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *typeLabel;
@property (strong, nonatomic) IBOutlet UILabel *operateLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UILabel *introduceLabel;

@property (strong, nonatomic) IBOutlet UITableViewCell *grayView;
@property (strong, nonatomic) IBOutlet UITableViewCell *twograyView;



@property (strong, nonatomic) IBOutlet UIView *oneView;
@property (strong, nonatomic) IBOutlet UIView *twoView;
@property (strong, nonatomic) IBOutlet UIView *threeView;
@property (strong, nonatomic) IBOutlet UIView *fiveView;
@property (strong, nonatomic) IBOutlet UIView *sixView;
@property (strong, nonatomic) IBOutlet UIView *sevenView;
@property (strong, nonatomic) IBOutlet UIView *eightView;
@property (strong, nonatomic) IBOutlet UIView *eighttopView;
@property (strong, nonatomic) IBOutlet UIView *nineView;
@property (strong, nonatomic) IBOutlet UIView *fiveTopView;

@property (strong, nonatomic) IBOutlet UIButton *okBtn;
@end
