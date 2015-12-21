//
//  Model.h
//  StoryBoard
//
//  Created by lius on 15/12/16.
//  Copyright © 2015年 LiuS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject
@property(nonatomic,copy) NSString *title;//标题
@property(nonatomic,copy) NSString *subtitle;//副标题
@property(nonatomic,copy) NSString *price;//价格
@property(nonatomic,copy) NSString *address;//地址
@property(nonatomic,copy) NSString *distance;//距离

/**
	非持久化初始化
	@returns 瞬态类对象实例
 */
-(id)init;
@end
