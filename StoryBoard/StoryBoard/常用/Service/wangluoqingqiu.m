//
//  wangluoqingqiu.m
//  Home
//
//  Created by lius on 15/7/23.
//  Copyright (c) 2015年 刘松. All rights reserved.
//

#import "wangluoqingqiu.h"
#import <AFNetworking/AFNetworking.h>
@implementation wangluoqingqiu

//+ (void)parm:(NSString *)string Success:(void(^)(id response))success
+ (void)parm:(NSString *)string Success:(CompleteHandle)success
{
//    NSString *str=[NSString stringWithFormat:@"http://app.yg-pump.com/plus/api.php?module=getProDetailByAid"];
    NSURL *url = [NSURL URLWithString:[string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        id dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        NSLog(@"%@",dict);
        
//        nsdDic = @{}.mutableCopy;
//        nsdDic  = dict;
//        [self setSDcy];
//        [self setTitle];
//        [self setParameter];
        success(dict);
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发生错误！%@",error);
        success(error);
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
}

//-(void)withMoney:(void(^)(id salary))amount
//{
//    amount(@134);
//}
+(void)assdSuccess:(CompleteHandle)success
{
//    NSString *str=[NSString stringWithFormat:@"http://cs.mcncn.com/cfg/token=9ef1ab46dd80d2b0e5ed2d2154dca854"];
    NSString *str = [NSString stringWithFormat:@"http://app.yg-pump.com/plus/call.php?mobile=%@",@"15068776210"];
    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        id dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        NSLog(@"获取到的数据为：%@",dict);
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发生错误！%@",error);
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
}






@end
