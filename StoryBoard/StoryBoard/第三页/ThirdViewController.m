//
//  ThirdViewController.m
//  StoryBoard
//
//  Created by lius on 15/11/11.
//  Copyright © 2015年 LiuS. All rights reserved.
//

#import "ThirdViewController.h"
#import "MyCollectionViewCell.h"
#import "ThirdDetailController.h"

@interface ThirdViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSArray *imageArray;
}

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //注册cell和ReusableView(想当于头部)
    //注册cell和;(相当于头部)
    //注册Cell，必须要有
    self.title = @"第三页";
    [self.collectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:@"MyCollectionViewCell"];
    
//    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    imageArray = @[@"home1",@"home2",@"home3",@"home4",@"home5",@"home6",@"home7",@"home8",@"home9",@"home10",@"home11",@"home12"];
}

#pragma mark 定义展示的UICollectionViewCell 的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    return 12;
}

#pragma mark 定义展示的section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

#pragma mark 每个UICollectionView的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * CellIdentifier = @"MyCollectionViewCell";
    MyCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell sizeToFit];
    if (!cell) {
        NSLog(@"无法在创建cell时打印,自定义的cell就不可能进来了");
        
    }
    cell.imageView.image = [UIImage imageNamed:imageArray[indexPath.row]];
    cell.myLabel.text = @"测试";
    
//    UILabel *label = [[UILabel alloc]initWithFrame:cell.contentView.frame];
//    label.text = @"测试";
//    [cell addSubview:label];
    
    
    return cell;
}

#pragma mark 头部显示的内容
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView" forIndexPath:indexPath];
    
//    [headerView addSubview:self.headAllView];
    return headerView;
}

#pragma mark 定义每个UICollectionView的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
//    return CGSizeMake(self.view.frame.size.width-20, (self.view.frame.size.width-20)/2.3);
     return CGSizeMake(self.view.frame.size.width/5, 100);
}

#pragma mark 定义每个UICollectionView的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 5, 5, 5);
}

#pragma mark 定义每个UICollectionView纵向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

#pragma mark uicollectionview被选中时调用
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
//    ThirdDetailController *the = [ThirdDetailController new];
    ThirdDetailController *the = [[ThirdDetailController alloc] initWithNibName:@"ThirdDetailController" bundle:nil];
    [self.navigationController pushViewController:the animated:YES];
//    NSDictionary *dict = self.homeArr[indexPath.row];
//    
//    if ([_Home_Delegate respondsToSelector:@selector(HomePageConllentionID:DataID:)]) {
//        [_Home_Delegate HomePageConllentionID:self DataID:dict[@"image"]];
//    }
}

#pragma mark 滑动效果
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
//    if (self.contentOffset.y < 64) {
//        
//        if ([_Home_Delegate respondsToSelector:@selector(HomePageConllention:Motion:MotionY:)]) {
//            [_Home_Delegate HomePageConllention:self Motion:@"glide" MotionY:self.contentOffset.y];
//        }
//        
//    }else {
//        
//        if ([_Home_Delegate respondsToSelector:@selector(HomePageConllention:Motion:MotionY:)]) {
//            [_Home_Delegate HomePageConllention:self Motion:@"upglide" MotionY:self.contentOffset.y];
//        }
//        
//    }
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
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
