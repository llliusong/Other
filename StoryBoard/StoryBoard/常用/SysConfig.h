//
//  SysConfig.h
//  baseFrame-v2
//
//  Created by lius on 13-5-30.
//  Copyright (c) 2013年 lius. All rights reserved.
//

#import <Foundation/Foundation.h>

/**配置文件索引*/
#define BUNDLE_KEY_VERSION @"CFBundleVersion"  //版本信息
#define BUNDLE_KEY_API @"Web API"              //API根地址
#define BUNDLE_KEY_IMG @"Web IMG"              //图片下载根地址
#define BUNDLE_KEY_DATA @"Data File"       //数据库路径
#define BUNDLE_KEY_DEBUG_MODE @"DeBug Mode"    //是否Debug模式(用于BaseService中API接口调试)

/**下载资源文件根目录*/
#define ROOT_FOLDER	[NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/Documents"]

//是否iphone5
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

/**
	系统常量
	@author sky
 */
@interface SysConfig : NSObject

/**
	获取配置文件值
	@param bundleKey 参数
	@returns 值
 */
+(NSString *)getValue:(NSString *)bundleKey;

/**
	判断是否连接网络
	@returns 连接状态
 */
+(BOOL)isNetworkReachable;
/**
	判断是否连接wifi
	@returns wifi连接状态
 */
+ (BOOL)isWiFiConnection;

/**
	判断应用是否是Debug模式
	@returns debug状态
 */
+(BOOL)isDebug;

/**
    获取电池容量
 */
+(float)getCurrentBatteryLevel;

/**
    获取当前根地址
 */
+(NSString *)getWebAPI;

/**
    获取应用当前版本号
    @returns 版本号
 */
+(NSString *)getCurrentVersion;

/**
    通过文本返回高度
 */
+ (CGFloat)getCurrentTextSize:(NSString *)text andFont:(CGFloat)fontSize;

/**
    过滤html字符
 */
+ (NSString *)clearHTML:(NSString *)html;

+ (NSString *)flattenHTML:(NSString *)html;

/**
    获取沙盒存储路径
 */
+ (NSString *)getSandboxStoragePath;

/**
    日期格式转换
 */
+(NSString *)formatSyncDate:(NSString *)syncDate;

/**
    本地数据库路径
 */
+(NSString *)getDataFile;

/**
    验证邮箱
 */
+(BOOL)isValidateEmail:(NSString *)email;


/**
    获取到当前时间
 */
+ (NSString *)getNowTime;

/**
    获取到当前时间固定格式
 */
+ (NSString *)getNowTimeFormat;

/**
    不同格式格式化日期
 */
+(NSString *)formatDate:(NSDate *)date andFormat:(NSString *)format;

/**
    日期字符串格式化日期
 */
+(NSDate *)formatSringWithDate:(NSString *)dateString andFormat:(NSString *)format;

/**
    日期字符串截取
 */
+(NSString *)formatDateSring:(NSString *)dateString andIndex:(int)index;

/**
 
    获取不同评分
 */
+ (NSString *)getCommentWithNumber:(NSNumber *)number;

/**
 
    获取等级
 */
+ (NSString *)getLevelWithNumber:(int)number;

/**
 
    判断是否同一天
 */
+(BOOL)isSameDay:(NSDate*)date1 date2:(NSDate *)date2;

/**
 
     格式化出发时间数组
 */
+(NSMutableArray *)formatGoArray:(NSString *)goString;


/**
 
    保留2位小数
 */
+(NSString *)retainedTwoDecimalPlaces:(double)number;

/**
 
    两个宽度返回字体尺寸
 */
+(NSInteger)returnByTwoWidth:(CGFloat)originalWidth andInput:(CGFloat)inputWidth;

/**
 
    把秒转换为分钟或小时
 */
+(NSString *)secondsByMinutes:(int)seconds;

@end
