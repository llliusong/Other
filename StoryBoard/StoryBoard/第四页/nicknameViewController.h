//
//  nicknameViewController.h
//  SASSEUR
//
//  Created by lius on 15/8/27.
//  Copyright (c) 2015年 lius. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EveryFrameDelegate 

- (void)DonicknameView:(NSString *)name;

@end


@interface nicknameViewController :UIViewController
@property (strong, nonatomic) IBOutlet UIView *userView;
@property (strong, nonatomic) IBOutlet UITextField *nameText;
@property (strong, nonatomic) IBOutlet UIImageView *userImage;
@property (strong, nonatomic) IBOutlet UIButton *okBtn;
- (IBAction)okBtn:(UIButton *)sender;

@property (strong, nonatomic) NSString *namestr;
@property (retain,nonatomic) id <EveryFrameDelegate> delegate;

@end
