//
//  UnevenHeightLabel.m
//  huzhoutrave
//
//  Created by 小麦的rosePooh on 15/4/7.
//  Copyright (c) 2015年 小麦的rosePooh. All rights reserved.
//

#import "UnevenHeightLabel.h"

@implementation UnevenHeightLabel

/*
 Only override drawRect: if you perform custom drawing.
 An empty implementation adversely affects performance during animation.
 */
- (void)drawRect:(CGRect)rect {
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, 1.0f);
    if(_strings != nil && _strings.count>0)
    {
        for (int i = 0; i<_strings.count; i++)
        {
            [_strings[i] drawInRect:[(NSValue *)_fontFrames[i] CGRectValue] withAttributes:@{NSFontAttributeName:_fonts[i],NSForegroundColorAttributeName:_fontColors[i]}];
        }
    }
}

-(instancetype)initWithUnevenHeightStringFonts:(NSArray *)fonts stringRects:(NSArray *)rects stringColors:(NSArray *)colors
{
    self = [super init];
    self.fonts = fonts;
    self.fontFrames = rects;
    self.fontColors = colors;
    return self;
}

@end
