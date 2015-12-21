//
//  UIBarButtonItem+IW.h
//  WeiBo
//
//  Created by Rosepooh on 14-1-12.
//  Copyright (c) 2014年 classroomM. All rights reserved.
//
#import "UIBarButtonItem+IW.h"

@implementation UIBarButtonItem (IW)
+ (UIBarButtonItem *)itemWithImage:(NSString *)image edgeInsets:(UIEdgeInsets)edgeInsets higlightedImage:(NSString *)higlightedImage target:(id)target action:(SEL)action
{
    // 1.创建按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // 2.设置按钮背景图片
    UIImage *normal = [UIImage imageWithNamed:image];
    [btn setImage:normal forState:UIControlStateNormal];
    [btn setImage:[UIImage imageWithNamed:higlightedImage] forState:UIControlStateHighlighted];
    
    // 3.设置按钮的尺寸
    [btn setImageEdgeInsets:edgeInsets];
    btn.bounds = CGRectMake(0, 0, normal.size.width, normal.size.height);
    
    // 4.监听按钮点击
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    // 5.返回创建好的item
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (UIBarButtonItem *)itemWithImage:(NSString *)image edgeInsets:(UIEdgeInsets)edgeInsets WithBounds:(CGRect)frame higlightedImage:(NSString *)higlightedImage target:(id)target action:(SEL)action
{
    // 1.创建按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // 2.设置按钮背景图片
    UIImage *normal = [UIImage imageWithNamed:image];
    [btn setImage:normal forState:UIControlStateNormal];
    [btn setImage:[UIImage imageWithNamed:higlightedImage] forState:UIControlStateHighlighted];
    
    // 3.设置按钮的尺寸
    [btn setImageEdgeInsets:edgeInsets];
    btn.frame = frame;
    
    // 4.监听按钮点击
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    // 5.返回创建好的item
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}



+ (UIBarButtonItem *)itemWithTitle:(NSString *)title andWithBounds:(CGRect)fram  target:(id)target action:(SEL)action
{
    // 1.创建按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:CNCommonColor forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    // 3.设置按钮的尺寸
    btn.frame = fram;
    
    // 4.监听按钮点击
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    // 5.返回创建好的item
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (UIBarButtonItem *)itemWithCustomView:(UIView *)customView
{
    return [[UIBarButtonItem alloc] initWithCustomView:customView];
}


@end
