//
//  TableViewDetailController.m
//  StoryBoard
//
//  Created by lius on 15/9/9.
//  Copyright (c) 2015年 LiuS. All rights reserved.
//

#import "TableViewDetailController.h"
#import "InfiniteScrollView.h"
#import "BBFlashCtntLabel.h"

@interface TableViewDetailController ()<InfiniteScrollViewDelegate>
{
    UILabel *label;
}

@end

@implementation TableViewDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.title = @"话题";
    
    //导航栏添加分段控制器
    NSArray *array = [NSArray arrayWithObjects:@"鸡翅",@"排骨", nil];
    UISegmentedControl *segmentedController = [[UISegmentedControl alloc] initWithItems:array];
    segmentedController.segmentedControlStyle = UISegmentedControlSegmentCenter;
    
    [segmentedController addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = segmentedController;
    
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"根视图" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    
    //添加轮播图
    InfiniteScrollView *IS = [[InfiniteScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180) andImageData:@[@"home1",@"home2",@"home3",@"home4"]];
    IS.delegate = self;
    IS.backgroundColor = [UIColor grayColor];
    IS.delegate = self;
    [self.view addSubview:IS];
    label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
    label.text = @"第一页";
    [IS addSubview:label];
    
    
    //添加跑马灯
    for (int i = 0; i < 5; i++) {
        CGRect rect = CGRectMake(20, 450 - i * 52, 180, 50);
        BBFlashCtntLabel *lbl = [[BBFlashCtntLabel alloc] initWithFrame:rect];
        lbl.backgroundColor = [UIColor lightGrayColor];
        lbl.leastInnerGap = 50.f;
        if (i % 3 == 0) {
            lbl.repeatCount = 5;
            lbl.speed = BBFlashCtntSpeedSlow;
        } else if (i % 3 == 1) {
            lbl.speed = BBFlashCtntSpeedMild;
        } else {
            lbl.speed = BBFlashCtntSpeedFast;
        }
        NSString *str = @"测试文字。来来；‘了哈哈😄^_^abcdefg123456👿";
        
        if (i %2 == 0) {
            lbl.text = str;
            lbl.font = [UIFont systemFontOfSize:25];
            lbl.textColor = [UIColor whiteColor];
        } else {
            NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:str];
            [att addAttribute:NSFontAttributeName
                        value:[UIFont systemFontOfSize:25]
                        range:NSMakeRange(0, 5)];
            [att addAttribute:NSFontAttributeName
                        value:[UIFont systemFontOfSize:17]
                        range:NSMakeRange(15, 5)];
            [att addAttribute:NSBackgroundColorAttributeName
                        value:[UIColor cyanColor]
                        range:NSMakeRange(0, 15)];
            [att addAttribute:NSForegroundColorAttributeName
                        value:[UIColor redColor]
                        range:NSMakeRange(8, 7)];
            lbl.attributedText = att;
        }
        if (i == 0) {
            lbl.textColor = [UIColor greenColor];
            lbl.text = @"少量文字";
        }
        
        [self.view addSubview:lbl];
    }
    
}

-(void)segmentAction:(id)sender
{
    switch ([sender selectedSegmentIndex]) {
        case 0:
        {
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你点击了鸡翅" delegate:self  cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alter show];
            
        }
            break;
        case 1:
        {
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你点击了排骨" delegate:self  cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alter show];
        }
            break;
            
        default:
            break;
    }
}

-(void)imageScrollView:(InfiniteScrollView *)imageScrollView didImageClickedAtIndex:(NSUInteger)index;
{
    NSLog(@"page == %ld", (long)index);
    label.text = @"第二页";
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
