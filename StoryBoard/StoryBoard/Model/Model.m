//
//  Model.m
//  StoryBoard
//
//  Created by lius on 15/12/16.
//  Copyright © 2015年 LiuS. All rights reserved.
//

#import "Model.h"

@implementation Model
@synthesize title;
@synthesize subtitle;
@synthesize price;
@synthesize address;
@synthesize distance;

-(id)init{
    self = [super init];
    if (self) {
        self.price = @"23";
    }
    return self;
}

@end
