//
//  ToggleButton.m
//  ToggleView
//
//  Created by SOMTD on 12/10/15.
//  Copyright (c) 2012年 somtd.com. All rights reserved.
//

#import "ToggleButton.h"

//change button image option
NSString *const TOGGLE_BUTTON_IMAGE_L    = @"icon2";
NSString *const TOGGLE_BUTTON_IMAGE_R    = @"icon2";


@implementation ToggleButton
@synthesize buttonType;

- (id)initWithImage:(UIImage *)image buttonType:(ToggleButtonType)aButtonType
{
    self = [super initWithImage:image];
    if (self) {
        self.buttonType = aButtonType;
        if (self.buttonType == ToggleButtonTypeChangeImage)
        {
            //default select "L"
//            self.image = [UIImage imageNamed:TOGGLE_BUTTON_IMAGE_L];
            self.image = [UIImage imageNamed:TOGGLE_BUTTON_IMAGE_R];
            return self;
        }
    }
    return self;
}

- (void)selectedLeftToggleButton
{
    if (self.buttonType == ToggleButtonTypeChangeImage)
    {
        self.image = [UIImage imageNamed:TOGGLE_BUTTON_IMAGE_L];
    }
}

- (void)selectedRightToggleButton
{
    if (self.buttonType == ToggleButtonTypeChangeImage)
    {
        self.image = [UIImage imageNamed:TOGGLE_BUTTON_IMAGE_R];

    }
}
@end
