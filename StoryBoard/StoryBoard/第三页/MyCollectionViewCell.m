//
//  MyCollectionViewCell.m
//  Agricultural
//
//  Created by JGW on 15/9/8.
//  Copyright (c) 2015年 jgw. All rights reserved.
//

#import "MyCollectionViewCell.h"
#define ItemMargin 5
#define LabelHeight 30
@implementation MyCollectionViewCell
//判断是否是4寸屏
#define IS_IPHONE5 [UIScreen mainScreen].bounds.size.height==568?YES:NO

//判断是否是3.5寸屏
#define IS_IPHONE4 [UIScreen mainScreen].bounds.size.height==480?YES:NO

//判断是否是iPhone6
#define IS_IPHONE6 [UIScreen mainScreen].bounds.size.height==667?YES:NO

//判断是否是iPhone6plus
#define IS_IPHONE6plus [UIScreen mainScreen].bounds.size.height==736?YES:NO

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
       // self.layer.borderWidth = 1.0;
//        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(ItemMargin, ItemMargin,self.frame.size.width-ItemMargin*2, self.frame.size.height-ItemMargin*3-LabelHeight)];
        NSLog(@"%f",[UIScreen mainScreen].bounds.size.height);
        if (IS_IPHONE6) {
            self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 60, 60)];
        }
        else if (IS_IPHONE6plus)
        {
            self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(18, 5, 60, 60)];
        }
        else
        {
            self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 60, 60)];
            
        }

        
//        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(12, 12, self.frame.size.width - 24, self.frame.size.height - 30)];
//        self.imageView.center = self.center;
        [self addSubview:self.imageView];
        
        self.myLabel = [[UILabel alloc]initWithFrame:CGRectMake(ItemMargin,self.imageView.frame.size.height+ItemMargin*2,self.imageView.frame.size.width, 30)];
//        self.myLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 90, 60, 40)];
        self.myLabel.textAlignment = NSTextAlignmentCenter;
        self.myLabel.font = [UIFont fontWithName:nil size:12];
        [self addSubview:self.myLabel];
    }
    return self;
}

+ (instancetype)cellWithCollectionView:(UICollectionView *)conllectionView indexPath:(NSIndexPath *)indexPath
{
    
    static NSString *ID = @"MyCollectionViewCell";
    MyCollectionViewCell *cell = [conllectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];;
    
    if (cell == nil) {
        UINib *nib = [UINib nibWithNibName:ID bundle:nil];
        [conllectionView registerNib:nib forCellWithReuseIdentifier:ID];
    }
    
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
    
}


@end
