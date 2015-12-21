//
//  InfiniteScrollView.m
//  WZTrave
//
//  Created by 小麦的rosePooh on 14-8-29.
//  Copyright (c) 2014年 吴书颖. All rights reserved.
//

#import "InfiniteScrollView.h"
#import "UIImageView+WebCache.h"

@interface InfiniteScrollView ()<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    
    UIPageControl *pageControl;
    
    NSArray *imageArrays;
    
    NSTimer *picTimer;
}

@end

@implementation InfiniteScrollView

- (id)initWithFrame:(CGRect)frame andImageData:(NSArray *)imageData
{
    self = [super initWithFrame:frame];
    if (self) {
        imageArrays = [NSArray arrayWithArray:imageData];
        
        //添加滚动视图
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _scrollView.bounces = YES;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.userInteractionEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.decelerationRate = 0.7;
        _scrollView.delaysContentTouches = NO;
        [self addSubview:_scrollView];
        
        // 初始化 pagecontrol
        pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.frame.size.width/2-20, self.frame.size.height-25, 40, 20)];
        [pageControl setCurrentPageIndicatorTintColor:RGBA(98, 170, 230, 1)];
        [pageControl setPageIndicatorTintColor:[UIColor whiteColor]];
        pageControl.numberOfPages = [imageData count];
        pageControl.currentPage = 0;
        if(1 != imageArrays.count){
            [self addSubview:pageControl];
        }
        
        [self initPicScrollView];
    }
    return self;
}

-(void)initPicScrollView{

    //add the last image first
    UIImageView *imageView = [[UIImageView alloc] init];
//    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.frame = CGRectMake(0, 0, 320, self.bounds.size.height);
    imageView.tag = [imageArrays count] - 1;
    [self initImageView:imageView];
    [_scrollView addSubview:imageView];
    for (int i = 0;i<[imageArrays count];i++) {
        //loop this bit
        UIImageView *imageView = [[UIImageView alloc] init];
//        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.tag = i;
        imageView.frame = CGRectMake((320 * i) + 320, 0, 320, self.bounds.size.height);
        [self initImageView:imageView];
        [_scrollView addSubview:imageView];
    }
    //add the first image at the end
    imageView = [[UIImageView alloc] init];
//    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.frame = CGRectMake((320 * ([imageArrays count] + 1)), 0, 320, self.bounds.size.height);
    imageView.tag = 0;
    [self initImageView:imageView];
    [_scrollView addSubview:imageView];
    
    NSInteger imageArraysCount = ([imageArrays count] + 2);
    if (1 == imageArrays.count) {
        imageArraysCount = imageArrays.count;
    }
    
    [_scrollView setContentSize:CGSizeMake(320 * imageArraysCount, self.bounds.size.height)];
    [_scrollView setContentOffset:CGPointMake(0, 0)];
    [_scrollView scrollRectToVisible:CGRectMake(320,0,320,self.bounds.size.height) animated:NO];
    
    float tempTime = 4;
    if (_time) {
        tempTime = _time;
    }
    
    if (1 != imageArrays.count) {//一张图片停止轮播
    
        picTimer = [NSTimer scheduledTimerWithTimeInterval:tempTime target:self selector:@selector(changePicture:) userInfo:nil repeats:YES];
    }
    
}

-(void)initImageView:(UIImageView *)tempimgVew{
    NSString *imgPath = [imageArrays objectAtIndex:tempimgVew.tag];
//#warning 待改
//    [tempimgVew setImageWithURL:[NSURL URLWithString:imgPath] placeholderImage:[UIImage imageNamed:@"zanwu"]];//这句注释打开
    [tempimgVew setImage:ImgByName(imgPath)];//这句注释掉

    tempimgVew.userInteractionEnabled = YES;
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicInfo:)];
    [tempimgVew addGestureRecognizer:recognizer];
}

#pragma mark - scrollview delegate method

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    int page = floor((_scrollView.contentOffset.x - _scrollView.frame.size.width / ([imageArrays count]+2)) / _scrollView.frame.size.width) + 1;
    if (0 == page) {
        //go last but 1 page
        [_scrollView scrollRectToVisible:CGRectMake(320 * [imageArrays count],0,320,self.bounds.size.height) animated:NO];
    } else if (page == ([imageArrays count]+1)) {//如果是最后+1,也就是要开始循环的第一个
        
        [_scrollView scrollRectToVisible:CGRectMake(320,0,320,self.bounds.size.height) animated:NO];
        
        
    }
    int index = page-1;
    if (page > [imageArrays count]) {
        index = 0;
    }
    
    if (0 == page) {
        index = imageArrays.count;

    }
    
    NSLog(@"imageArrays == %lu", (unsigned long)imageArrays.count);

    NSLog(@"page == %d", page);
    
    pageControl.currentPage = index;
    
}

-(void)changePicture:(NSTimer *)timer{
    CGPoint pt = _scrollView.contentOffset;
    NSInteger count = [imageArrays count];
    if(pt.x == 320 * count){
        [_scrollView setContentOffset:CGPointMake(0, 0)];
        
        [_scrollView scrollRectToVisible:CGRectMake(320,0,320,self.bounds.size.height) animated:YES];
        
    }else{
        
        [_scrollView scrollRectToVisible:CGRectMake(pt.x+320,0,320,self.bounds.size.height) animated:YES];

    }
    
    int index = pt.x/320;
    if (index == [imageArrays count]) {
        index = 0;
    }
    pageControl.currentPage = index;
}

-(void)showPicInfo:(UITapGestureRecognizer *)sender{
    NSLog(@"%ld", (long)pageControl.currentPage);
    if ([_delegate respondsToSelector:@selector(imageScrollView:didImageClickedAtIndex:)]) {
        [_delegate imageScrollView:self didImageClickedAtIndex:pageControl.currentPage +1];
        NSLog(@"%ld", (long)pageControl.currentPage);
    }
}

@end
