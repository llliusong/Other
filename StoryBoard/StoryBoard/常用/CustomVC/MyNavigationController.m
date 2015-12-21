//
//  MyNavigationController.m
//  youyouzj
//
//  Created by 小麦的rosePooh on 14-10-13.
//  Copyright (c) 2014年 小麦的rosePooh. All rights reserved.
//

#import "MyNavigationController.h"
#import "UIImage+WB.h"
#import "UIBarButtonItem+IW.h"

@interface MyNavigationController ()

@end

@implementation MyNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    
        [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
        
    }
    return self;
}

-(void)popself{
    if([self.viewControllers count]>1){
        [self popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

-(UIBarButtonItem *)createBackButton{
    
    UIBarButtonItem *someBarButtonItem = [UIBarButtonItem itemWithImage:@"back" edgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)  higlightedImage:@"back" target:self action:@selector(popself)];
    
    return someBarButtonItem;
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [super pushViewController:viewController animated:animated];
    //防御性措施，在没有做导航按钮，创建导航栏按钮
    if (viewController.navigationItem.leftBarButtonItem == nil && [self.viewControllers count] > 1)   {
        viewController.navigationItem.leftBarButtonItem =[self createBackButton];
        
        if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.interactivePopGestureRecognizer.delegate = nil;
        }
        
    }
}


@end
