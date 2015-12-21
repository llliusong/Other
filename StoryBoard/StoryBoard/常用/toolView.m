//
//  tollView.m
//  miaoshou
//
//  Created by lius on 15/9/29.
//  Copyright (c) 2015年 lius. All rights reserved.
//

#import "toolView.h"
#import "Header.h"
#import "MBProgressHUD.h"
@implementation toolView{
    
}

#pragma mark 边框
+(void)makeCorner:(CGFloat)corner view:(UIView *)view color:(UIColor *)color{
    
    CALayer * fileslayer = [view layer];
    fileslayer.borderColor = [color CGColor];
    fileslayer.borderWidth = corner;
    
}

+ (void)postUrl:(NSString *)url parameter:(NSDictionary *)parameter success:(void(^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:url parameters:parameter success:success failure:failure];
}

+ (void)getUrl:(NSString *)url parameter:(NSDictionary *)parameter success:(void(^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFCompoundResponseSerializer serializer];
    [manager GET:url parameters:parameter success:success failure:failure];
    
}

#pragma mark 提示
+ (void)showAlertWIthView:(UIView *)view Message:(NSString *)message withImageName:(NSString *)imageName
{
    MBProgressHUD *HUD = [[MBProgressHUD alloc]initWithView:view];
    
    HUD.labelText = message;
    HUD.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    HUD.mode = MBProgressHUDModeCustomView;
    [view addSubview:HUD];
    [HUD showAnimated:YES whileExecutingBlock:^{
        sleep(2.0f);
    } completionBlock:^{
        
    }];
}

#pragma mark 圆角
+(void)makeCircular:(UIView *)beadView Circularfloat:(CGFloat)Circularfloat{

    [beadView.layer setMasksToBounds:YES];
    [beadView.layer setCornerRadius:Circularfloat];
}

#pragma mark 旋转
+ (void)rotateSpinningView:(UIView *)view
{

    //执行动画效果（执行完毕以后再执行代码）
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI *  2.0];
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    rotationAnimation.duration = 0.5;
    rotationAnimation.repeatCount = 5;//你可以设置到最大的整数值
    rotationAnimation.cumulative = NO;
    rotationAnimation.removedOnCompletion = NO;
    rotationAnimation.fillMode = kCAFillModeForwards;
    [view.layer addAnimation:rotationAnimation forKey:@"Rotation"];
}

#pragma mark 分割
+ (void)segmentationView:(UIView *)view{

    UIView *topview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    topview.backgroundColor = [UIColor colorWithRed:221.0/255.0 green:221.0/255.0 blue:221.0/255.0 alpha:1.0];
    [view addSubview:topview];
    
    UIView *bottmview = [[UIView alloc] initWithFrame:CGRectMake(0, 9.5, SCREEN_WIDTH, 0.5)];
    bottmview.backgroundColor = [UIColor colorWithRed:221.0/255.0 green:221.0/255.0 blue:221.0/255.0 alpha:1.0];
    [view addSubview:bottmview];
}


#pragma mark 底部灰色线条
+(void)setBottom:(NSArray *)viewArr{
    
    for (int i = 0; i<viewArr.count; i++) {
        
        UIView *view = viewArr[i];
        NSLog(@"%f%f",SCREEN_WIDTH,view.frame.size.width);
        UIView *bottomview = [[UIView alloc] initWithFrame:CGRectMake(0, view.frame.size.height-0.5, [[UIScreen mainScreen] bounds].size.width, 0.5)];
        bottomview.backgroundColor = [UIColor colorWithRed:221.0/255.0 green:221.0/255.0 blue:221.0/255.0 alpha:1.0];
        [view addSubview:bottomview];
    }
}

#pragma mark 底部灰色线条
+(void)setFoursides:(UIView *)view Direction:(NSString *)dirction{
    
    if ([dirction  isEqual: @"left"]) {
        
        UIView *bottomview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5, view.frame.size.height)];
        bottomview.backgroundColor = [UIColor colorWithRed:221.0/255.0 green:221.0/255.0 blue:221.0/255.0 alpha:1.0];
        [view addSubview:bottomview];
        
    }else if([dirction  isEqual: @"right"]){
    
        UIView *bottomview = [[UIView alloc] initWithFrame:CGRectMake(view.frame.size.width - 0.5, 0, 0.5, view.frame.size.height)];
        bottomview.backgroundColor = [UIColor colorWithRed:221.0/255.0 green:221.0/255.0 blue:221.0/255.0 alpha:1.0];
        [view addSubview:bottomview];
        
    }else if([dirction  isEqual: @"top"]){
        
        UIView *bottomview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, 0.5)];
        bottomview.backgroundColor = [UIColor colorWithRed:221.0/255.0 green:221.0/255.0 blue:221.0/255.0 alpha:1.0];
        [view addSubview:bottomview];
        
    }else if([dirction  isEqual: @"bottom"]){
        
        UIView *bottomview = [[UIView alloc] initWithFrame:CGRectMake(0, view.frame.size.height - 0.5, view.frame.size.width, 0.5)];
        bottomview.backgroundColor = [UIColor colorWithRed:221.0/255.0 green:221.0/255.0 blue:221.0/255.0 alpha:1.0];
        [view addSubview:bottomview];
    }
}

#pragma mark 底部灰色线条
+(void)setBottomView:(UIView *)view ViewW:(CGFloat )viewW{
    
        UIView *bottomview = [[UIView alloc] initWithFrame:CGRectMake(0, view.frame.size.height-0.5, viewW, 0.5)];
        bottomview.backgroundColor = [UIColor colorWithRed:221.0/255.0 green:221.0/255.0 blue:221.0/255.0 alpha:1.0];
        [view addSubview:bottomview];
}

#pragma mark 正则判断手机号码地址格式
+ (BOOL)isMobileNumber:(NSString *)mobileNum{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,183,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[0235-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,183,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2378])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
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

#pragma mark 邮箱号验证
+ (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


#pragma mark 返回时间
+ (NSString *)GetNsintger:(NSInteger )integer{
    
    NSDate *  aDate=[NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:aDate];
    [components setDay:([components day]+integer)];
    
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    NSDateFormatter *dateday = [[NSDateFormatter alloc] init] ;
    [dateday setDateFormat:@"yyyy-MM-dd"];
    return [dateday stringFromDate:beginningOfWeek];
}

#pragma mark 获取当前时间
+ (NSString *)GetCurrent{
    
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    return locationString;
}

#pragma mark 提示
+(void)PromptView:(NSString *)contentStr view:(UIView *)view Location:(NSString *)locationStr{
    

    static int n = 0;
    n++;
    UIView *bottomView;
    if (n == 1) {
        
        UILabel *label = [[UILabel alloc]init];
        label.font = [UIFont systemFontOfSize:13.0];
        
        CGSize size = [contentStr sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:label.font,NSFontAttributeName, nil]];
        CGFloat nameW = size.width;
        
        bottomView = [[UIView alloc] init];
        if ([locationStr  isEqual: @"centre"]) {
            
            bottomView.frame = CGRectMake((SCREEN_WIDTH-nameW -30)/2, SCREEN_HEIGHT/2 - 30,  nameW + 30, 30);
            
        }else if([locationStr  isEqual: @"bottom"]){
            
            bottomView.frame = CGRectMake((SCREEN_WIDTH-nameW -30)/2, SCREEN_HEIGHT - 150, nameW + 30, 30);
            
        }
        bottomView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        [view addSubview:bottomView];
        [bottomView.layer setMasksToBounds:YES];
        [bottomView.layer setCornerRadius:5];
        [bottomView bringSubviewToFront:view];
        
        UILabel *promptLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, bottomView.frame.size.width, bottomView.frame.size.height)];
        promptLab.textColor = [UIColor whiteColor];
        promptLab.text = contentStr;
        promptLab.textAlignment = NSTextAlignmentCenter;
        promptLab.font = [UIFont systemFontOfSize:14.0];
        [bottomView addSubview:promptLab];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [bottomView removeFromSuperview];
         n = 0;
       
    });
    
}

#pragma mark 返回几分钟前
+ (NSString *)intervalSinceNow: (NSString *) theDate
{
    
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *d=[date dateFromString:theDate];
    
    NSTimeInterval late=[d timeIntervalSince1970]*1;
    
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    NSString *timeString=@"";
    
    NSTimeInterval cha=now-late;
    
    if (cha/3600<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/60];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
        
    }
    if (cha/3600>1&&cha/86400<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@小时前", timeString];
    }
    if (cha/86400>1)
    {
        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@天前", timeString];
        
    }
    
    return timeString;
}


#pragma mark 是在行间距
+ (void)setLineSpacing:(CGFloat)floats Label:(UILabel *)label Content:(NSString *)contenstr {

    NSMutableAttributedString *attributedString =[[NSMutableAttributedString alloc]initWithString:contenstr];

    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:floats];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [contenstr length])];
    label.attributedText = attributedString;
    [label sizeToFit];
}

#pragma mark 抖动动画
+ (void)rotation:(UIImageView *)imageView {
    //1,创建核心动画
    CAKeyframeAnimation *keyAnima = [CAKeyframeAnimation animation];
    
    //2,告诉系统执行什么动画。
    keyAnima.keyPath = @"transform.rotation";
    
    //              (-M_PI_4 /90.0 * 5)表示-5度 。
    keyAnima.values = @[@(-M_PI_4 /90.0 * 5),@(M_PI_4 /90.0 * 5),@(-M_PI_4 /90.0 * 5)];
    
    // 1.2.1执行完之后不删除动画
    keyAnima.removedOnCompletion = NO;
    // 1.2.2执行完之后保存最新的状态
    keyAnima.fillMode = kCAFillModeForwards;
    
    //动画执行时间
    keyAnima.duration = 0.2;
    
    //设置重复次数。
    keyAnima.repeatCount = MAXFLOAT;
    
    // 2.添加核心动画
    [imageView.layer addAnimation:keyAnima forKey:nil];
}

#pragma mark 抖动动画
+(void)JitterAnimation:(UIView *)view{
    
    // 晃动次数
    int numberOfShakes = 6;
    // 晃动幅度（相对于总宽度）
    static float vigourOfShake = 0.04f;
    // 晃动延续时常（秒）
    static float durationOfShake = 0.5f;
    
    CAKeyframeAnimation *shakeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    // 关键帧（点）
    CGPoint layerPosition = view.layer.position;
    
    // 起始点
    NSValue *value1=[NSValue valueWithCGPoint:view.layer.position];
    // 关键点数组
    NSMutableArray *values = [[NSMutableArray alloc] initWithObjects:value1, nil];
    for (int i = 0; i<numberOfShakes; i++) {
        // 左右晃动的点
        NSValue *valueLeft = [NSValue valueWithCGPoint:CGPointMake(layerPosition.x-view.frame.size.width*vigourOfShake*(1-(float)i/numberOfShakes), layerPosition.y)];
        NSValue *valueRight = [NSValue valueWithCGPoint:CGPointMake(layerPosition.x+view.frame.size.width*vigourOfShake*(1-(float)i/numberOfShakes), layerPosition.y)];
        
        [values addObject:valueLeft];
        [values addObject:valueRight];
    }
    // 最后回归到起始点
    [values addObject:value1];
    
    shakeAnimation.values = values;
    shakeAnimation.duration = durationOfShake;
    [view.layer addAnimation:shakeAnimation forKey:kCATransition];
}

#pragma mark 编码
+ (NSString *)UTF8:(NSString *)str{
    
    [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return str;
}

#pragma mark 读取本地
+ (id)ReadData:(NSString *)key{

    NSUserDefaults *userDefault;
    userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault objectForKey:key];
    return [userDefault objectForKey:key];
}

#pragma mark 查询时获取本地的Top数据
+ (void)InquireLining:(NSString *)inquireStr TopArray:(NSMutableArray *)toparr TopContentArray:(NSMutableArray *)topcontentarr{

    [toparr removeAllObjects];
    [topcontentarr removeAllObjects];
    NSString *plistPathfj = [[NSBundle mainBundle] pathForResource:@"Property List" ofType:@"plist"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPathfj];
    NSDictionary *dict = dic[@"InquireLining"];
    NSDictionary *dicts = dict[inquireStr];
 
    
    for (NSArray *array in dicts[@"TopArr"]) {
        [toparr addObject:array];
    }
    
    for (NSArray *array in dicts[@"topContentArray"]) {
        [topcontentarr addObject: array];
    }
    
   
}

#pragma mark 动态获取文本高度
+ (CGFloat)GetUILabelSize:(NSString *)contentStr UILabelFont:(CGFloat )fontsize UILabelWidth:(CGFloat)width UILabelHeight:(CGFloat)height SetField:(NSString *)field{

    UIFont *font = UIFont(fontsize);
    if ([field  isEqual: @"height"]) {
       
        CGSize contentSize = [contentStr boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
        return contentSize.height;
        
    }else{
    
        
        CGSize size =[contentStr sizeWithAttributes:@{NSFontAttributeName:font}];
        return size.width;
    }
    
}
@end
