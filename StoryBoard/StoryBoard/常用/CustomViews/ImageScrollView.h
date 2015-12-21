//
//  ImageScrollView.h
//  henan-iphone
//
//  Created by ding liu on 13-3-25.
//  Copyright (c) 2013年 teemax. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
	图片点击回调协议
	@author sky
 */
@protocol ImageScrollViewDelegate;

/**
	滚动图片
	@author sky
 */
@interface ImageScrollView : UIView<UIScrollViewDelegate>{
    NSUInteger totalPage;
    NSUInteger currentPage;
    NSUInteger lastPage;
    NSUInteger nextPage;
    
    NSTimer *timer;
    UIScrollView *scrollview;
    UIPageControl *pageControl;
    CGPoint draggingPoint;
    BOOL isDragging;
    
    UIImageView *lastView;
    UIImageView *currentView;
    UIImageView *nextView;
    
    UIImageView *firstView;
    UIImageView *secondView;
    UIImageView *thirdView;
}
/**
	图片URL路径列表
 */
@property(nonatomic,retain) NSArray *imgURLs;
@property(nonatomic,readonly) UIImageView *currentView;
@property(nonatomic,assign) NSUInteger currentPage;
 /**
	协议委托对象
 */
@property(nonatomic,assign) id<ImageScrollViewDelegate> delegate;

/**
	初始化
	@param frame 视图大小
	@param urls 图片URL路径列表
	@returns ImageScrollView对象
 */
-(id)initWithFrame:(CGRect)frame imageURLs:(NSArray *)urls isHiddenPageControl:(BOOL)isHidden isHiddenSwitchBtn:(BOOL)isHiddenSwitchBtn;
/**
	初始化
	@param frame 视图大小
	@param urls 图片URL路径列表
	@param defaultPage 默认显示页
	@returns ImageScrollView对象
 */
-(id)initWithFrame:(CGRect)frame imageURLs:(NSArray *)urls defaultPage:(NSUInteger)defaultPage isHiddenPageControl:(BOOL)isHidden isHiddenSwitchBtn:(BOOL)isHiddenSwitchBtn;
/**
	自动播放开始
 */
-(void)autoStart;
/**
	自动播放停止
 */
-(void)autoStop;

/**
	展示指定页码图片
	@param page 页码
 */
-(void)showImageAtPage:(NSUInteger)page;

@end

/**
	图片点击事件回调委托
	@author sky
 */
@protocol ImageScrollViewDelegate <NSObject>

@optional
/**
	图片点击事件
	@param imageScrollView 本身视图
	@param index 页码
 */
-(void)imageScrollView:(ImageScrollView *)imageScrollView didImageClickedAtIndex:(NSUInteger)index;

- (void)imageScrollViewDidEndScrollingAnimation:(ImageScrollView *)scrollView page:(NSInteger)page;

@end
