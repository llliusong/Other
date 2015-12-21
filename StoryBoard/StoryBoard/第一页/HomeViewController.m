//
//  HomeViewController.m
//  StoryBoard
//
//  Created by lius on 15/9/9.
//  Copyright (c) 2015年 LiuS. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()<UIWebViewDelegate>
{
    UIWebView *_webview;
}
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"第一页";
    self.navigationController.navigationBar.translucent = NO;

    _webview = [[UIWebView alloc]initWithFrame:self.view.frame];
    
    CGRect oneFrm=self.view.frame;
    CGRect twoFrm=self.view.frame;
    NSValue *value1 = [NSValue valueWithCGRect:oneFrm];
    NSValue *value2 = [NSValue valueWithCGRect:twoFrm];
    NSArray *tt = @[value1,value2];
    CGRect res = [tt[0] CGRectValue];
//    NSLog(@"%@",[tt[0] CGRectValue]);
    


    
    _webview.delegate = self;
//    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://map.baidu.com/mobile/"]];
//    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://map.baidu.com/mobile/webapp/place/linesearch/foo=bar/end=word%3D%E9%87%91%E6%9B%B2%E9%87%8F%E8%B4%A9KTV%E5%A4%A9%E5%9F%8E%E6%97%97%E8%88%B0%E5%BA%97%26point%3D13381484.99%2C3519522%26citycode%3D131&from=place"]];
//    NSString *string = [NSString stringWithFormat:@"http://map.baidu.com/mobile/webapp/place/linesearch/foo=bar/end=word%3D杭州%26point%3D13381484.99%2C3519522%26citycode%3D131&from=place"];
    
//    NSString *string = @"北京";
//    NSString *input = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    
//    NSString *url = [NSString stringWithFormat:@"http://map.baidu.com/mobile/webapp/place/linesearch/foo=bar/end=word%%3D%@",input];
//    
//    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.iqiyi.com/v_19rrkoc7gg.html?vfm=2008_aldbd&bvfm=videolocal"]];
    [_webview loadRequest:request];
    [self.view addSubview:_webview];
    
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
