//
//  YDPersonalTableViewController.m
//  SASSEUR
//
//  Created by lius on 15/9/6.
//  Copyright (c) 2015年 lius. All rights reserved.
//

#import "YDPersonalTableViewController.h"
#import "Header.h"
#import "tollView.h"
#import <UIImageView+WebCache.h>
#import "AFNetworking.h"
#import "LoginViewController.h"
#import "nicknameViewController.h"
#import "MyNavigationController.h"
#import "BusinessTimeController.h"
#import "PersonalController.h"
@interface YDPersonalTableViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,EveryFrameDelegate,UINavigationControllerDelegate,BusinessTimeControllerDelegate>{

    NSString *sexStr;//性别
    UIAlertView *alerview;
    NSMutableDictionary *imagedict;
    NSString *userid;
    NSString *useridData;
    NSUserDefaults *userDefault;
}

@end

@implementation YDPersonalTableViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人中心";
    self.navigationController.navigationBar.translucent = NO;
    [self setInit];
}

-(void)setInit{
    
    userDefault = [NSUserDefaults standardUserDefaults];

    [tollView makeCircular:self.headImage Circularfloat:self.headImage.frame.size.width/2];
    NSArray *arr = @[self.oneView,self.threeView,self.twoView,self.fiveView,self.sixView,self.sevenView,self.eightView,self.nineView];
    [tollView setBottom:arr];

    [tollView makeCircular:self.okBtn Circularfloat:5];
    [tollView setFoursides:self.fiveTopView Direction:@"top"];
    [tollView setFoursides:self.eighttopView Direction:@"top"];
    
    [self setRequest];
}

#pragma mark 获取本地数据
-(void)setRequest{

    
    NSURL *url = [NSURL URLWithString:@"http://v1.qzone.cc/avatar/201404/16/13/08/534e105e2e232865.jpg!200x200.jpg"];
    [self.headImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"icon_1_s"]];
    NSString* name = [[userDefault objectForKey:@"name"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    self.nameLabel.text = name;
    self.phonenumLabel.text = [userDefault objectForKey:@"cellphone"];
    self.companyNameLabel.text = @"暂无网络";
    self.typeLabel.text = [userDefault objectForKey:@"category"];
    self.operateLabel.text = [userDefault objectForKey:@"businessScope"];
    self.addressLabel.text = [userDefault objectForKey:@"address"];
    self.introduceLabel.text = [userDefault objectForKey:@"简介"];
    
}

#pragma mark 响应选中事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.tableView endEditing:YES];
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
    
    if (indexPath.row == 0) {
        
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:nil
                                      delegate:self
                                      cancelButtonTitle:@"取消"
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:@"拍照",@"从手机中选择",nil];
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        [actionSheet showInView:self.view];
        
    }else if(indexPath.row == 1){
    
        nicknameViewController *nickname = [[nicknameViewController alloc] init];
        nickname.delegate = self;
        nickname.namestr = self.nameLabel.text;
        [self.navigationController pushViewController:nickname animated:YES];
        
    }else if(indexPath.row == 2){
        BusinessTimeController *BTC = [BusinessTimeController new];
        BTC.delegate = self;
        [self.navigationController pushViewController:BTC animated:YES];
        
    }else if(indexPath.row == 4){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"liuspersonal" bundle:nil];
        PersonalController *ydpersonal = [storyboard instantiateViewControllerWithIdentifier:@"PersonalController"];
        ydpersonal.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ydpersonal animated:YES];
        
    }else if(indexPath.row == 5){
        
    }else if(indexPath.row == 6){
        
    }else if(indexPath.row == 7){
        
    }else if(indexPath.row == 9){
        
    }else if(indexPath.row == 10){
        
    }
}

#pragma mark 相机
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    if (buttonIndex == 0) {//拍照
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [self showTakePhoto:self isCamera:YES];
            
        }else{
            
            NSLog(@"没有相机");
        }
    }else if (buttonIndex == 1) {//从手机中选择
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate = self;
        //设置选择后的图片可被编辑
        picker.allowsEditing = YES;
        [self presentViewController:picker animated:YES completion:^(void){}];
    }
}

- (void)showTakePhoto:(id)target isCamera:(BOOL)isCamera{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if (!isCamera) {//拍照
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
    picker.delegate = target;
    picker.allowsEditing = YES;//设置可编辑
    picker.sourceType = sourceType;
    [target presentViewController:picker animated:YES completion:nil];//进入照相界面
    
}

#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    
    if ([type isEqualToString:@"public.image"])
    {
       
        UIImage* image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        UIImage *newImage = [self imageWithImage:image scaledToSize:CGSizeMake(image.size.width * 0.2, image.size.height * 0.2)];
        NSData *buffer = UIImageJPEGRepresentation(newImage, 1);
        NSString *type = @"image/jpg";
        if (buffer == nil) {
            buffer = UIImagePNGRepresentation(newImage);
            type = @"image/png";
        }
        
        [self dismissViewControllerAnimated:YES completion:^(void){}];
        [self.headImage setImage:image];
        
//        [imagedict setObject:buffer forKey:@"avatar"];
//        [self sendPhoton:imagedict andImage:@"avatar" andType:type];
        
    }
    
}

-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark 上传图片1
-(void)sendPhoton:(NSDictionary *)params andImage:(NSString *)fileKey andType:(NSString *)type{
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:[NSString stringWithFormat:@"http://szc.sixgui.com/user/userapi/editavatar?userid=%@",userid] parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // 设置时间格式
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"logo%@.png", str];
        // 上传图片，以文件流的格式
        NSData *buffer = params[fileKey];
        
        //        NSLog(@"%@",buffer);
        
        [formData appendPartWithFileData:buffer name:@"avatar" fileName:fileName mimeType:type];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
    
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    NSLog(@"您取消了选择图片");
    [self dismissViewControllerAnimated:YES completion:^(void){}];
}

#pragma mark 昵称
-(void)DonicknameView:(NSString *)name{
 
    self.nameLabel.text = name;
}

#pragma mark 个人介绍
-(void)Personal_introduction:(NSString *)personal_introduction{

    self.introduceLabel.text = personal_introduction;
}

#pragma mark 时间
/**
 此方为必须实现的协议方法，用来传值
 */
- (void)changeValue:(NSDictionary *)value{//修改时间
    NSLog(@"%@",value);
}

-(IBAction)OKBtn:(UIButton *)sender {
    
    [UIView animateWithDuration:0.5 animations:^{
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults removeObjectForKey:@"registerId"];
        [userDefaults synchronize];
        
    } completion:^(BOOL finished) {
    
        LoginViewController *longin = [[LoginViewController alloc] init];
        UINavigationController *hom1Navi = [[UINavigationController alloc]initWithRootViewController:longin];
        [self.view.window setRootViewController:hom1Navi];
        
    }];
}
@end