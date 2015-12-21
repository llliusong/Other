//
//  Star.h
//  NewZhiyou
//
//  Created by user on 11-8-5.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol StarDelegate <NSObject>

- (void)StartouchesMovedShow_star:(CGFloat)Show_star;

@end

/**
	绘制字符串图像
	@author sky
 */
@interface Star : UIView
{
    CGFloat font_size;                  /* 根据字体大小来确定星星的大小 */
    NSInteger max_star;                 /* 在init里面默认为100 */
    CGFloat show_star;
    BOOL isSelect;                      /* 是否支持选择星数 */
    
    UIColor *empty_color;
    UIColor *full_color;
}

@property (nonatomic,assign) id <StarDelegate>delegate;

@property (nonatomic,copy) NSString *charset;//字符
@property (nonatomic, assign) CGFloat font_size;
@property (nonatomic, assign) NSInteger max_star;
@property (nonatomic, assign) CGFloat show_star;
@property (nonatomic, retain) UIColor *empty_color;
@property (nonatomic, retain) UIColor *full_color;
@property (nonatomic, assign) BOOL isSelect; 

@end

