//
//  KeyBoardToolView.h
//  huzhoutrave
//
//  Created by 小麦的rosePooh on 15/4/1.
//  Copyright (c) 2015年 小麦的rosePooh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KeyBoardToolView;


@protocol KeyBoardToolViewDelegate <NSObject>

@optional
-(void)keyBoardToolViewSureBtnClick:(KeyBoardToolView *)keyBoardToolView;

-(void)keyBoardToolViewCancelBtnClick:(KeyBoardToolView *)keyBoardToolView;

@end


@interface KeyBoardToolView : UIView

@property(nonatomic,weak) id<KeyBoardToolViewDelegate> delegate;


@end
