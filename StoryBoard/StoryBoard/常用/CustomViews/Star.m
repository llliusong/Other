//
//  Star.m
//  NewZhiyou
//
//  Created by user on 11-8-5.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "Star.h"



@implementation Star

@synthesize charset,font_size, max_star, show_star;
@synthesize empty_color, full_color, isSelect;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        max_star = 100;
        show_star = 0;
        isSelect = NO;
        
        self.backgroundColor = [UIColor clearColor];
        charset=@"★★★★★";
        font_size = 13.0f;
        self.empty_color = [UIColor colorWithRed:167.0f / 255.0f green:167.0f / 255.0f blue:167.0f / 255.0f alpha:1.0f];
        self.full_color = [UIColor colorWithRed:252.0f / 255.0f green:182.0f / 255.0f blue:10.0f / 255.0f alpha:1.0f];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    rect= self.bounds;
    UIFont *font = [UIFont boldSystemFontOfSize: font_size];
    CGSize starSize = [charset sizeWithFont:font];
    rect.size=starSize;
    [empty_color set];
    [charset drawInRect:rect withFont:font];
//    [@"☆☆☆☆☆" drawInRect:rect withFont:font];
    
    CGRect clip=rect;
    clip.size.width = clip.size.width * show_star / max_star;
    CGContextClipToRect(context,clip);
    [full_color set];
    [charset drawInRect:rect withFont:font];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event 
{
    if (isSelect) {
        CGPoint pt = [[touches anyObject] locationInView:self];
        UIFont *font = [UIFont boldSystemFontOfSize: font_size];
        CGSize starSize = [charset sizeWithFont: font];
        if (pt.x > starSize.width + 5) {
            return;
        }
        show_star = (CGFloat)(100.0f * pt.x / starSize.width);
        [self setNeedsDisplay];

    }
}

//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event 
//{
//    if (isSelect) {
//        CGPoint pt = [[touches anyObject] locationInView:self];
//        UIFont *font = [UIFont boldSystemFontOfSize: font_size];
//        CGSize starSize = [charset sizeWithFont: font];
//        if (pt.x > starSize.width + 5) {
//            return;
//        }
//        show_star = (CGFloat)(100.0f * pt.x / starSize.width);
//        
//       
//        [self setNeedsDisplay];
//        
//    }
//}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event 
{
    if (isSelect) {
        CGPoint pt = [[touches anyObject] locationInView:self];
        UIFont *font = [UIFont boldSystemFontOfSize: font_size];
        CGSize starSize = [charset sizeWithFont: font];
        if (pt.x > starSize.width + 5) {
            return;
        }
        show_star = (CGFloat)(100.0f * pt.x / starSize.width);
        
        
        [self setNeedsDisplay];
        
        if (_delegate) {
            [_delegate StartouchesMovedShow_star:show_star];
        }
    }
    
}

@end
