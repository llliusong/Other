//
//  TypeSelectView.h
//  henan-iphone
//
//  Created by ding liu on 13-3-8.
//  Copyright (c) 2013年 teemax. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TypeSelectViewDelegate;

@interface TypeSelectView : UIScrollView{
    
    NSMutableArray *buttons;
    UIImageView *backgroundView;
    UIButton *coverBtn;
    UIButton *extraBtn; //额外添加"全部"按钮
    UIView *coverView;
    CGFloat lastHeight;
}
@property(nonatomic,assign)             NSUInteger  column;
@property(nonatomic,assign)             CGFloat     borderx;
@property(nonatomic,assign)             CGFloat     bordery;
@property(nonatomic,assign,readonly)    NSUInteger  numberOfButtons;
@property(nonatomic,readonly)           BOOL        isShow;
@property(nonatomic,retain)             UIImage     *backgroundImage;
@property(nonatomic,assign)             id<TypeSelectViewDelegate> typeDelegate;
@property(nonatomic,assign)             BOOL        extraBtnStatus;


-(void)reloadData;
-(UIButton *)buttonAtIndex:(NSUInteger)index;
-(void)showBelowView:(UIView *)view;
-(void)showBelowView:(UIView *)view withHeight:(CGFloat)height;
-(void)hide;
@end


@protocol TypeSelectViewDelegate <NSObject>

@optional
-(UIButton *)typeSelectView:(TypeSelectView *)typeSelectView buttonAtIndex:(NSUInteger)index;
-(NSUInteger)numberOfButtonsInTypeSelectView:(TypeSelectView *)typeSelectView;
-(NSString *)typeSelectView:(TypeSelectView *)typeSelectView titleForButtonAtIndex:(NSUInteger)index;
-(UIImage *)typeSelectView:(TypeSelectView *)typeSelectView ImgForButtonAtIndex:(NSUInteger)index;
-(void)typeSelectView:(TypeSelectView *)typeSelectView didClickButtonAtIndex:(NSUInteger)index;
-(void)typeSelectViewDidHide:(TypeSelectView *)typeSelectView;
-(void)typeSelectViewdidExtraButtonClicked:(TypeSelectView *)typeSelectView;


@end