//
//  SysConfig.m
//  baseFrame-v2
//
//  Created by lius on 13-5-30.
//  Copyright (c) 2013年 lius. All rights reserved.
//

#import "SysConfig.h"
#import "Reachability.h"
#import "RegexKitLite.h"

static NSDictionary *cfgDict;
@implementation SysConfig

+(BOOL)isNetworkReachable{
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        return NO;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}

+ (BOOL)isWiFiConnection {
    BOOL result = NO;
    Reachability *reach=[Reachability reachabilityForInternetConnection];
    [reach startNotifier];
    NetworkStatus status;
    status=[reach currentReachabilityStatus];
    if (status == ReachableViaWiFi) {
        result = YES;
    }
    return result;
}

+(BOOL)isDebug{
    if((NSNull *)[self getValue:BUNDLE_KEY_DEBUG_MODE]!=[NSNull null]){
        return [[SysConfig getValue:BUNDLE_KEY_DEBUG_MODE] boolValue];
    }
    //默认非debug模式
    return NO;
}

+(NSObject *)getValue:(NSString *)key{
    if(cfgDict == nil){
        NSString* File = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
        cfgDict = [[NSDictionary alloc] initWithContentsOfFile:File];
    }
    NSLog(@"%@",[cfgDict objectForKey:key]);
    return [cfgDict objectForKey:key];
}

+(NSString *)getDataFile{
    NSString *dataPath = @"";
    dataPath = [ROOT_FOLDER stringByAppendingPathComponent:(NSString *)[self getValue:BUNDLE_KEY_DATA]];
    
    return dataPath;
}

+(NSString *)getAudioFolderPath{
    NSString *audioPath = @"";
    audioPath = [ROOT_FOLDER stringByAppendingPathComponent:@"audio"];
    return audioPath;
}

+(NSString *)getAudioFilePath:(NSString *) fileName{
    if(fileName==nil || [fileName isEqual:[NSNull null]]){
        NSLog(@"音频名称为空");
        return nil;
    }
    return [[self getAudioFolderPath] stringByAppendingPathComponent:[fileName lastPathComponent]];
}

+(NSString *)getLocalAudioFilePath:(NSString *)fileName{
    if(fileName==nil || [fileName isEqual:[NSNull null]]){
        return nil;
    }
    NSString *filePath=[[NSBundle mainBundle] resourcePath];
    filePath=[filePath stringByAppendingPathComponent:[fileName lastPathComponent]];
    return filePath;
}

+(NSString *)getImageForderPath{
    NSString *imagePath=@"";
    imagePath = [ROOT_FOLDER stringByAppendingPathComponent:@"images"];
    return imagePath;
}

+(NSString *)getImagePath:(NSString *)fileName{
    if(fileName==nil || [fileName isEqualToString:@""]){
        return nil;
    }
    fileName = [fileName stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    fileName = [fileName stringByReplacingOccurrencesOfString:@"." withString:@"_"];
    NSString *path=[[self getImageForderPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",fileName]];
    return path;
}

+(NSString *)getLocalImagePath:(NSString *)fileName{
    if(fileName==nil || [fileName isEqualToString:@""]){
        return nil;
    }
    NSString *filePath=[[NSBundle mainBundle] resourcePath];
    filePath=[filePath stringByAppendingPathComponent:[fileName lastPathComponent]];
    return filePath;
}

+(NSString *)getZipForderPath{
    NSString *imagePath=@"";
    imagePath = [ROOT_FOLDER stringByAppendingPathComponent:@"zip"];
    return imagePath;
}

+(NSString *)getZipFilePath:(NSString *) fileName{
    if(fileName==nil || [fileName isEqualToString:@""]){
        NSLog(@"压缩包名字为空");
        return nil;
    }
    NSString *path=[[self getZipForderPath] stringByAppendingPathComponent:[fileName lastPathComponent]];
    return path;
}


+(NSString *)getCurrentVersion{
    return (NSString *)[self getValue:BUNDLE_KEY_VERSION];
}


+(float)getCurrentBatteryLevel{
    UIDevice *device=[UIDevice currentDevice];
    [device setBatteryMonitoringEnabled:YES];//电量告诫
    return device.batteryLevel;
}


+(NSString *) getWebAPI{
    return [self getValue:BUNDLE_KEY_API];
}

+ (CGFloat)getCurrentTextSize:(NSString *)text andFont:(CGFloat)fontSize
{
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
    CGSize size = CGSizeMake(300,MAXFLOAT);

    CGSize retSize = [text boundingRectWithSize:size options:
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                          attributes:attribute
                                             context:nil].size;
    return retSize.height;
    
}

+(NSString *)clearHTML:(NSString *)html
{
    html = [html stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@"\n"];
    html = [html stringByReplacingOccurrencesOfString:@"<br/>" withString:@"\n"];
    NSRegularExpression *regularExpretion=[NSRegularExpression regularExpressionWithPattern:@"<[^>]*>|" options:0 error:nil];
    
    html = [regularExpretion stringByReplacingMatchesInString:html options:NSMatchingReportProgress range:NSMakeRange(0,
                                                                                                                      html.length) withTemplate:@"\n"];//替换所有html和换行匹配元素为"-"
    
    regularExpretion=[NSRegularExpression regularExpressionWithPattern:@"-{1,}" options:0 error:nil];
    
    html=[regularExpretion stringByReplacingMatchesInString:html options:NSMatchingReportProgress range:NSMakeRange(0,
                                                                                                                    html.length) withTemplate:@"\n"];//把多个"-"匹配为一个"-"
    
    html = [html stringByReplacingOccurrencesOfString:@"-‍-‍-" withString:@""];
    html = [html stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    return html;
    
}

+(NSString *)replaceString:(NSString *)str withRegex:(NSString *)regex withReplace:(NSString *)replace{
    NSString *replacedString = nil;
    if (str != nil) {
        replacedString = [str stringByReplacingOccurrencesOfString:regex withString:replace];
    }
    return replacedString;
    
}


+ (NSString *)getSandboxStoragePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+(NSString *)formatSyncDate:(NSString *)syncDate{
    
    NSString *formatDate=[syncDate stringByReplacingOccurrencesOfString:@"-" withString:@""];
    formatDate=[formatDate stringByReplacingOccurrencesOfString:@" " withString:@""];
    formatDate=[formatDate stringByReplacingOccurrencesOfString:@":" withString:@""];
    formatDate=[formatDate stringByReplacingOccurrencesOfString:@"T" withString:@""];

    return formatDate;
    
}

+(NSDate *)formatSringWithDate:(NSString *)dateString andFormat:(NSString *)format
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:format];
    
    NSDate *date = [formatter dateFromString:dateString];
    
    return date;
}

+(NSString *)formatDate:(NSDate *)date andFormat:(NSString *)format{
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:format];
   
    NSString *str = [formatter stringFromDate:date];
    return str;

}

+(NSString *)formatDateSring:(NSString *)dateString andIndex:(int)index
{
    if (0 != dateString.length & dateString.length > index) {
        
        NSString *sub = [dateString substringToIndex:index];
        
        return sub;
        
    }else{
        return dateString;
    }
    
    return dateString;
}

+(BOOL)isSameDay:(NSDate*)date1 date2:(NSDate*)date2
{
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
    
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];
    
    return [comp1 day]   == [comp2 day] &&
    
    [comp1 month] == [comp2 month] &&
    
    [comp1 year]  == [comp2 year];
    
}

+(NSMutableArray *)formatGoArray:(NSString*)goString
{
    NSRange range = [goString rangeOfString:@","];
    if (range.length > 0)
    {
        NSArray *strs = [goString componentsSeparatedByString:@","];
        
        NSMutableArray *array = [NSMutableArray array];
        for (NSString *str in strs) {
            
            NSString *string = [str stringByReplacingOccurrencesOfString:@"-" withString:@""];
            
            [array addObject:string];
            
        }
        return array;
    }else{
        
        NSMutableArray *array = [NSMutableArray array];
        NSString *string = [goString stringByReplacingOccurrencesOfString:@"-" withString:@""];
        [array addObject:string];
        
        return array;
        
    }
    
    return nil;
}



+(NSString *)retainedTwoDecimalPlaces:(double)number
{
    
    NSString *str = [NSString stringWithFormat:@"%.2f", number];
    
    return str;
}

+(BOOL)isValidateEmail:(NSString *)email {
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email];
    
}

+ (NSString *)getNowTime
{
    NSDate *dateline = [NSDate date];
    
    NSDateFormatter *dateformat=[[NSDateFormatter alloc] init];
    [dateformat setDateFormat:@"yyyy-MM-dd"];
    NSString * nowTime = [dateformat stringFromDate:dateline];
    
    NSLog(@"now time = %@",nowTime);
    
    return nowTime;
}

+ (NSString *)getNowTimeFormat
{
    NSDate *dateline = [NSDate date];
    
    NSDateFormatter *dateformat=[[NSDateFormatter alloc] init];
    [dateformat setDateFormat:@"yyyyMMddHHmmss"];
    NSString * nowTime = [dateformat stringFromDate:dateline];
    
    NSLog(@"now time = %@",nowTime);
    
    return nowTime;
}

+(NSString *)flattenHTML:(NSString *)html{
    NSString *regexString1 = @"<w:WordDocument>[\\s\\S]*<\\/w:WordDocument>";
    html = [html stringByReplacingOccurrencesOfRegex:regexString1 withString:@""];
    NSString *regexString2 = @"<style>[\\s\\S]*<\\/style>";
    html = [html stringByReplacingOccurrencesOfRegex:regexString2 withString:@""];
    html = [self replaceString:html withRegex: @"\\@\\{tel\\:(\\d{7,16})\\}" withReplace:@""];
    html = [self replaceString:html withRegex: @"\\@\\{NAV\\:(.+?)\\|(\\d+)\\}" withReplace:@""];
    html = [self replaceString:html withRegex: @"\\@\\{MAP\\:(.+?)\\|(\\d+)\\}" withReplace:@""];
    
    NSScanner *theScanner;
    NSString *text = nil;
    
    theScanner = [NSScanner scannerWithString:html];
    
    html = [html stringByReplacingOccurrencesOfString:@"<br/>" withString:@"\n"];
    while ([theScanner isAtEnd] == NO) {
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:
                [ NSString stringWithFormat:@"%@>", text]
                                               withString:@" "];
    }
    
    // while //
    html = [html stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@"  "];
    html = [html stringByReplacingOccurrencesOfString:@"&ldquo;" withString:@"“"];
    html = [html stringByReplacingOccurrencesOfString:@"&rdquo;" withString:@"”"];
    html = [html stringByReplacingOccurrencesOfString:@"&middot;" withString:@"·"];
    html = [html stringByReplacingOccurrencesOfString:@"&mdash;" withString:@"-"];
    //    NSString *regexString3 = @"<span[\\s\\S]>";
    //    html = [html stringByReplacingOccurrencesOfRegex:regexString3 withString:@""];
    return html;
    
}

+ (NSString *)getCommentWithNumber:(NSNumber *)num
{
    
    int number = (int)([num floatValue] *100);
    
    if ((400 <=  number)) {
        return @"非常好";
    }else if ((300 <=  number) | (400 >  number)){
        return @"好";
    }else if ((200 <=  number) | (300 >  number)){
        return @"一般";
    }else if (number < 200){
        return @"较差";
    }else{
        return @"好";
    }
}

+ (NSString *)getLevelWithNumber:(int )number
{
    switch (number) {
        case 1:
        {
            return @"A";
        }
            break;
        case 2:
        {
            return @"AA";
        }
            break;
        case 3:
        {
            return @"AAA";
        }
            break;
        case 4:
        {
            return @"AAAA";
        }
            break;
        case 5:
        {
            return @"AAAAA";
        }
            break;
        default:
            break;
    }

    return @"AAAA";
}

+(NSInteger)returnByTwoWidth:(CGFloat)originalWidth andInput:(CGFloat)inputWidth
{
    CGFloat difference = originalWidth - inputWidth;
    
    NSLog(@"==%f", difference);
    
    if ((5.0f <=  difference)) {
        return 23;
    }else if ((-5.0f <=  difference) & (5.0f > difference)){
        return 21;
    }else if ((-15.0f <=  difference) & (-5.0f > difference)){
        return 18;
    }else if ((-25.0f <=  difference) & (-15.0f > difference)){
        return 16;
    }else if ((-35.0f <=  difference) & (-25.0f > difference)){
        return 13;
    }else{
        return 18;
    }
}

+(NSString *)secondsByMinutes:(int)seconds
{
    int m,h;
    int mm = seconds;//你自己的秒数
    m = mm/60;//分钟
    h = m/60;//小时
    
    if(m < 60)
    {
//        NSLog(@"%d分钟",m);
        return [NSString stringWithFormat:@"%d分",m];
    }
    if (!(m % 60)) {
        h = m/60;
//        NSLog(@"%d时",h);
        return [NSString stringWithFormat:@"%d时",h];
    }
    else
    {
        h = m/60;
        m = m%60;
//        NSLog(@"%d时%d分钟",h,m);
        return [NSString stringWithFormat:@"%d时%d分",h,m];
    }
}
@end
