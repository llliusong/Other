//
//  tollView.h
//
//  Created by lius on 15/9/29.
//  Copyright (c) 2015年 lius. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface tollView : NSObject{

    
}


//边框
+(void)makeCorner:(CGFloat)corner view:(UIView *)view color:(UIColor *)color;

//圆角
+(void)makeCircular:(UIView *)beadView Circularfloat:(CGFloat )Circularfloat;

//旋转
+ (void)rotateSpinningView:(UIView *)view;

//分割线
+ (void)segmentationView:(UIView *)view;

//四边的线条
+(void)setFoursides:(UIView *)view Direction:(NSString *)dirction;

//底部灰色线条
+(void)setBottom:(NSArray *)viewArr;

+(void)setBottomView:(UIView *)view;

//手机号验证
+ (BOOL)isMobileNumber:(NSString *)mobileNum;

//邮箱号验证
+ (BOOL) validateEmail:(NSString *)email;

//提示
+(void)PromptView:(NSString *)contentStr view:(UIView *)view Location:(NSString *)locationStr;

//返回时间
+ (NSString *)GetNsintger:(NSInteger )integer;

//获取当前时间
+ (NSString *)GetCurrent;


//返回几分钟前
+ (NSString *)intervalSinceNow: (NSString *) theDate;

//设置行间距
+ (void)setLineSpacing:(CGFloat)floats Label:(UILabel *)label Content:(NSString *)contenstr;

//抖动动画
+ (void)rotation:(UIImageView *)imageView ;

//抖动动画
+(void)JitterAnimation:(UIView *)view;

@end
