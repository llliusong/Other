//
//  nicknameViewController.m
//  SASSEUR
//
//  Created by lius on 15/8/27.
//  Copyright (c) 2015年 lius. All rights reserved.
//

#import "nicknameViewController.h"
#import "Header.h"
#import "toolView.h"
#import "ActivityIndicatorView.h"
@interface nicknameViewController ()<UITextFieldDelegate>{

    ActivityIndicatorView *activ;
    NSUserDefaults *userDefault;
}

@end

@implementation nicknameViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.title = @"修改昵称";
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.nameText.delegate = self;
    self.nameText.clearButtonMode = UITextFieldViewModeWhileEditing;
    [tollView makeCircular:self.okBtn Circularfloat:10];
    [self stateView:0];
    
    [self setName:self.namestr];
     userDefault = [NSUserDefaults standardUserDefaults];
}

#pragma mark 提示
-(void)setActiv{
    
    activ  = [[ActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    activ.backgroundColor = [UIColor clearColor];
    [self.view.superview bringSubviewToFront:activ];
    [self.view addSubview:activ];
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    [self stateView:1];
    return YES;
}

-(void)stateView:(NSInteger)intrger{

    if (intrger == 0) {
        
        self.userImage.image = [UIImage imageNamed:@"user"];
        [toolView makeCorner:0.5 view:self.userView color:UIColorRGBA(221, 221, 221, 1)];
        
    }else if(intrger == 1){
        
        self.userImage.image = [UIImage imageNamed:@"user_h"];
        [toolView makeCorner:0.5 view:self.userView color:UIColorRGBA(66, 214, 197, 1)];
        
    }else if(intrger == 2){
        
        [toolView JitterAnimation:self.userView];
        self.userImage.image = [UIImage imageNamed:@"user"];
        [toolView makeCorner:0.5 view:self.userView color:UIColorRGBA(232, 16, 23, 1)];
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if ([string isEqualToString:@"n"])
    {
        return YES;
    }
    
    if(textField == self.nameText){
    
        if (self.nameText.text.length>16) {
        
            
            return NO;
        }
    }

    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.nameText resignFirstResponder];
    
    return YES;
}

- (IBAction)okBtn:(UIButton *)sender {
    
    [self.nameText resignFirstResponder];
    if ([self.nameText.text isEqual:@""]) {
        
        [self stateView:2];
            
    }else{
    
        [self stateView:0];
        [self setActiv];
        [activ TitleStr:@"正在修改..."];
        
        [self performSelector:@selector(delayMethod) withObject:nil afterDelay:1.0f];
        
//         NSString *nameStr =[self.nameText.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    
//        NSDictionary *parameter = @{
//                                   
//                                    @"user.name":nameStr,
//                                    @"registerId":[userDefault objectForKey:@"registerId"],
//                                    @"flg":[userDefault objectForKey:@"flg"]
//                                    
//                                    };
//    
//        NSString *urlstr = [NSString stringWithFormat:@"%@/user!updateUser.action",[userDefault objectForKey:@"request"]];
//        [toolView postUrl:urlstr parameter:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            
//            if ([responseObject[@"state"]  isEqual: @"1"]) {
//                
//                [activ removeFromSuperview];
//                [toolView showAlertWIthView:self.view Message:@"修改失败" withImageName:nil];
//                 [self setEditpasswordRequest];
//                NSLog(@"%@++%@",[userDefault objectForKey:@"registerId"],[userDefault objectForKey:@"flg"]);
//                
//            }else{
//                
//                [activ removeFromSuperview];
//                [toolView showAlertWIthView:self.view Message:@"修改成功" withImageName:nil];
//                
//                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//                [userDefaults setObject:self.nameText.text forKey:@"name"];
//                [userDefaults synchronize];
//                [self setEditpasswordRequest];
//                
//            }
//
//            NSLog(@"65   %@",responseObject);
//            
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            
//            NSLog(@"%@",operation.request.URL);
//            [activ removeFromSuperview];
//            [toolView showAlertWIthView:self.view Message:@"修改失败,请检查网络" withImageName:nil];
//        
//        }];
    
    }
}

- (void)delayMethod
{
    [self setEditpasswordRequest];
    [activ removeFromSuperview];
}

-(void)setEditpasswordRequest{
    
    [self.nameText resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];//返回到上一个页面
    [self.delegate DonicknameView:self.nameText.text];

}

-(void)setName:(NSString *)namestr{
    
    self.nameText.placeholder = namestr;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
