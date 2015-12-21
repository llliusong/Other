//
//  ActivityIndicatorView.h
//  SASSEUR
//
//  Created by lius on 15/8/31.
//  Copyright (c) 2015年 lius. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityIndicatorView : UIView
{

    UIView *allView;
}
@property (nonatomic, strong)UIActivityIndicatorView  *progressInd;
@property (nonatomic, strong) UILabel *titleLab;


-(void)TitleStr:(NSString *)titlestr;
@end
