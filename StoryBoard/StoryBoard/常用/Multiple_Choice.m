//
//  Multiple_Choice.m
//  High_Quality_Fabric
//
//  Created by lius on 15/11/10.
//  Copyright © 2015年 lius. All rights reserved.
//

#import "Multiple_Choice.h"

#define UIColorRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

@implementation Multiple_Choice
{
    BOOL isbool;
    NSMutableArray *selectedBtnList;
}
-(id) initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        
        _fontSize = 11.0;
        selectedBtnList = [[NSMutableArray alloc] init];
    }
    return self;

}

#pragma mark 选中颜色
-(void)setPitchonColor:(UIColor *)pitchonColor{

    if (_pitchonColor != pitchonColor) {
        _pitchonColor = pitchonColor;
    }
}

#pragma mark 字体大小
-(void)setFontSize:(CGFloat)fontSize{

    if (_fontSize != fontSize) {
        _fontSize = fontSize;
    }
}

#pragma mark 数据
-(void)setContentArr:(NSArray *)contentArr{

    if (_contentArr != contentArr) {
        _contentArr = contentArr;
        [self setInit:_contentArr];
    }
}

#pragma mark 选中状态
-(void)setStateStr:(NSString *)stateStr{

    if (_stateStr != stateStr) {
        _stateStr = stateStr;
    }
}

#pragma mark 每行个数
-(void)setNumrow:(NSInteger)numrow{

    if (_numrow != numrow) {
        _numrow = numrow;
    }
}

-(void) setInit:(NSArray *)dataArr{

    NSInteger numrow = _numrow;
    CGFloat Merw = (self.frame.size.width - 40)/numrow;
    CGFloat Merh = 28;
    
    for (int i = 0; i<dataArr.count; i++) {
        
        int row = i/numrow;
        int loc = i%numrow;
        CGFloat Merx = (Merw + 10) * loc;
        CGFloat Mery = (Merh + 10)*row;
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(Merx, Mery, Merw, Merh)];
        button.tag = i;
        button.titleLabel.font = [UIFont systemFontOfSize:_fontSize];
        [button setTitleColor:UIColorRGBA(171, 171, 171, 1) forState:UIControlStateNormal];
        [button setTitle:dataArr[i] forState:UIControlStateNormal];
        [self makeCorner:0.5 view:button color:UIColorRGBA(171, 171, 171, 1)];
        [button addTarget:self action:@selector(PitchBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
    }
    
}

- (void)PitchBtn:(UIButton *)sender{

    
    if ([_stateStr  isEqual: @"多选"]) {
        NSString *x = [[NSString alloc] initWithFormat:@"%ld",(long)sender.tag];
        UIButton *btn = (UIButton *)sender;
        
        //查询selectedBtnList 中是否有x这个元素
        if ([selectedBtnList containsObject:x]) {
            
            //未选中状态
            btn.backgroundColor = [UIColor whiteColor];
            [self makeCorner:0.5 view:btn color:UIColorRGBA(171, 171, 171, 1)];
            [sender setTitleColor:UIColorRGBA(171, 171, 171, 1) forState:UIControlStateNormal];
            [selectedBtnList removeObject:x];
    
            if ([_Delegate respondsToSelector:@selector(Multiple_ChoiceArr:)]) {
                [_Delegate Multiple_ChoiceArr:selectedBtnList];
            }
            
        }else{
            
            //如果没有x则将x加入里面
            btn.backgroundColor = _pitchonColor;
            [self makeCorner:0.5 view:btn color:_pitchonColor];
            [btn setTitleColor:UIColorRGBA(255, 255, 255, 1) forState:UIControlStateNormal];
            [selectedBtnList addObject:x];
   
            if ([_Delegate respondsToSelector:@selector(Multiple_ChoiceArr:)]) {
                [_Delegate Multiple_ChoiceArr:selectedBtnList];
            }
        }
        
    }else{
    //单选
//        UIButton *btn;
//        for (btn in self.subviews) {
//            
//            if (btn.tag == sender.tag){
//                
//                
//                if (isbool) {
//                    
//                    
//                    btn.backgroundColor = [UIColor whiteColor];
//                    [self makeCorner:0.5 view:btn color:UIColorRGBA(171, 171, 171, 1)];
//                    [btn setTitleColor:UIColorRGBA(171, 171, 171, 1) forState:UIControlStateNormal];
//                    isbool = NO;
//                    
//                }else{
//                    
//                    btn.backgroundColor = _pitchonColor;
//                    [self makeCorner:0.5 view:btn color:_pitchonColor];
//                    [btn setTitleColor:UIColorRGBA(255, 255, 255, 1) forState:UIControlStateNormal];
//                    isbool = YES;
//                    
//                    if ([_Delegate respondsToSelector:@selector(Multiple_Choice:)]) {
//                        [_Delegate Multiple_Choice:btn.tag];
//                    }
//                }
//
//                
//            }else{
//                
//                btn.backgroundColor = [UIColor whiteColor];
//                [self makeCorner:0.5 view:btn color:UIColorRGBA(171, 171, 171, 1)];
//                [btn setTitleColor:UIColorRGBA(171, 171, 171, 1) forState:UIControlStateNormal];
//                isbool = NO;
//            }
//        }
        UIButton *btn;
        for (id obj in self.subviews) {
            if ([obj isKindOfClass:[UIButton class]]) {
                btn = (UIButton *)obj;
                if (btn.tag == sender.tag){
                    
                    btn.backgroundColor = _pitchonColor;
                    [self makeCorner:0.5 view:btn color:_pitchonColor];
                    [btn setTitleColor:UIColorRGBA(255, 255, 255, 1) forState:UIControlStateNormal];
                    
                    if ([_Delegate respondsToSelector:@selector(Multiple_Choice:)]) {
                        [_Delegate Multiple_Choice:btn.tag];
                    }
                    
                }else{
                    
                    btn.backgroundColor = [UIColor whiteColor];
                    [self makeCorner:0.5 view:btn color:UIColorRGBA(171, 171, 171, 1)];
                    [btn setTitleColor:UIColorRGBA(171, 171, 171, 1) forState:UIControlStateNormal];
                    
                }
                
            }
        }
        
    }
}

#pragma mark 边框
- (void)makeCorner:(CGFloat)corner view:(UIView *)view color:(UIColor *)color{
    
    CALayer * fileslayer = [view layer];
    fileslayer.borderColor = [color CGColor];
    fileslayer.borderWidth = corner;
    
}
@end
