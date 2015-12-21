//
//  KeyBoardToolView.m
//  huzhoutrave
//
//  Created by 小麦的rosePooh on 15/4/1.
//  Copyright (c) 2015年 小麦的rosePooh. All rights reserved.
//

#import "KeyBoardToolView.h"
#import "UIView+UIView_Utils.h"

@implementation KeyBoardToolView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor lightGrayColor];
        self.hidden = YES;
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:CNCommonColor forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
        cancelBtn.frame = CGRectMake(0, 0, 60, 50);
        [self addSubview:cancelBtn];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = @"选择日期";
        [titleLabel setTextColor:[UIColor blackColor]];
        titleLabel.frame = CGRectMake((self.width / 2 - 35) , 0, 70, 50);
        [self addSubview:titleLabel];
        
        UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [sureBtn setTitleColor:CNCommonColor forState:UIControlStateNormal];
        [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
        sureBtn.frame = CGRectMake(self.width - 60, 0, 60, 50);
        [self addSubview:sureBtn];
        
    }
    return self;
}

- (void)cancelBtnClick
{
    if ([_delegate respondsToSelector:@selector(keyBoardToolViewCancelBtnClick:)]) {
        self.hidden = YES;
        [_delegate keyBoardToolViewCancelBtnClick:self];
    }

}

- (void)sureBtnClick
{
    if ([_delegate respondsToSelector:@selector(keyBoardToolViewSureBtnClick:)]) {
        self.hidden = YES;
        [_delegate keyBoardToolViewSureBtnClick:self];
    }
}

@end
