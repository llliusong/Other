//
//  FilterView.h
//  huzhoutrave
//
//  Created by 小麦的rosePooh on 15/3/27.
//  Copyright (c) 2015年 小麦的rosePooh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FilterView;

@protocol FilterViewDelegate <NSObject>

@optional


- (void)filterBtnSelectedWithFilterView:(FilterView *)filterView andIndex:(NSInteger)index;

@end

@interface FilterView : UIView

@property(nonatomic,weak) id<FilterViewDelegate> delegate;

- (id)initWithData:(NSArray *)data andWidth:(CGFloat)width;
- (id)initWithData:(NSArray *)data andWidth:(CGFloat)width andY:(CGFloat)y;
@end
