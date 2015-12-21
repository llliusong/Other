//
//  PopupWindowView.m
//
//  Created by lius on 15/11/4.
//  Copyright © 2015年 lius. All rights reserved.
//

#import "PopupWindowView.h"

@interface PopupWindowView()<UIGestureRecognizerDelegate>

@end

@implementation PopupWindowView

-(id)initWithFrame:(CGRect)frame AllView:(UIView *)view{

    self = [super initWithFrame: frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        self.backgroundMask = [[UIView alloc] initWithFrame:self.bounds];
        self.backgroundMask.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.backgroundMask.backgroundColor = [UIColor blackColor];
        self.backgroundMask.alpha = 0;
        [self addSubview:self.backgroundMask];
     
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [self.backgroundMask addGestureRecognizer:tap];
    
        self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.bounds), CGRectGetWidth(self.bounds), view.frame.size.height)];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.contentView.autoresizingMask =  UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
        [self addSubview:self.contentView];

        
        CGRect frames = view.frame;
        frames.origin.y = 0;
        view.frame = frames;
        NSLog(@"%f",frames.origin.y);
        [self.contentView addSubview:view];
        
        self.windowLevel = UIWindowLevelAlert;
    }
    return self;
}

static PopupWindowView *popup = nil;

- (void)setContentViewFrameY:(CGFloat)y
{
    CGRect frame = self.contentView.frame;
    frame.origin.y = y;
    self.contentView.frame = frame;
}

- (void)show
{
    popup = self;
    popup.hidden = NO;
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        self.backgroundMask.alpha = 0.6;
        [self setContentViewFrameY:CGRectGetHeight(self.bounds) - CGRectGetHeight(self.contentView.frame) - 15];
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            self.backgroundMask.alpha = 0.6;
            [self setContentViewFrameY:CGRectGetHeight(self.bounds) - CGRectGetHeight(self.contentView.frame)];
            
        }completion:^(BOOL finished){
        
        }];
    }];
}

- (void)dismiss
{
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        self.backgroundMask.alpha = 0.6;
        [self setContentViewFrameY:CGRectGetHeight(self.bounds) - CGRectGetHeight(self.contentView.frame) - 15];
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            self.backgroundMask.alpha = 0;
            [self setContentViewFrameY:CGRectGetHeight(self.bounds)];
            
        } completion:^(BOOL finished) {
            popup.hidden = YES;
            popup = nil;
        }];
    }];
}

@end
