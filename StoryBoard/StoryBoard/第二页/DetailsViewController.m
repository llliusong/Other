//
//  DetailsViewController.m
//  DetailsViewController
//
//  Created by Mrliu on 15/6/11.
//  Copyright (c) 2015年 刘松. All rights reserved.
//

#import "DetailsViewController.h"
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height//获取屏幕高度
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width//获取屏幕宽度

@interface DetailsViewController ()
{
    CGFloat scrollViewSizeHeight;
    UIDatePicker *datePicker;
}
@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initlunbotuView];//初始化轮播图
    
    [self initScrollview];//初始化滚动视图

}


-(void)initlunbotuView
{
    //轮播图自己搞
}

- (void)initScrollview
{
    scrollViewSizeHeight = 0;
    [self.scrollView addSubview:self.lunbotuView];
    scrollViewSizeHeight = scrollViewSizeHeight + self.lunbotuView.bounds.size.height;
    
    self.priceView.frame = CGRectMake(0, scrollViewSizeHeight, ScreenWidth, self.priceView.bounds.size.height);
    [self.scrollView addSubview:self.priceView];
    scrollViewSizeHeight = scrollViewSizeHeight + self.priceView.bounds.size.height;
    
    self.pingjiaView.frame = CGRectMake(0, scrollViewSizeHeight, ScreenWidth, self.pingjiaView.bounds.size.height);
    [self.scrollView addSubview:self.pingjiaView];
    scrollViewSizeHeight = scrollViewSizeHeight + self.pingjiaView.bounds.size.height;
    
    self.sjxiVIew.frame = CGRectMake(0, scrollViewSizeHeight, ScreenWidth, self.sjxiVIew.bounds.size.height);
    [self.scrollView addSubview:self.sjxiVIew];
    scrollViewSizeHeight = scrollViewSizeHeight + self.sjxiVIew.bounds.size.height;
    
    self.hdnrView.frame = CGRectMake(0, scrollViewSizeHeight, ScreenWidth, self.hdnrView.bounds.size.height);
    [self.scrollView addSubview:self.hdnrView];
    scrollViewSizeHeight = scrollViewSizeHeight + self.hdnrView.bounds.size.height;
    
    [self.view addSubview:self.scrollView];
//    self.scrollView.bounds = CGRectMake(0, 0, ScreenWidth, scrollViewSizeHeight);
    self.scrollView.contentSize = CGSizeMake(ScreenWidth, scrollViewSizeHeight);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
    
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
