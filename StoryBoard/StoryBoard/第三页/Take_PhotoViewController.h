//
//  Take_PhotoViewController.h
//  High_Quality_Fabric
//
//  Created by 黎金 on 15/10/30.
//  Copyright © 2015年 sixgui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Take_PhotoViewController :  UIViewController
@property (strong, nonatomic) IBOutlet UIView *topPhotoView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) IBOutlet UIView *oneView;
@property (strong, nonatomic) IBOutlet UIView *twoView;
@property (strong, nonatomic) IBOutlet UIView *threeView;
@property (strong, nonatomic) IBOutlet UIButton *addBtn;
- (IBAction)AddBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *imagesView;
@property (strong, nonatomic) IBOutlet UIView *oneLeftView;
@property (strong, nonatomic) IBOutlet UIView *oneRightView;
@property (strong, nonatomic) IBOutlet UIView *twoLeftView;
@property (strong, nonatomic) IBOutlet UIView *twoRightView;
@property (strong, nonatomic) IBOutlet UIView *threeBottomView;
@property (strong, nonatomic) IBOutlet UIButton *submitBtn;
- (IBAction)SubmitBtn:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UILabel *threeLabel;


@property (strong, nonatomic) NSString *stateStr;
@end
