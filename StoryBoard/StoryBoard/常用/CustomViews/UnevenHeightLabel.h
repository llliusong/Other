//
//  UnevenHeightLabel.h
//  huzhoutrave
//
//  Created by 小麦的rosePooh on 15/4/7.
//  Copyright (c) 2015年 小麦的rosePooh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UnevenHeightLabel : UIView

@property (nonatomic,strong) NSArray *strings;
@property (nonatomic) NSArray *fonts;
@property (nonatomic) NSArray *fontFrames;
@property (nonatomic) NSArray *fontColors;

-(instancetype)initWithUnevenHeightStringFonts:(NSArray *)fonts stringRects:(NSArray *)rects stringColors:(NSArray *)colors;

@end
