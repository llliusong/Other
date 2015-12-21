//
//  PopupWindowView.h
//
//  Created by lius on 15/11/4.
//  Copyright © 2015年 lius. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopupWindowView : UIWindow


- (void)show;
- (void)dismiss;
-(id)initWithFrame:(CGRect)frame AllView:(UIView *)view;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *backgroundMask;
@end
