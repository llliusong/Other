//
//  InfiniteScrollView.h
//  WZTrave
//
//  Created by 小麦的rosePooh on 14-8-29.
//  Copyright (c) 2014年 吴书颖. All rights reserved.
//

#import <UIKit/UIKit.h>
@class InfiniteScrollView;

/**
 图片点击事件回调委托
 @author sky
 */
@protocol InfiniteScrollViewDelegate <NSObject>

@optional
/**
 图片点击事件
 @param imageScrollView 本身视图
 @param index 页码
 */
-(void)imageScrollView:(InfiniteScrollView *)imageScrollView didImageClickedAtIndex:(NSUInteger)index;

@end

@interface InfiniteScrollView : UIView

@property(nonatomic,weak) id<InfiniteScrollViewDelegate> delegate;

//设置滚动时长
@property(nonatomic,assign) float time;


/**
 初始化
 @param frame 滚动视图frame
 @param imageData 图片数据
 */
- (id)initWithFrame:(CGRect)frame andImageData:(NSArray *)imageData;

@end
