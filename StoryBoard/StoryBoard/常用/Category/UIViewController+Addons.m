//
//  UIViewController+Addons.m
//  youyouzj
//
//  Created by 小麦的rosePooh on 14-10-13.
//  Copyright (c) 2014年 小麦的rosePooh. All rights reserved.
//

#import "UIViewController+Addons.h"
#import <MBProgressHUD.h>
#import "pop/POP.h"
#import "DXAlertView.h"
#import "RegexKitLite.h"

@implementation UIViewController (Addons)

UIView *_mask;


-(void)setTitleViewWithTitle:(NSString *)title{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 170, 44)];
    label.text = title;
    label.backgroundColor = [UIColor clearColor];
//    [self.price setFont:[UIFont fontWithName:@"MicrosoftYaHei" size:14.0]];
    label.font = [UIFont fontWithName:@"Menlo-Bold" size:21.0];
    label.layer.shadowOffset = CGSizeMake(1, 1);
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
    
}

-(void)setTitleView:(NSString *)imageName
{
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
}

- (void)showTakePhoto:(id)target isCamera:(BOOL)isCamera
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if (!isCamera) {//拍照
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
    picker.delegate = target;
    picker.allowsEditing = YES;//设置可编辑
    picker.sourceType = sourceType;
//    [target presentModalViewController:picker animated:YES];//进入照相界面  ios6.0已废弃
    [target presentViewController:picker animated:YES completion:nil];
    
    
}

-(void)showAlertWithMessage:(NSString *)msg  andTitle:(NSString *)title{
    
    DXAlertView *alert = [[DXAlertView alloc] initWithTitle:title contentText:msg leftButtonTitle:nil rightButtonTitle:@"确定"];
    [alert show];
    alert.rightBlock = ^() {
        NSLog(@"right button clicked");
    };
    alert.dismissBlock = ^() {
        NSLog(@"Do something interesting after dismiss block");
    };
    
}

-(void)showAlertWithMessage:(NSString *)msg  andTitle:(NSString *)title andRightButtonTitle:(NSString *)rightButtonTitle success:(SuccessCompleteHandle)isRightBtnChick
{
    
    DXAlertView *alert = [[DXAlertView alloc] initWithTitle:title contentText:msg leftButtonTitle:nil rightButtonTitle:rightButtonTitle];
    [alert show];
    alert.rightBlock = ^() {
        NSLog(@"right button clicked");
        
        isRightBtnChick(YES);
    };
    alert.dismissBlock = ^() {
        NSLog(@"Do something interesting after dismiss block");
    };
    
}

- (void)showAlertWIthMessage:(NSString *)message withImageName:(NSString *)imageName
{
    MBProgressHUD *HUD = [[MBProgressHUD alloc]initWithView:self.view];
    
    HUD.labelText = message;
    HUD.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    HUD.mode = MBProgressHUDModeCustomView;
    [self.view addSubview:HUD];
    [HUD showAnimated:YES whileExecutingBlock:^{
        sleep(2.0f);
    } completionBlock:^{
        
    }];
}


-(void)addMaskView
{
    _mask = [[UIView alloc] initWithFrame:self.view.bounds];
    _mask.backgroundColor = [UIColor blackColor];
    _mask.alpha = 0.3;
    _mask.hidden = YES;
    [self.view addSubview:_mask];
    
}

-(void)setMaskViewHidden:(BOOL)ishidden
{
    _mask.hidden = ishidden;
    if (ishidden) {
        _mask.alpha = 0.0;
    }else{
        _mask.alpha = 0.3;

    }
    
}

-(void)narrowAndAmplificationView:(UIView *)view andTransformSize:(CGSize)size
{
    //用POPSpringAnimation 让viewBlue实现弹性放大缩小的效果
    POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerSize];
    
    springAnimation.toValue = [NSValue valueWithCGSize:size];
    
    //弹性值
    springAnimation.springBounciness = 20.0;
    //弹性速度
    springAnimation.springSpeed = 15.0;
    
    [view.layer pop_addAnimation:springAnimation forKey:@"changesize"];

}

-(void)fallingAndPopupView:(UIView *)view andTransformPoint:(CGPoint)point
{
    POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
    
    springAnimation.toValue = [NSValue valueWithCGPoint:point];

    //弹性值
    springAnimation.springBounciness = 20.0;
    //弹性速度
    springAnimation.springSpeed = 15.0;
    
    [view pop_addAnimation:springAnimation forKey:@"changeposition"];
}

-(void)ejectAndDisappearView:(UIView *)view andTransformFromRect:(CGRect)fromrect toRect:(CGRect)torect
{
    POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    
    positionAnimation.fromValue = [NSValue valueWithCGRect:fromrect];
    positionAnimation.toValue = [NSValue valueWithCGRect:torect];
    
    positionAnimation.springBounciness = 15.0f;
    positionAnimation.springSpeed = 20.0f;
    [view pop_addAnimation:positionAnimation forKey:@"frameAnimation"];
    
}

- (void)createNavigation:(UIImage *)image
{
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}

-(NSString *)filterHTML:(NSString *)html
{
    NSString *regexString1 = @"<w:WordDocument>[\\s\\S]*<\\/w:WordDocument>";
    html = [html stringByReplacingOccurrencesOfRegex:regexString1 withString:@""];
    NSString *regexString2 = @"<style>[\\s\\S]*<\\/style>";
    html = [html stringByReplacingOccurrencesOfRegex:regexString2 withString:@""];
    NSString * ragexString3 = @"\\@\\{tel\\:(\\d{7,16})\\}";
    html = [html stringByReplacingOccurrencesOfRegex:ragexString3 withString:@""];
    NSString * ragexString4 = @"\\@\\{NAV\\:(.+?)\\|(\\d+)\\}";
    html = [html stringByReplacingOccurrencesOfRegex:ragexString4 withString:@""];
    NSString * ragexString5 = @"\\@\\{MAP\\:(.+?)\\|(\\d+)\\}";
    html = [html stringByReplacingOccurrencesOfRegex:ragexString5 withString:@""];
    
    NSScanner *theScanner;
    NSString *text = nil;
    
    theScanner = [NSScanner scannerWithString:html];
    
    html = [html stringByReplacingOccurrencesOfString:@"<br/>" withString:@"\n"];
    while ([theScanner isAtEnd] == NO) {
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:
                [ NSString stringWithFormat:@"%@>", text]
                                               withString:@" "];
    }
    
    // while //
    html = [html stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@"  "];
    html = [html stringByReplacingOccurrencesOfString:@"&ldquo;" withString:@"“"];
    html = [html stringByReplacingOccurrencesOfString:@"&rdquo;" withString:@"”"];
    html = [html stringByReplacingOccurrencesOfString:@"&middot;" withString:@"·"];
    html = [html stringByReplacingOccurrencesOfString:@"&mdash;" withString:@"-"];
    html = [html stringByReplacingOccurrencesOfString:@"<span id=\"_baidu_bookmark_start_0\" style=\"display: none; line-height: 0px;\">‍" withString:@""];
    html = [html stringByReplacingOccurrencesOfString:@"<span id=\"_baidu_bookmark_start_1\" style=\"display: none; line-height: 0px;\">‍" withString:@""];
    html = [html stringByReplacingOccurrencesOfString:@"<span id=\"_baidu_bookmark_start_2\" style=\"display: none; line-height: 0px;\">‍" withString:@""];
    html = [html stringByReplacingOccurrencesOfString:@"<span id=\"_baidu_bookmark_start_3\" style=\"display: none; line-height: 0px;\">‍" withString:@""];
    html = [html stringByReplacingOccurrencesOfString:@"<span id=\"_baidu_bookmark_start_4\" style=\"display: none; line-height: 0px;\">‍" withString:@""];
    html = [html stringByReplacingOccurrencesOfString:@"<span id=\"_baidu_bookmark_start_5\" style=\"display: none; line-height: 0px;\">‍" withString:@""];
    html = [html stringByReplacingOccurrencesOfString:@"<span id=\"_baidu_bookmark_end_0\" style=\"display: none; line-height: 0px;\">‍" withString:@""];
    html = [html stringByReplacingOccurrencesOfString:@"<span id=\"_baidu_bookmark_end_1\" style=\"display: none; line-height: 0px;\">‍" withString:@""];
    html = [html stringByReplacingOccurrencesOfString:@"<span id=\"_baidu_bookmark_end_2\" style=\"display: none; line-height: 0px;\">‍" withString:@""];
    html = [html stringByReplacingOccurrencesOfString:@"<span id=\"_baidu_bookmark_end_3\" style=\"display: none; line-height: 0px;\">‍" withString:@""];
    html = [html stringByReplacingOccurrencesOfString:@"<span id=\"_baidu_bookmark_end_4\" style=\"display: none; line-height: 0px;\">‍" withString:@""];
    html = [html stringByReplacingOccurrencesOfString:@"<span id=\"_baidu_bookmark_end_5\" style=\"display: none; line-height: 0px;\">‍" withString:@""];
//        NSString *regexString3 = @"<span[\\s\\S]>";
//        html = [html stringByReplacingOccurrencesOfRegex:regexString3 withString:@""];
    return html;
    
}
//-(NSString *)filterHTML:(NSString *)html
//{
//    NSScanner * scanner = [NSScanner scannerWithString:html];
//    NSString * text = nil;
//    while([scanner isAtEnd]==NO)
//    {
//        //找到标签的起始位置
//        [scanner scanUpToString:@"<" intoString:nil];
//        //找到标签的结束位置
//        [scanner scanUpToString:@">" intoString:&text];
//        //替换字符
//        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
//    }
//    NSString * regEx = @"<([^>]*)>";
//    html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
//    html = [html stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
//    
//    return html;
//}
@end
