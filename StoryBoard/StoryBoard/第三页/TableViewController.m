//
//  TableViewController.m
//  StoryBoard
//
//  Created by lius on 15/11/30.
//  Copyright © 2015年 LiuS. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()
//@property (weak, nonatomic) IBOutlet UICollectionView *CollectionView;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - RPSlidingMenuViewController


-(NSInteger)numberOfItemsInSlidingMenu{
    // 10 for demo purposes, typically the count of some array
    return 10;
}

- (void)customizeCell:(RPSlidingMenuCell *)slidingMenuCell forRow:(NSInteger)row{
    
    // alternate for demo.  Simply set the properties of the passed in cell
    if (row % 2 == 0) {
        slidingMenuCell.textLabel.text = @"Something Special";
        slidingMenuCell.detailTextLabel.text = @"For your loved ones!";
        slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"image1_320x210"];
    }else{
        
        slidingMenuCell.textLabel.text = @"This Thing Too";
        slidingMenuCell.detailTextLabel.text = @"This thing will blow your mind.";
        slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"image2_320x210"];
    }
    
}

- (void)slidingMenu:(RPSlidingMenuViewController *)slidingMenu didSelectItemAtRow:(NSInteger)row{
    
    [super slidingMenu:slidingMenu didSelectItemAtRow:row];
    
    // when a row is tapped do some action
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Row Tapped"
                                                    message:[NSString stringWithFormat:@"Row %ld tapped.", (long)row]
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles: nil];
    [alert show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
