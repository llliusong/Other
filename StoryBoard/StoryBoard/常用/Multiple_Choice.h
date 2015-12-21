//
//  Multiple_Choice.h
//  High_Quality_Fabric
//
//  Created by lius on 15/11/10.
//  Copyright © 2015年 lius. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Multiple_Choice;
@protocol Multiple_ChoiceDelegate <NSObject>

- (void) Multiple_Choice:(NSInteger)pitchonInt;
- (void) Multiple_ChoiceArr:(NSArray *)pitchonArr;

@end

@interface Multiple_Choice : UIView

@property(strong,nonatomic) id<Multiple_ChoiceDelegate> Delegate;
@property (strong, nonatomic) UIColor *pitchonColor;
@property (assign, nonatomic) CGFloat fontSize;
@property (strong, nonatomic) NSArray *contentArr;
@property (strong, nonatomic) NSString *stateStr;
@property (assign, nonatomic) NSInteger numrow;

@end
