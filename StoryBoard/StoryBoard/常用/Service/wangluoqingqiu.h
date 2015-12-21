//
//  wangluoqingqiu.h
//  Home
//
//  Created by lius on 15/7/23.
//  Copyright (c) 2015年 刘松. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^CompleteHandle)(id response);

@interface wangluoqingqiu : NSObject
+ (void)parm:(NSString *)string Success:(CompleteHandle)success;
+(void)assdSuccess:(CompleteHandle)success;

@end
