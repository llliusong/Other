//
//  CommonTools.h
//  WZTrave
//
//  Created by lius on 14/10/20.
//  Copyright (c) 2014年 lius. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

typedef enum{
    ValidTypeEmail          =1,//邮箱
    ValidTypeQQ             =2,//qq
    ValidTypeMobile         =3,//手机
    ValidTypeChinese        =4,//中文
    ValidTypeIDCard         =5,//身份证
    
}ValidType;

@interface CommonTools : NSObject

+(void)setExceptionHandler;
#pragma mark - 消息异常处理
+(NSUncaughtExceptionHandler *)getExceptionHandler;
+(void)saveAsText:(NSString *)exceptionText;
+(void)sendEmail:(NSString *)exceptionText;

#pragma mark - 验证
+(BOOL)validateCheck:(NSString *)str stringType:(ValidType)type;

// 正则判断手机号码地址格式
+ (BOOL)isMobileNumber:(NSString *)mobileNum;

+ (BOOL)isDianxinNumber:(NSString *)mobileNum;

// 正则判断邮箱
+ (BOOL)isEmail:(NSString *)email;

#pragma mark - 16进制颜色转换
+(UIColor *)getRGBColor:(NSString *)hexColor;

@end

