//
//  LoginViewController.m
//  StoryBoard
//
//  Created by lius on 15/9/9.
//  Copyright (c) 2015年 LiuS. All rights reserved.
//

#import "LoginViewController.h"
#import "wangluoqingqiu.h"
#import <AFNetworking/AFNetworking.h>
#import <JSONKit.h>
#import "UMSocial.h"


@interface LoginViewController ()<UMSocialDataDelegate,UMSocialUIDelegate>
{
    NSTimer * _timer;
    
    int time;
}
@property (weak, nonatomic) IBOutlet UIButton *getCodeButton;



@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //截取字符串
//    NSString *strng = @"http://cjm.so/f/61146094130409118046";
//    NSRange range1 = [strng rangeOfString:@"/"];
//    
//    NSString *lat = [strng substringToIndex:range1.location];
//    
//    
//    NSRange lastSymbol = [strng rangeOfString:@"/" options:NSBackwardsSearch];
//    NSString *lawe = [strng substringFromIndex:lastSymbol.location+1];
//    截取字符串
    NSString *strng = @"http://cjm.so/f/61146094130409118046";
    NSRange lastSymbol = [strng rangeOfString:@"￥" options:NSBackwardsSearch];
    if (lastSymbol.length != 0) {
        strng = [strng substringFromIndex:lastSymbol.location+1];
    }
    NSLog(@"%@",strng);
    LSLOG(strng);
    
    NSLog(@"打印线程----%@",[NSThread currentThread]);
    //延迟执行
    //第一种方法：延迟3秒钟调用run函数
    [self performSelector:@selector(run) withObject:nil afterDelay:2.0];
    
    
    
    //延迟执行，第二种方式
    //可以安排其线程(1),主队列
    dispatch_queue_t queue= dispatch_get_main_queue();
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), queue, ^{
        NSLog(@"主队列--延迟执行------%@",[NSThread currentThread]);
    });

    //可以安排其线程(2),并发队列
    //1.获取全局并发队列
    dispatch_queue_t queue1= dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //2.计算任务执行的时间
    dispatch_time_t when=dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC));
    //3.会在when这个时间点，执行queue中的这个任务
    dispatch_after(when, queue1, ^{
        NSLog(@"并发队列-延迟执行------%@",[NSThread currentThread]);
    });
    
    //  cell.textLabel.adjustsFontSizeToFitWidth = YES;//一行显示不完，自动调整字体大小，显示完全
    
    //回调函数
    [self withMoney:^(id salary)
     {
         NSLog(@"%@",salary);
     }];
    
    //设置自定义字体
    NSArray * fontArrays = [[NSArray alloc] initWithArray:[UIFont familyNames]];
    for (NSString * temp in fontArrays) {
        NSLog(@"Font name  = %@", temp);
    }
    
    NSArray *familyNames = [UIFont familyNames];
    for( NSString *familyName in familyNames ){
        printf( "Family: %s \n", [familyName UTF8String] );
        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
        for( NSString *fontName in fontNames ){
            printf( "\tFont: %s \n", [fontName UTF8String] );
        }
    }
    
    
    //网络请求
    [self loadData];
    
    
    NSString *animals = @"<p>公司坚持“客户第一”的原则为广大客户提供优质的服务。欢迎惠顾！<br/><br/></p>";
    //    NSString *animals = @"dog#cat#pig";
    //将#分隔的字符串转换成数组
    //    NSArray *array = [animals componentsSeparatedByString:@"<p>"];
    //    NSLog(@"animals:%@",array);
    //    //获取程序运行时目录
    //    NSString *escapedPath = [[NSBundle mainBundle] pathForResource:@"info" ofType:@"plist"];
    //    NSArray *strings = [escapedPath componentsSeparatedByString: @"/"];
    //    NSString *tmpFilename  = [strings objectAtIndex:[strings count]-1];
    //    NSRange iStart = [escapedPath rangeOfString : tmpFilename];
    //    NSString *runtimeDirectory = [escapedPath substringToIndex:iStart.location-1];
    //    NSLog(@"runtimeDirectory:%@",runtimeDirectory);
    //    //按行读取文件
    //    NSString *tmp;
    //    NSArray *lines = [[NSString stringWithContentsOfFile:@"test.txt" encoding:nil error:nil]
    //                      componentsSeparatedByString:@"\n"];
    //    NSEnumerator *nse = [lines objectEnumerator];
    //    while(tmp = [nse nextObject]) {
    //        NSLog(@"tmp:%@", tmp);
    //        }
    animals =[animals stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
    animals =[animals stringByReplacingOccurrencesOfString:@"<br/>" withString:@""];
    animals =[animals stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
    
    NSLog(@"animals = %@",animals);
    //    NSString *      regex = @"[\u4e00-\u9fa5]";
    //    NSPredicate *   pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    
    //自定义字体
    //    UIFont * fontTwo = [UIFont fontWithName:@"Geeza Pro" size:15];
    //    [_label setFont:[UIFont fontWithName:@"MicrosoftYaHei" size:20.0]];
    //    _label.font = [UIFont fontWithName:@"Alison-Regular" size:20.0];
//    _label.font = [UIFont fontWithName:@"OpenSans-Bold" size:20.0];
    
    
//    //增加监听，当键盘出现或改变时收出消息
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWillShow:)
//                                                 name:UIKeyboardWillShowNotification
//                                               object:nil];
//    
//    //增加监听，当键退出时收出消息
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWillHide:)
//                                                 name:UIKeyboardWillHideNotification
//                                               object:nil];


}

#pragma mark 网络请求
- (void)loadData
{
    NSString *str=[NSString stringWithFormat:@"http://app.yg-pump.com/plus/api.php?module=getBannerInfo"];
    [wangluoqingqiu assdSuccess:^(id response)
     {
         
     }];
    [wangluoqingqiu parm:str Success:^(id response)
     {
         NSLog(@"%@",response);
         NSArray * array = response;
         for (NSDictionary *dic in array) {
             NSLog(@"%@",dic);
         }
     }];
}

- (void)loadDataContent{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *content = @"您此次的验证码为：1234";
    NSDictionary *params = @{@"user":@"zhly",
                             @"psw":@"zhly123",
                             @"mobiles":@"15857104317",
                             @"content":[content stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]};
    
    [manager.requestSerializer setValue:@"" forHTTPHeaderField:@"Signature"];
    NSLog(@"%@",[params JSONString]);
    //    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //    NSLog(@"%@",[manager.requestSerializer HTTPRequestHeaders]);
    //    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    //    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json",nil];
    [manager POST:@"http://101.227.247.82:8081/ltlion/user/sendSms" parameters:[params JSONString] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
    
}

#pragma mark bolck回调
-(void)withMoney:(void(^)(id salary))amount
{
    amount(@134);
}

-(void)run
{
     NSLog(@"延迟执行----%@",[NSThread currentThread]);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
     //在异步函数中执行
     dispatch_queue_t queue = dispatch_queue_create("wendingding", 0);

     dispatch_sync(queue, ^{
         [self performSelector:@selector(test) withObject:nil afterDelay:1.0];
     });
     NSLog(@"异步函数");
}
-(void)test
{
     NSLog(@"异步函数中延迟执行----%@",[NSThread currentThread]);
}


#pragma mark 按钮点击
- (IBAction)getGode:(UIButton *)sender {
    time = 30;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(startTime) userInfo:nil repeats:YES];
    _getCodeButton.userInteractionEnabled = NO;
    [_getCodeButton setImage:[UIImage imageNamed:@"box4"] forState:UIControlStateNormal];
    [_timer fire];
}

-(void)startTime{
    time --;
    //    NSLog(@"%d",_time);
    [_getCodeButton setTitle:[NSString stringWithFormat:@"%ds后重发",time] forState:UIControlStateNormal];
    if (time <= 0) {
        [_timer invalidate];
        _timer = nil;
        [_getCodeButton setImage:[UIImage imageNamed:@"box3"] forState:UIControlStateNormal];
        [_getCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        _getCodeButton.userInteractionEnabled = YES;
        time = 30;
    }
    
}


- (IBAction)loginClick:(UIButton *)sender {
    [self showAlertWIthMessage:@"登录成功" withImageName:nil];
    NSLog(@"点我");
}

- (IBAction)zhuceClick:(UIButton *)sender {
    [self performSegueWithIdentifier:@"zhuce" sender:nil];
}

- (IBAction)share:(UIButton *)sender {
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"5621affae0f55a75850062de"
                                      shareText:@"你要分享的文字"
                                     shareImage:[UIImage imageNamed:@"icon.png"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,nil]
                                       delegate:self];
}

#pragma mark 友盟分享回调
- (void)didFinishGetUMSocialDataResponse:(UMSocialResponseEntity *)response
{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
