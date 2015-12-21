//
//  ImageScrollView.m
//  henan-iphone
//
//  Created by ding liu on 13-3-25.
//  Copyright (c) 2013年 teemax. All rights reserved.
//

#import "ImageScrollView.h"
#import "UIImageView+WebCache.h"


@interface ImageScrollView(Private)

-(void)autoChangePage;
-(void)showLastPage;
-(void)showNextPage;

-(void)reloadLastImage;
-(void)reloadCurrentImage;
-(void)reloadNextImage;
-(void)didImageTaped:(UITapGestureRecognizer *)tap;


@end

@implementation ImageScrollView
@synthesize imgURLs,delegate,currentView,currentPage;

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame imageURLs:nil isHiddenPageControl:YES isHiddenSwitchBtn:YES];
}

-(id)initWithFrame:(CGRect)frame imageURLs:(NSArray *)urls isHiddenPageControl:(BOOL)isHidden isHiddenSwitchBtn:(BOOL)isHiddenSwitchBtn {
    return [self initWithFrame:frame imageURLs:urls defaultPage:0 isHiddenPageControl:isHidden isHiddenSwitchBtn:isHiddenSwitchBtn];
}

-(id)initWithFrame:(CGRect)frame imageURLs:(NSArray *)urls defaultPage:(NSUInteger)defaultPage isHiddenPageControl:(BOOL)isHidden isHiddenSwitchBtn:(BOOL)isHiddenSwitchBtn{
    self=[super initWithFrame:frame];
    if(self){
        if(urls==nil){
            imgURLs=[NSArray new];
            totalPage=0;
        }else{
            self.imgURLs=urls;
            totalPage=[imgURLs count];
        }
        //添加scrollview
        scrollview=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        scrollview.delegate=self;
        scrollview.contentSize=CGSizeMake(self.frame.size.width*[imgURLs count], self.frame.size.height);
        scrollview.pagingEnabled=YES;
        scrollview.showsHorizontalScrollIndicator=NO;
        scrollview.showsVerticalScrollIndicator=NO;
        [self addSubview:scrollview];
        //添加imageview
        firstView=[[UIImageView alloc] init];
        secondView=[[UIImageView alloc] init];
        thirdView=[[UIImageView alloc] init];
//        firstView.contentMode=UIViewContentModeScaleAspectFill; // UIViewContentModeScaleAspectFill
//        secondView.contentMode=UIViewContentModeScaleAspectFill;
//        thirdView.contentMode=UIViewContentModeScaleAspectFill;
        firstView.clipsToBounds=YES;
        secondView.clipsToBounds=YES;
        thirdView.clipsToBounds=YES;
        
        [scrollview addSubview:firstView];
        [scrollview addSubview:secondView];
        [scrollview addSubview:thirdView];
        //添加pagecontrol
        pageControl=[[UIPageControl alloc] initWithFrame:CGRectMake(self.frame.size.width/2, self.frame.size.height-20, 10, 10)];
        pageControl.numberOfPages=totalPage;
        [pageControl setCurrentPageIndicatorTintColor:[UIColor redColor]];
        [pageControl setPageIndicatorTintColor:[UIColor whiteColor]];
        
        if (!isHidden) {
            
            [self addSubview:pageControl];
        }
        
        //添加手动切换按钮
        if (!isHiddenSwitchBtn) {
            
            //右边按钮
            UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [rightBtn setImage:ImgByName(@"rightswitch") forState:UIControlStateNormal];
            rightBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
            [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
            rightBtn.frame = CGRectMake(self.frame.size.width - 40, self.frame.size.height/2, 40, 40);
            [self addSubview:rightBtn];
            
            //左边按钮
            UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            leftBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
            [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
            [leftBtn setImage:ImgByName(@"leftswitch") forState:UIControlStateNormal];
            leftBtn.frame = CGRectMake(0, self.frame.size.height/2, 40, 40);
            [self addSubview:leftBtn];
            
        }
        
        
        [self showImageAtPage:defaultPage];
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

#pragma mark -scrollview delegate method
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    isDragging=YES;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    isDragging=NO;
    
    [delegate imageScrollViewDidEndScrollingAnimation:self page:currentPage];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int page=scrollview.contentOffset.x/scrollview.frame.size.width;
    if (page>currentPage) {
        [self showNextPage];
    }
    //向前翻页
    else if(page<currentPage){
        [self showLastPage];
    }
    
}

//手动翻页右按钮
- (void)rightBtnClick
{



}


//手动翻页左按钮
- (void)leftBtnClick
{
    
}

-(void)pageChanged{
    NSArray *subViews = pageControl.subviews;
    for (int i = 0; i < [subViews count]; i++) {
        UIView* subView = [subViews objectAtIndex:i];
        if ([NSStringFromClass([subView class]) isEqualToString:NSStringFromClass([UIImageView class])]) {
            ((UIImageView*)subView).image = (pageControl.currentPage == i ? [UIImage imageNamed:@"pageSelectImg.png"] : [UIImage imageNamed:@"pageImg.png"]);
        }
        
    }
}

#pragma mark - NSTimer methods
-(void)autoChangePage{
    if(!isDragging){
        NSInteger page=(currentPage+1)%totalPage;
        [self showNextPage];
        [scrollview scrollRectToVisible:CGRectMake(self.frame.size.width*page, 0, scrollview.frame.size.width, scrollview.frame.size.height) animated:YES];
        
    }
}

-(void)autoStart{
    if(timer==nil && totalPage>1){
        timer = [NSTimer scheduledTimerWithTimeInterval:7.0 target:self selector:@selector(autoChangePage) userInfo:nil repeats:YES];
    }
}

-(void)autoStop{
    if(timer){
        [timer invalidate];
    }
}

-(void)dealloc
{
    timer = nil;
    [timer invalidate];
}

#pragma mark - 翻页相关
-(void)showImageAtPage:(NSUInteger)page{
    if(totalPage>0){
        lastView=firstView;
        currentView=secondView;
        nextView=thirdView;
        currentPage=page;
        lastPage=(currentPage-1+totalPage)%totalPage;
        nextPage=(currentPage+1)%totalPage;
        pageControl.currentPage=currentPage;
        [self reloadLastImage];
        [self reloadCurrentImage];
        [self reloadNextImage];
    }
}

-(void)showLastPage{
    UIImageView *tempview=currentView;
    currentView=lastView;
    lastView=nextView;
    nextView=tempview;
    nextPage=currentPage;
    currentPage=lastPage;
    lastPage=(currentPage-1+totalPage)%totalPage;
    pageControl.currentPage=currentPage;
    [self reloadLastImage];
}
-(void)showNextPage{
    UIImageView *tempview = currentView;
    currentView=nextView;
    nextView=lastView;
    lastView=tempview;
    lastPage=currentPage;
    currentPage=nextPage;
    nextPage=(currentPage+1)%totalPage;
    pageControl.currentPage=currentPage;
    [self reloadNextImage];
}

#pragma mark - 视图相关
-(void)reloadLastImage{
    lastView.frame=CGRectMake(self.frame.size.width*lastPage, 0, scrollview.frame.size.width, scrollview.frame.size.height);
    NSString *imgPath=[imgURLs objectAtIndex:lastPage];
    [lastView setImageWithURL:[NSURL URLWithString:imgPath] placeholderImage:ImgByName(@"zanwu")];
    
    lastView.tag=lastPage;
    [lastView removeGestureRecognizer:[lastView.gestureRecognizers objectAtIndex:0]];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didImageTaped:)];
    lastView.userInteractionEnabled=YES;
    [lastView addGestureRecognizer:tap];
}

-(void)reloadCurrentImage{
    currentView.frame=CGRectMake(self.frame.size.width*currentPage, 0, scrollview.frame.size.width, scrollview.frame.size.height);
    NSString *imgPath=[imgURLs objectAtIndex:currentPage];
    [currentView setImageWithURL:[NSURL URLWithString:imgPath] placeholderImage:ImgByName(@"zanwu")];

    currentView.tag=currentPage;
    [currentView removeGestureRecognizer:[currentView.gestureRecognizers objectAtIndex:0]];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didImageTaped:)];
    currentView.userInteractionEnabled=YES;
    [currentView addGestureRecognizer:tap];
}

-(void)reloadNextImage{
    nextView.frame=CGRectMake(self.frame.size.width*nextPage, 0, scrollview.frame.size.width, scrollview.frame.size.height);
    NSString *imgPath=[imgURLs objectAtIndex:nextPage];
    
    [nextView setImageWithURL:[NSURL URLWithString:imgPath] placeholderImage:ImgByName(@"zanwu")];
    nextView.tag=nextPage;
    [nextView removeGestureRecognizer:[nextView.gestureRecognizers objectAtIndex:0]];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didImageTaped:)];
    nextView.userInteractionEnabled=YES;
    [nextView addGestureRecognizer:tap];
}

-(void)didImageTaped:(UITapGestureRecognizer *)tap{
//    NSLog(@"tap index:%d",[[tap view] tag]);
    if(delegate!=nil && [delegate respondsToSelector:@selector(imageScrollView:didImageClickedAtIndex:)]){
        [delegate imageScrollView:self didImageClickedAtIndex:[[tap view] tag]];        
    }
}

@end
