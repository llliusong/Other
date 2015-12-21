//
//  BusinessTimeController.h
//  GuoShu
//
//  Created by lius on 15/8/12.
//  Copyright (c) 2015年 yph. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 定义协议，用来实现传值代理
 */
@protocol BusinessTimeControllerDelegate <NSObject>

/**
 此方为必须实现的协议方法，用来传值
 */
//- (void)changeValue:(NSString *)value;
- (void)changeValue:(NSDictionary *)value;

@end


@interface BusinessTimeController : UIViewController
/**
 此处利用协议来定义代理
 */
@property (nonatomic, unsafe_unretained) id<BusinessTimeControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *workingTime;
@property (weak, nonatomic) IBOutlet UILabel *workingEndTime;
@property (weak, nonatomic) IBOutlet UILabel *restTime;
@property (weak, nonatomic) IBOutlet UILabel *restEndTime;

@end
