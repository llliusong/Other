//
//  MaskView.h
//  pinghu
//
//  Created by 杨朋辉 on 15/3/25.
//  Copyright (c) 2015年 zhuji. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MaskView;
@protocol MaskViewDelegate <NSObject>
@optional

- (void)maskBtnSelectedWithFilterView:(MaskView *)maskView andIndex:(NSInteger)index;
- (void)maskBtnSelectedWithFilterView:(MaskView *)maskView andArray:(NSArray *)array;
@end
@interface MaskView : UIView
@property(nonatomic,weak) id<MaskViewDelegate>delegate;
- (instancetype)initWithFrame:(CGRect)frame typeNameArray:(NSArray *)typeNameArray;
@end
