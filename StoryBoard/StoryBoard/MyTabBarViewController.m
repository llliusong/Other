//
//  MyTabBarViewController.m
//  StoryBoard
//
//  Created by lius on 15/9/9.
//  Copyright (c) 2015年 LiuS. All rights reserved.
//

#import "MyTabBarViewController.h"
//颜色选取器宏定义
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface MyTabBarViewController ()

@end

@implementation MyTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barTintColor = UIColorFromRGB(0x6CAC34);
    //设置默认条目
    self.selectedIndex = 1;
    [self setLeftAndRightItem];
//    self.title = @"刘松";
    
    
    self.navigationController.navigationBar.tintColor = [UIColor redColor];
    
    self.navigationController.navigationBar.translucent = NO;
    //是直接设置导航栏颜色 ,设置颜色后 导航栏颜色后  颜色会不明显，是ios自带毛玻璃效果，而且view里面的控件坐标是从左上角0，0 开始的    所以要设置 玻璃效果为no ，view里面的控件坐标就会从 0，64 开始    直接设置颜色  添加label（0，0，30，30）   label会被导航栏覆盖  不设置为no  label   y就必须加 64  很麻烦
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"guideIntro1"] forBarMetrics:UIBarMetricsDefault];
    //是设置导航栏背景图,设背景图是直接从 0，64 开始
    
    
    
    
}

//设置导航栏的左右条目
-(void)setLeftAndRightItem
{
    UIButton* rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,40,40)];
//    [rightButton setImage:[UIImage imageNamed:@"sweep"] forState:UIControlStateNormal];
    [rightButton setTitle:@"按钮" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(ShowScanView:)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem= rightItem;
    
}

- (void)ShowScanView:(UIButton *)sender
{
    NSLog(@"导航栏按钮");
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"别点我了，没用的"delegate:nil cancelButtonTitle:@"确定"otherButtonTitles:nil,nil];
    [alertView show];

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

@end
