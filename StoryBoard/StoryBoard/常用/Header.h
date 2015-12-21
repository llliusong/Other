//
//  Header.h
//  High_Quality_Fabric
//
//  Created by lius on 15/10/24.
//  Copyright © 2015年 lius. All rights reserved.
//

#ifndef Header_h
#define Header_h


#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//颜色值
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

//判断是否是iOS8
#define iOS8 [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0

//判断是否是iOS7
#define iOS7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0

//判断是否是视网膜屏
#define IS_RETINA ([UIScreen mainScreen].scale == 2.0 ? YES:NO)

//判断是否是4寸屏
#define IS_IPHONE5 [UIScreen mainScreen].bounds.size.height==568?YES:NO

//判断是否是3.5寸屏
#define IS_IPHONEThree [UIScreen mainScreen].bounds.size.height==480?YES:NO
//当前设备宽度
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
//当前设备高度
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height

//图片加载
#define ImgByName(name) [UIImage imageNamed:name]

// 每个cell之间的间距
#define CellMargin 10

// 导航栏高度
#define NavHeight 44

//全局颜色值
#define CNCommonColor [UIColor colorWithRed:72.0/255.0 green:188.0/255.0 blue:195.0/255.0 alpha:1]

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))
#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#define UIColorRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

//线条描边
#define GrayLine [UIColor colorWithRed:221.0/255.0 green:221.0/255.0 blue:221.0/255.0 alpha:1.0]
#define TextColor [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0]
#define GrayTextColor [UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0]
#define NAVI_COLOR(a) [UIColor colorWithRed:42.0/255.0 green:174.0/255.0 blue:160.0/255.0 alpha:a]

#define UIFont(font) [UIFont fontWithName:@"Hiragino KaKu Gothic ProN" size:font];
#endif /* Header_h */
