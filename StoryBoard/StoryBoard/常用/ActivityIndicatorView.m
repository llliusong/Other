//
//  ActivityIndicatorView.m
//  SASSEUR
//
//  Created by lius on 15/8/31.
//  Copyright (c) 2015年 lius. All rights reserved.
//

#import "ActivityIndicatorView.h"

@implementation ActivityIndicatorView

-(id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        
//        self.backgroundColor = [UIColor whiteColor];
        
        allView = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width/2 -60, (frame.size.height - 150)/2, 120, 80)];
        allView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        [self addSubview:allView];
        [allView.layer setMasksToBounds:YES];
        [allView.layer setCornerRadius:10];
        
        self.progressInd=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:
                                               UIActivityIndicatorViewStyleWhiteLarge];
        self.progressInd.center=CGPointMake(allView.frame.size.width/2,allView.frame.size.height/2 -10);
        [allView addSubview:self.progressInd];
        [self.progressInd startAnimating];

        self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, allView.frame.size.height - 25, allView.frame.size.width, 20)];
        self.titleLab.textColor = [UIColor whiteColor];
        self.titleLab.textAlignment = NSTextAlignmentCenter;
        self.titleLab.font = [UIFont systemFontOfSize:13.0];
        [allView addSubview:self.titleLab];
    }
    return self;
}

-(void)TitleStr:(NSString *)titlestr{

    self.titleLab.text = titlestr;
}
@end
