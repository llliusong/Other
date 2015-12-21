//
//  ThirdDetailController.m
//  StoryBoard
//
//  Created by lius on 15/11/11.
//  Copyright © 2015年 LiuS. All rights reserved.
//

#import "ThirdDetailController.h"
#import "PopupWindowView.h"
#import "Header.h"
#import "tollView.h"
#import "Take_PhotoViewController.h"
#import "AddImageController.h"
#import "DropDownViewController.h"
#import "DropDownCopyViewController.h"
#import "TableViewController.h"
#import "TableShiLiViewController.h"

@interface ThirdDetailController ()
{
    PopupWindowView *popup;
}

@end

@implementation ThirdDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"哈哈哈哈";
//    [self.view setBackgroundColor:[UIColor redColor]];
    self.navigationController.navigationBar.translucent = NO;

    [self.view addSubview:_tanchuButton];
    
    self.tanqiView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200);
    [tollView makeCircular:_shujuView Circularfloat:10];
    [tollView makeCircular:_cancelButton Circularfloat:10];
    
    
    popup = [[PopupWindowView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT) AllView:_tanqiView];
}

//确定
- (IBAction)sureClick:(UIButton *)sender {
    if (_user.text.length == 0) {
        [tollView makeCircular:_user Circularfloat:5];
        [tollView JitterAnimation:_user];
        [tollView makeCorner:1 view:_user color:[UIColor redColor]];
    }
    else
    {
        //        [self showAlertWithMessage:_user.text andTitle:@"温馨提示"];
        [self showAlertWIthMessage:_user.text withImageName:nil];
    }
}


- (IBAction)tanchuButton:(UIButton *)sender {
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 150, SCREEN_WIDTH,SCREEN_HEIGHT-150)];
//    
//    view.backgroundColor = [UIColor greenColor];
    
    [popup show];
}

- (IBAction)cancelButton:(UIButton *)sender {
    [popup dismiss];
}


//添加图片
- (IBAction)addImage:(UIButton *)sender {
//    Take_PhotoViewController *take = [Take_PhotoViewController new];
//    [self.navigationController pushViewController:take animated:YES];
    [self showAlertWIthMessage:@"你的信息填写不全" withImageName:@"delete"];
}

//弹出视图添加图片
- (IBAction)tabchuAddImage:(UIButton *)sender {
    [popup dismiss];

    AddImageController *add = [[AddImageController alloc]init];
    [self.navigationController pushViewController:add animated:YES];
}

//下拉菜单
- (IBAction)dropDown:(UIButton *)sender {
    DropDownViewController *drop = [DropDownViewController new];
    [self.navigationController pushViewController:drop animated:YES];
    
}

//UIAlertController
- (IBAction)UIAlertController:(UIButton *)sender {
    //    AlertViewController
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请" message:@"门票预定成功！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    //    [alert show];
    
    //    UIActionSheet *actionSheet = [[UIActionSheet alloc]
    //                                  initWithTitle:@"请选择"
    //                                  delegate:self
    //                                  cancelButtonTitle:@"取消"
    //                                  destructiveButtonTitle:nil
    //                                  otherButtonTitles:@"拍照",@"从手机中选择",nil];
    //    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    //    [actionSheet showInView:self.view];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"标题" message:@"提示信息" preferredStyle:UIAlertControllerStyleAlert];
    //    [self presentViewController:alert animated:YES completion:nil];
    
    UIAlertAction *cancelaction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        NSLog(@"点击了取消");
    }
                                   ];
    
    UIAlertAction *defaultaction = [UIAlertAction actionWithTitle:@"默认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        NSLog(@"点击了默认");
    }
                                    ];
    
    UIAlertAction *resetaction = [UIAlertAction actionWithTitle:@"重置" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
        NSLog(@"点击了重置");
    }
                                  ];
    
    [alert addAction:cancelaction];
    [alert addAction:defaultaction];
    [alert addAction:resetaction];
    [self presentViewController:alert animated:YES completion:nil];
}



//下拉菜单副本
- (IBAction)dropDownCopy:(UIButton *)sender {
    DropDownCopyViewController *drop = [DropDownCopyViewController new];
    [self.navigationController pushViewController:drop animated:YES];
}

//tableview
- (IBAction)tableView:(UIButton *)sender {
//    RPViewController *table = [RPViewController new];
//    TableViewController *table = [[TableViewController alloc] initWithNibName:@"TableViewController" bundle:nil];
//    [self.navigationController pushViewController:table animated:YES];
}


- (IBAction)tableviewshili:(UIButton *)sender {
    TableShiLiViewController *ta = [TableShiLiViewController new];
    [self.navigationController pushViewController:ta animated:YES];
}


#pragma mark 滑动效果
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
//    if (self.contentOffset.y < 64) {
//        
//        if ([_Home_Delegate respondsToSelector:@selector(HomePageConllention:Motion:MotionY:)]) {
//            [_Home_Delegate HomePageConllention:self Motion:@"glide" MotionY:self.contentOffset.y];
//        }
//        
//    }else {
//        
//        if ([_Home_Delegate respondsToSelector:@selector(HomePageConllention:Motion:MotionY:)]) {
//            [_Home_Delegate HomePageConllention:self Motion:@"upglide" MotionY:self.contentOffset.y];
//        }
//        
//    }
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
