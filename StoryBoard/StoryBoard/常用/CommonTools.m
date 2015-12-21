//
//  CommonTools.m
//  WZTrave
//
//  Created by lius on 14/10/20.
//  Copyright (c) 2014年 lius. All rights reserved.
//

#import "CommonTools.h"
#import "SysConfig.h"

@interface CommonTools(Private)

+ (BOOL)isMobileNumber:(NSString *)mobileNum;
+ (BOOL)isChinese:(NSString *)str;
+ (BOOL)isIDCard:(NSString *)idCard;

@end

@implementation CommonTools

static NSString *emailRegex=@"^([a-zA-Z0-9]+[_|\\_|\\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\\_|\\.]?)*[a-zA-Z0-9]+\\.[a-zA-Z]{2,3}$";
static NSString *qqRegex=@"^[1-9][0-9]{4,}$";



void UncaughtedExceptionHandle(NSException *exception){
    NSArray *arr=[exception callStackSymbols];
    NSString *reason=[exception reason];
    NSString *name=[exception name];
    NSString *exceptionText=[NSString stringWithFormat:@"=============异常崩溃报告=============\nname:\n%@\nreason:\n%@\ncallStackSymbols:\n%@",name,reason,[arr componentsJoinedByString:@"\n"]];
    [CommonTools saveAsText:exceptionText];
    [CommonTools sendEmail:exceptionText];
    //    NSLog(@"exceptionText:%@",exceptionText);
    
}

#pragma mark - 消息异常处理
+(void)setExceptionHandler{
    NSSetUncaughtExceptionHandler(&UncaughtedExceptionHandle);
}

+(NSUncaughtExceptionHandler *)getExceptionHandler{
    return NSGetUncaughtExceptionHandler();
}

+(void)saveAsText:(NSString *)exceptionText{
    //    NSLog(@"save text");
    NSString *path=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Exception.txt"];
    [exceptionText writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

+(void)sendEmail:(NSString *)exceptionText{
    //    NSLog(@"send email");
    NSString *appName=(NSString *)[SysConfig getValue:@"CFBundleDisplayName"];
    NSString *version=(NSString *)[SysConfig getValue:BUNDLE_KEY_VERSION];
    NSString *urlStr = [NSString stringWithFormat:@"mailto:bug@xfhlp.com.cn?subject=嗯,遇到麻烦了...%@&body=%@%@发生未捕捉异常错误,希望发送bug至技术支持邮箱,我们会尽快修复该bug,感谢您的配合!<br><br><br>"
                        "错误详情:%@",[NSDate date],appName,version,exceptionText];
    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [[UIApplication sharedApplication] openURL:url];
}

#pragma mark - 格式验证
+(BOOL)validateCheck:(NSString *)str stringType:(ValidType)type{
    NSError *error;
    NSRegularExpression *regex;
    NSTextCheckingResult *result;
    NSString *regexStr = @"";
    if(type==ValidTypeEmail){
        regexStr=emailRegex;
    }else if(type==ValidTypeQQ){
        regexStr=qqRegex;
    }else if(type==ValidTypeMobile){
        return [self isMobileNumber:str];
    }else if(type==ValidTypeChinese){
        return [self isChinese:str];
    }else if(type==ValidTypeIDCard){
        return [self isIDCard:str];
    }
    regex=[NSRegularExpression regularExpressionWithPattern:regexStr options:0 error:&error];
    result=[regex firstMatchInString:str options:0 range:NSMakeRange(0, [str length])];
    if(!result){
        return NO;
    }else{
        return YES;
    }
}

// 正则判断手机号码地址格式
+ (BOOL)isMobileNumber:(NSString *)mobileNum{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,147,150,151,152,157,158,159,178,182,183,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[0235-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,152,157,158,159,178,182,183,187,188(旧)
                * 134,135,136,137,138,139,147,150,151,152,157,158,159,178,182,183,184,187,188
     12         */
//    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[0127-9]|8[23478]|78)\\d)\\d{7}$";
    NSString * CM = @"^1(3[4-9]|47|5[0-27-9]|78|8[2-478])\\d{8}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186(旧)
                * 130，131，132，145，155，156，176，185，186。
     17         */
//    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSString * CU = @"^1(3[0-2]|45|5[56]|76|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189(旧) 
                * 133，153，177，180，181，189
     22         */
//    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    NSString * CT = @"^1(33|53|77|8[019])\\d{8}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

// 正则判断电信手机号码
+ (BOOL)isDianxinNumber:(NSString *)mobileNum{
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if ([regextestct evaluateWithObject:mobileNum] == YES)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+ (BOOL)isEmail:(NSString *)email{
    NSPredicate *regesEmail = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailRegex];
    if ([regesEmail evaluateWithObject:email] == YES) {
        return YES;
    }else{
        return NO;
    }
}

+(BOOL)isChinese:(NSString *)str{
    int length = [str length];
    for (int i=0; i<length; ++i){
        NSRange range = NSMakeRange(i, 1);
        NSString *subString = [str substringWithRange:range];
        const char *cString = [subString UTF8String];
        if (strlen(cString) != 3){
            return NO;
        }
    }
    return YES;
}

+(BOOL)isIDCard:(NSString *)idCard{
    NSString *str=[idCard copy];
    NSArray *cityArr=[NSArray arrayWithObjects:[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],@"北京",@"天津",@"河北",@"山西",@"内蒙古",[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],@"辽宁",@"吉林",@"黑龙江",[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],@"上海",@"江苏",@"浙江",@"安微",@"福建",@"江西",@"山东",[NSNull null],[NSNull null],[NSNull null],@"河南",@"湖北",@"湖南",@"广东",@"广西",@"海南",[NSNull null],[NSNull null],[NSNull null],@"重庆",@"四川",@"贵州",@"云南",@"西藏",[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],@"陕西",@"甘肃",@"青海",@"宁夏",@"新疆",[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],@"台湾",[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],@"香港",@"澳门",[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],@"国外", nil];
    NSArray *wis=[NSArray arrayWithObjects:@"7",@"9",@"10",@"5",@"8",@"4",@"2",@"1",@"6",@"3",@"7",@"9",@"10",@"5",@"8",@"4",@"2", nil];
    NSArray *codes=[NSArray arrayWithObjects:@"1",@"0",@"x",@"9",@"8",@"7",@"6",@"5",@"4",@"3",@"2", nil];
    NSError *error;
    NSRegularExpression *regex;
    NSTextCheckingResult *result;
    
    //数字及地址码验证
    regex=[NSRegularExpression regularExpressionWithPattern:@"^(^\\d{15}$|^\\d{18}$|^\\d{17}(\\d|X|x))$" options:0 error:&error];
    result=[regex firstMatchInString:str options:0 range:NSMakeRange(0, [str length])];
    if(!result){
        return NO;
    }
    str=[idCard lowercaseString];
    if([cityArr objectAtIndex:[[idCard substringWithRange:NSMakeRange(0, 2)] intValue]]==[NSNull null]){
        return NO;
    }
    //日期码验证
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    @try {
        NSString *dateStr=[str substringWithRange:NSMakeRange(6, 8)];
        formatter.dateFormat=@"yyyyMMdd";
        NSDate *date=[formatter dateFromString:dateStr];
        if(!date){
            return NO;
        }
    }
    @catch (NSException *exception) {
        return NO;
    }
    //校验码验证
    int sum=0;
    for(int i=0;i<17;i++){
        int ai=[[str substringWithRange:NSMakeRange(i, 1)] intValue];
        int wi=[[wis objectAtIndex:i] intValue];
        sum+=ai*wi;
    }
    NSString *code=[codes objectAtIndex:(sum%11)];
    if(![code isEqualToString:[str substringWithRange:NSMakeRange(17, 1)]]){
        return NO;
    }
    return YES;
}

#pragma mark - 16进制颜色转换
+(UIColor *)getRGBColor:(NSString *)hexColor{
    unsigned int red, green, blue;
    if([hexColor length]!=7){
        NSLog(@"非7位16进制字符串,正确格式为#000000");
        return nil;
    }
    NSRange range;
    range.length =2;
    range.location =1;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&red];
    range.location =3;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&green];
    range.location =5;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&blue];
    return [UIColor colorWithRed:(float)(red/255.0f)green:(float)(green/255.0f)blue:(float)(blue/255.0f)alpha:1.0f];
}

@end

