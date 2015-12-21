//
//  FourthViewController.m
//  StoryBoard
//
//  Created by lius on 15/9/9.
//  Copyright (c) 2015年 LiuS. All rights reserved.
//

#import "FourthViewController.h"
#import "BBFlashCtntLabel.h"
#import "YDPersonalTableViewController.h"

@interface FourthViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmented;

@end

@implementation FourthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"第四页";
    self.navigationController.navigationBar.translucent = NO;
    
    long x = _segmented.selectedSegmentIndex;
    
    NSLog(@"%ld",x);
    CGRect rect = CGRectMake(20, 120, 180, 50);
    BBFlashCtntLabel *lbl = [[BBFlashCtntLabel alloc] initWithFrame:rect];
    lbl.backgroundColor = [UIColor redColor];
    lbl.leastInnerGap = 50.f;
    lbl.repeatCount = 5;
    lbl.speed = BBFlashCtntSpeedSlow;
    NSString *str = @"这是一段很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长的测试文字";
    lbl.text = str;
    [self.view addSubview:lbl];
    
    //右上角编辑按钮
    UIBarButtonItem *butt = [[UIBarButtonItem alloc]initWithTitle:@"编辑资料" style:UIBarButtonItemStylePlain target:self action:@selector(editData)];
    self.navigationItem.rightBarButtonItem = butt;

}

#pragma mark 编辑按钮
- (void)editData
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"personalView" bundle:nil];
    YDPersonalTableViewController *ydpersonal = [storyboard instantiateViewControllerWithIdentifier:@"YDPersonalTableViewController"];
    ydpersonal.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ydpersonal animated:YES];
}

- (IBAction)segmentedClick:(UISegmentedControl *)sender {
    NSLog(@"%ld",(long)sender.selectedSegmentIndex);
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
