//
//  RootViewController.m
//  label上画横线
//
//  Created by Li Pan on 14-6-30.
//  Copyright (c) 2014年 Pan Li. All rights reserved.
//

#import "RootViewController.h"
#import "LPLabel.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    LPLabel *lp = [[LPLabel alloc] initWithFrame:CGRectMake(60, 200, 200, 100)];
    lp.text =@"Code4App $";
    lp.backgroundColor = [UIColor yellowColor];
    lp.textColor = [UIColor redColor];
    //lp.strikeThroughColor = [UIColor blueColor];
    lp.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lp];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
