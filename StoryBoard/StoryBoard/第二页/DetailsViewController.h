//
//  DetailsViewController.h
//  DetailsViewController
//
//  Created by Mrliu on 15/6/11.
//  Copyright (c) 2015年 刘松. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *lunbotuView;//轮播图

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *priceView;//销售价格，活动时间
@property (strong, nonatomic) IBOutlet UIView *pingjiaView;//评价
@property (strong, nonatomic) IBOutlet UIView *sjxiVIew;//商家信息
@property (strong, nonatomic) IBOutlet UIView *hdnrView;//活动内容
@property (weak, nonatomic) IBOutlet UITextField *textField;


@end
