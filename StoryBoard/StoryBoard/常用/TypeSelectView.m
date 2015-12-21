//
//  TypeSelectView.m
//  henan-iphone
//
//  Created by ding liu on 13-3-8.
//  Copyright (c) 2013年 teemax. All rights reserved.
//

#import "TypeSelectView.h"
#import "NSObject+NotNull.h"

#define BTN_IMAGE_WIDTH 34
#define BTN_IMAGE_HEIGHT 28

@interface TypeSelectView(Pirvate)
-(void)reloadScrollView;
-(void)didButtonClicked:(id)sender;
-(void)didExtraBtnClicked;
-(void)createExtraBtn;
@end

@implementation TypeSelectView
@synthesize backgroundImage,typeDelegate,numberOfButtons,column,borderx,bordery,isShow,extraBtnStatus;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        buttons=[NSMutableArray new];
        backgroundView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:backgroundView];
        self.backgroundImage=[UIImage imageNamed:@"type_select_bg"];
        borderx=7;
        column=4;
        extraBtnStatus=YES;
        coverBtn=[[UIButton alloc] init];
//        coverBtn.backgroundColor=[UIColor blackColor];
//        coverBtn.alpha=0.2;
        [coverBtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchDown];
        self.scrollEnabled=YES;
        self.showsVerticalScrollIndicator=NO;
        self.clipsToBounds=NO;
        self.autoresizesSubviews=NO;
        self.bounces=NO;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


-(void)setBackgroundImage:(UIImage *)_backgroundImage{
//    backgroundImage=[_backgroundImage retain];
    backgroundView.frame=CGRectMake(0, 0, self.frame.size.width, backgroundImage.size.height*(self.frame.size.width/backgroundImage.size.width));
    backgroundView.image=_backgroundImage;
}

-(void)setTypeDelegate:(id<TypeSelectViewDelegate>)_typeDelegate{
    typeDelegate=_typeDelegate;
    [self reloadData];
}

#pragma mark - public method
-(UIButton *)buttonAtIndex:(NSUInteger)index{
    if([buttons isNotEmpty] && index<[buttons count]){
        return [buttons objectAtIndex:index];
    }else{
        return nil;
    }
}

-(void)reloadData{
    [buttons removeAllObjects];
    if([typeDelegate respondsToSelector:@selector(numberOfButtonsInTypeSelectView:)]){
        numberOfButtons=[typeDelegate numberOfButtonsInTypeSelectView:self];
    }
    if(numberOfButtons>0 && typeDelegate!=nil){
        for(int i=0;i<numberOfButtons;i++){
            UIButton *btn;
            if([typeDelegate respondsToSelector:@selector(typeSelectView:buttonAtIndex:)]){
                btn=[typeDelegate typeSelectView:self buttonAtIndex:i];
            }else{
                btn=[UIButton buttonWithType:UIButtonTypeCustom];
                [btn.titleLabel setFont:[UIFont fontWithName:@"Arial" size:14.0]];
//                btn.backgroundColor=[UIColor blackColor];
            }
            if([typeDelegate respondsToSelector:@selector(typeSelectView:titleForButtonAtIndex:)]){
                NSString *title=[typeDelegate typeSelectView:self titleForButtonAtIndex:i];
                if(title!=nil){
                    [btn setTitle:title forState:UIControlStateNormal];
                }
            }
            if([typeDelegate respondsToSelector:@selector(typeSelectView:ImgForButtonAtIndex:)]){
                UIImage *image=[typeDelegate typeSelectView:self ImgForButtonAtIndex:i];
                if(image!=nil){
                    [btn setImage:image forState:UIControlStateNormal];
                }
            }
            [btn addTarget:self action:@selector(didButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [buttons addObject:btn];
        }
        //额外添加全部按钮
        if(extraBtnStatus){
            [self createExtraBtn];
            [buttons insertObject:extraBtn atIndex:0];
        }
    }
    [self reloadScrollView];
}

-(void)showBelowView:(UIView *)view{
    [self showBelowView:view withHeight:self.frame.size.height];
}

-(void)showBelowView:(UIView *)view withHeight:(CGFloat)height{
    isShow=YES;
    coverView=view;
    [UIView animateWithDuration:0.5 animations:^{
        self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
        view.center=CGPointMake(view.center.x, self.frame.origin.y+height+view.frame.size.height/2);
    } completion:^(BOOL finished) {
        coverBtn.frame=view.frame;
        [coverView.superview insertSubview:coverBtn aboveSubview:coverView];
        lastHeight=height;
    }];
}

-(void)hide{
    if(isShow){
        if(typeDelegate!=nil && [typeDelegate respondsToSelector:@selector(typeSelectViewDidHide:)]){
            [typeDelegate typeSelectViewDidHide:self];
        }
        [coverBtn removeFromSuperview];
        [UIView animateWithDuration:0.5 animations:^{
            self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 0);
            coverView.center=CGPointMake(coverView.center.x, self.frame.origin.y+self.frame.size.height+coverView.frame.size.height/2);
        } completion:^(BOOL finished) {
            isShow=NO;
            lastHeight=0;
        }];
    }
}

-(void)createExtraBtn{
    extraBtn=[[UIButton alloc] init];
    [extraBtn.titleLabel setFont:[UIFont fontWithName:@"Arial" size:14.0]];
    [extraBtn setTitle:@"全部" forState:UIControlStateNormal];
    [extraBtn setImage:[UIImage imageNamed:@"type_icon_all"] forState:UIControlStateNormal];
    [extraBtn addTarget:self action:@selector(didExtraBtnClicked) forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark - private method
-(void)reloadScrollView{
    for(id subview in self.subviews){
        if([subview isKindOfClass:[UIButton class]]){
            [subview removeFromSuperview];
        }
    }
    if([buttons isNotEmpty]){
        int width=(self.frame.size.width-(column+1)*borderx)/column;
        for(int i=0;i<[buttons count];i++){
            UIButton *btn=[buttons objectAtIndex:i];
            int x=i%column;
            int y=i/column;
            btn.frame=CGRectMake(borderx*(x+1)+width*x, bordery*(y+1)+width*y, width, width);
            if(btn.imageView.image!=nil){
                float imgHeight=btn.imageView.frame.size.height;
                float imgWidth=btn.imageView.frame.size.width;
                float titleWidth=btn.titleLabel.frame.size.width;
                [btn setImageEdgeInsets:UIEdgeInsetsMake(5, (btn.frame.size.width-BTN_IMAGE_WIDTH)/2, imgHeight-BTN_IMAGE_HEIGHT, (btn.frame.size.width-BTN_IMAGE_WIDTH)/2)];
                [btn setTitleEdgeInsets:UIEdgeInsetsMake(-5, -imgWidth-titleWidth/2, -BTN_IMAGE_HEIGHT, 0)];
            }
            btn.tag=i;
            [self addSubview:btn];
        }
        int rows=(int)ceilf([buttons count]/(float)column);
        self.contentSize=CGSizeMake(self.frame.size.width, width*rows+bordery*(rows+1));
        NSLog(@"rows:%d,height:%f",rows, width*rows+bordery*(rows+1));
    }
}

-(void)didButtonClicked:(id)sender{
    if(typeDelegate!=nil && [typeDelegate respondsToSelector:@selector(typeSelectView:didClickButtonAtIndex:)]){
        if(extraBtnStatus){
            [typeDelegate typeSelectView:self didClickButtonAtIndex:[sender tag]-1];
        }else{
            [typeDelegate typeSelectView:self didClickButtonAtIndex:[sender tag]];
        }
    }
}

-(void)didExtraBtnClicked{
    if(typeDelegate!=nil && [typeDelegate respondsToSelector:@selector(typeSelectViewdidExtraButtonClicked:)]){
        [typeDelegate typeSelectViewdidExtraButtonClicked:self];
    }
}

@end
