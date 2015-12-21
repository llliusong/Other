//
//  FilterView.m
//  huzhoutrave
//
//  Created by 小麦的rosePooh on 15/3/27.
//  Copyright (c) 2015年 小麦的rosePooh. All rights reserved.
//

#import "FilterView.h"
#import "UIView+UIView_Utils.h"

#define KTypeBtnHeight 55

@interface FilterView ()
{
    UIButton *_selectedBtn;
}


@end

@implementation FilterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
- (id)initWithData:(NSArray *)data andWidth:(CGFloat)width andY:(CGFloat)y
{
    if (self = [super init]) {
        
        CGFloat allHeight = data.count * KTypeBtnHeight;
        
        if (allHeight > 400) {
            allHeight = 400.0f;
        }
        
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, allHeight)];
        scrollView.backgroundColor = [UIColor whiteColor];
        [self addSubview:scrollView];
        
        [data enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            NSString *title = data[idx];
            
            //初始化
            UIView *typeView = [[UIView alloc] init];
            typeView.frame = CGRectMake(0, idx *KTypeBtnHeight , width, KTypeBtnHeight);
            [scrollView addSubview:typeView];
            
            //添加按钮
            UIButton *typeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [typeBtn setTitle:title forState:UIControlStateNormal];
            [typeBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -100, 0, 100)];
            typeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
            [typeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [typeBtn setTitleColor:CNCommonColor forState:UIControlStateSelected];
            typeBtn.frame = CGRectMake(0, 0, width, typeView.height);
            typeBtn.tag = idx;
            [typeBtn addTarget:self action:@selector(typeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [typeView addSubview:typeBtn];
            
            //添加分割线
            UIView *line = [[UIView alloc] init];
            line.backgroundColor = [UIColor groupTableViewBackgroundColor];
            line.frame = CGRectMake(10, KTypeBtnHeight - 1 , width - 10, 1);
            [typeView addSubview:line];
            
        }];
        
        scrollView.contentSize = CGSizeMake(0, data.count * KTypeBtnHeight + 1);
        scrollView.showsVerticalScrollIndicator = NO;
        
        self.frame = CGRectMake(width, 64+y, width, allHeight);
        
    }
    return self;
    
}

- (id)initWithData:(NSArray *)data andWidth:(CGFloat)width
{
    if (self = [super init]) {
        
        CGFloat allHeight = data.count * KTypeBtnHeight;
        
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, allHeight)];
        scrollView.backgroundColor = [UIColor whiteColor];
        [self addSubview:scrollView];
        
        [data enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            NSString *title = data[idx];
            
            //初始化
            UIView *typeView = [[UIView alloc] init];
            typeView.frame = CGRectMake(0, idx *KTypeBtnHeight , width, KTypeBtnHeight);
            typeView.tag = 100;
            [scrollView addSubview:typeView];
            
            //添加按钮
            UIButton *typeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [typeBtn setTitle:title forState:UIControlStateNormal];
            [typeBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -150, 0, 100)];
            typeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
            [typeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [typeBtn setTitleColor:CNCommonColor forState:UIControlStateSelected];
            typeBtn.frame = CGRectMake(0, 0, width, typeView.height);
            typeBtn.tag = idx;
            [typeBtn addTarget:self action:@selector(typeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [typeView addSubview:typeBtn];
            
            //添加分割线
            UIView *line = [[UIView alloc] init];
            line.backgroundColor = [UIColor groupTableViewBackgroundColor];
            line.frame = CGRectMake(10, KTypeBtnHeight - 1 , width - 10, 1);
            [typeView addSubview:line];
            
        }];
        
        scrollView.contentSize = CGSizeMake(0, allHeight + 1);
        scrollView.showsVerticalScrollIndicator = NO;

        self.frame = CGRectMake(ScreenWidth, 64, width, allHeight);
        
    }
    return self;

}


- (void)typeBtnClick:(UIButton *)btn
{
    _selectedBtn.selected = NO;
    btn.selected = YES;
    _selectedBtn = btn;
    
    if ([_delegate respondsToSelector:@selector(filterBtnSelectedWithFilterView:andIndex:)]) {
        [_delegate filterBtnSelectedWithFilterView:self andIndex:btn.tag];
    }
    
    
}


@end
