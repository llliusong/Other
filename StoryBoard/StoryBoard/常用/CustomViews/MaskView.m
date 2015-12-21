//
//  MaskView.m
//  pinghu
//
//  Created by 杨朋辉 on 15/3/25.
//  Copyright (c) 2015年 zhuji. All rights reserved.
//

#define btnTAG 100
#import "MaskView.h"

#define btnHeight 40

@implementation MaskView
{
    NSMutableArray * _tagArray;//tag数组
    
    CGFloat scrollViewSizeHeight;
    
    UIView *view;
}

- (instancetype)initWithFrame:(CGRect)frame typeNameArray:(NSArray *)typeNameArray
{
    
    UIScrollView *scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, -66, ScreenWidth, ScreenHeight)];
    scrollViewSizeHeight = 0;
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        view = [[UIView alloc]initWithFrame:frame];
        
        if (typeNameArray.count > 0)
        {
            for (NSInteger i = 0; i < typeNameArray.count; i ++)
            {
                UIButton *btn = [[UIButton alloc]init];
                btn.frame = CGRectMake(10 , 0 + btnHeight * i, ScreenWidth, btnHeight);
                
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [btn setTitleColor:RGBA(48, 198, 204, 1) forState:UIControlStateSelected];
                [btn setTitle:typeNameArray[i] forState:UIControlStateNormal];
                btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
                btn.tag = i;
                scrollViewSizeHeight = scrollViewSizeHeight + btnHeight;
                if (btn.selected) {
                    
                    [btn setSelected:NO];
                    
                }
                [btn addTarget:self action:@selector(didTypeClick:) forControlEvents:UIControlEventTouchUpInside];
                [view addSubview:btn];
                
                UIView * bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, btnHeight * i - 1, ScreenWidth, 1)];
                bottomView.backgroundColor = [UIColor lightGrayColor];
                bottomView.alpha = 0.34;
                scrollViewSizeHeight = scrollViewSizeHeight + 1;
                [view addSubview:bottomView];
                
            }
            
            [scrollview addSubview:view];
//            [self addSubview: scrollview];
        }
    }
    [self addSubview:scrollview];
    scrollview.contentSize = CGSizeMake(ScreenWidth, scrollViewSizeHeight+66);
    return self;
}

- (void)didTypeClick:(UIButton *)sender
{
    for (UIButton * btn in view.subviews)
    {
        if ([btn isKindOfClass:[UIButton class]])
        {
            if (btn.tag < btnTAG)
            {
                btn.selected = NO;
            }
        }
    }
    sender.selected = YES;
    if ([_delegate respondsToSelector:@selector(maskBtnSelectedWithFilterView:andIndex:)]) {
        [_delegate maskBtnSelectedWithFilterView:self andIndex:sender.tag];
    }
}

- (void)didMoveToWindow
{
    [_tagArray removeAllObjects];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
