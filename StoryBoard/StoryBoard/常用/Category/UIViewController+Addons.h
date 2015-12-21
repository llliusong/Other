//
//  UIViewController+Addons.h
//  youyouzj
//
//  Created by 小麦的rosePooh on 14-10-13.
//  Copyright (c) 2014年 小麦的rosePooh. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SuccessCompleteHandle)(BOOL isRightBtnChick);

@interface UIViewController (Addons)

/*
    更改控制器标题文字
 */
-(void)setTitleViewWithTitle:(NSString *)title;

/*
 更改控制器标题的titleView
 */
-(void)setTitleView:(NSString *)imageName;

/*
    打开相机
 */
- (void)showTakePhoto:(id)target isCamera:(BOOL)isCamera;

/*
    自定义弹出框
 */
- (void)showAlertWIthMessage:(NSString *)message withImageName:(NSString *)imageName;

/*
    自定义提示框
 */
-(void)showAlertWithMessage:(NSString *)msg  andTitle:(NSString *)title;

/*
    自定义提示框返回右边按钮点击事件
 */
-(void)showAlertWithMessage:(NSString *)msg  andTitle:(NSString *)title andRightButtonTitle:(NSString *)rightButtonTitle success:(SuccessCompleteHandle)isRightBtnChick;

/*
    增加蒙板
 */
-(void)addMaskView;

/*
    设置蒙板是否隐藏
 */
-(void)setMaskViewHidden:(BOOL)ishidden;

/*
    缩小放大视图
 */
-(void)narrowAndAmplificationView:(UIView *)view andTransformSize:(CGSize)size;

/*
    上弹下坠视图
 */
-(void)fallingAndPopupView:(UIView *)view andTransformPoint:(CGPoint)point;

/*
    弹出消失视图
 */
-(void)ejectAndDisappearView:(UIView *)view andTransformFromRect:(CGRect)fromrect toRect:(CGRect)torect;
/*
 *  设置导航栏背景
 */
- (void)createNavigation:(UIImage *)image;
/*
    去除HTML字符
 */
-(NSString *)filterHTML:(NSString *)html;

@end
