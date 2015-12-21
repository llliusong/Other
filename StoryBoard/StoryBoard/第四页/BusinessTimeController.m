//
//  BusinessTimeController.m
//  GuoShu
//
//  Created by lius on 15/8/12.
//  Copyright (c) 2015年 yph. All rights reserved.
//

#import "BusinessTimeController.h"
#import "UIViewController+Addons.h"

@interface BusinessTimeController ()
{
    int senderTag;//tag
}
@property (strong, nonatomic) IBOutlet UIView *dateView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;;
@end

@implementation BusinessTimeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitleViewWithTitle:@"营业时间设置"];
    
    _workingTime.userInteractionEnabled = YES;
    _workingEndTime.userInteractionEnabled = YES;
    _restTime.userInteractionEnabled = YES;
    _restEndTime.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *workingTime = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeWorkingTime:)];
    [_workingTime addGestureRecognizer:workingTime];
    
    UITapGestureRecognizer *workingEndTime = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeWorkingTime:)];
    [_workingEndTime addGestureRecognizer:workingEndTime];
    
    UITapGestureRecognizer *restTime = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeWorkingTime:)];
    [_restTime addGestureRecognizer:restTime];
    
    UITapGestureRecognizer *restEndTime = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeWorkingTime:)];
    [_restEndTime addGestureRecognizer:restEndTime];
}

- (void)changeWorkingTime:(UITapGestureRecognizer *)gesture {
//    self.workingTime.inputView = self.datePicker;//点击弹出日期时间选取器//inputView显示在下面
//    self.endTime.inputAccessoryView = self.tabView;
//    [self presentViewController:self.dateView animated:YES completion:nil];
    senderTag = (int)gesture.view.tag;
    [UIView animateWithDuration:0.5 animations:^{
        
//        self.dateView.hidden = NO;
        self.dateView.frame = CGRectMake(0, [[UIScreen mainScreen]bounds].size.height - 237, ScreenWidth, 237);

    } completion:^(BOOL finished) {
        
    }];
    
}

- (IBAction)completeClick:(UIButton *)sender {
    // 发送代理，并把文本框中的值传过去
//    [self.delegate changeValue:self.workingTime.text];
    NSDictionary *dic = @{
                          @"workingTime":self.workingTime.text,
                          @"workingEndTime":self.workingEndTime.text,
                          @"restTime":self.restTime.text,
                          @"restEndTime":self.restEndTime.text,
                          };
    // 退出当前窗口
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self.delegate changeValue:dic];
    [self.navigationController popViewControllerAnimated:YES];
}

//完成
- (IBAction)finishClick:(UIButton *)sender {
    NSDate *todayDate = self.datePicker.date;
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"HH:mm";
    
    switch (senderTag) {
        case 1:
            self.workingTime.text = [fmt stringFromDate:todayDate];
            break;
        case 2:
            self.workingEndTime.text = [fmt stringFromDate:todayDate];
            break;
        case 3:
            self.restTime.text = [fmt stringFromDate:todayDate];
            break;
        case 4:
            self.restEndTime.text = [fmt stringFromDate:todayDate];
            break;
        default:
            break;
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.dateView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 237);
        
    } completion:^(BOOL finished) {
        
    }];
}

//取消
- (IBAction)cancelClick:(UIButton *)sender {
    [UIView animateWithDuration:0.5 animations:^{
        
        //        self.dateView.hidden = NO;
        self.dateView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 237);
        
    } completion:^(BOOL finished) {
        
    }];
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
