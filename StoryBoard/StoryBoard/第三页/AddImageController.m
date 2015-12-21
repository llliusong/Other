//
//  AddImageController.m
//  StoryBoard
//
//  Created by lius on 15/11/20.
//  Copyright © 2015年 LiuS. All rights reserved.
//

#import "AddImageController.h"

@interface AddImageController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    CGFloat imageWidth;//图片宽高
    
    NSMutableArray *_imageArray;
    
    CAKeyframeAnimation *keyAnima;//抖动动画
}

@end

@implementation AddImageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"添加图片";
    [self.view setBackgroundColor:[UIColor whiteColor]];

    [self.scrollView setBackgroundColor:[UIColor whiteColor]];
    
    _imageArray = [[NSMutableArray alloc]init];
    _imageArray = @[].mutableCopy;
    
    keyAnima = [CAKeyframeAnimation animation];
    [self initUI];
    
//    [self BeginWobble];
}

- (void)initUI
{
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    [self.view addSubview:self.scrollView];
    imageWidth = (SCREEN_WIDTH - 70)/4;
    self.addButton = [[UIButton alloc]initWithFrame:CGRectMake(10 , 15 , imageWidth, imageWidth)];
    [self.addButton setImage:[UIImage imageNamed:@"add1"] forState:UIControlStateNormal];
    [self.addButton addTarget:self action:@selector(addImage:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.addButton];
    
//    self.scrollView.showsHorizontalScrollIndicator = NO;//是否消失横线滚动是滚动条
}

//添加图片按钮
- (void)addImage:(UIButton *)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"拍照",@"从手机中选择",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
}

#pragma mark UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) {//拍照
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [self showTakePhoto:self isCamera:YES];
            
        }else{
            
            NSLog(@"没有相机");
        }
    }else if (buttonIndex == 1) {//从手机相册中选择
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate = self;
        //设置选择后的图片可被编辑
        picker.allowsEditing = YES;
        [self presentViewController:picker animated:YES completion:^(void){}];
    }
}

#pragma mark 拍照
- (void)showTakePhoto:(id)target isCamera:(BOOL)isCamera{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if (!isCamera) {//拍照
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
    picker.delegate = target;
    picker.allowsEditing = YES;//设置可编辑
    picker.sourceType = sourceType;
    [target presentViewController:picker animated:YES completion:nil];//进入照相界面
    
}

#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    
    if ([type isEqualToString:@"public.image"])
    {
        
        UIImage* image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        [_imageArray addObject:image];
        
        //如果要上传，在定义一个全局数组，在这里把uiimage转为nsdata
    }
    [self dismissViewControllerAnimated:YES completion:^(void){}];
    [self.imgView removeFromSuperview];
    [self setImageViews:_imageArray];
    
}

-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark 添加图片
- (void)setImageViews:(NSMutableArray *)array{
    self.imgView = [[UIView alloc]initWithFrame:self.scrollView.bounds];
    self.imgView.autoresizesSubviews = NO;
    self.addButton.hidden = NO;
    for (int i = 0; i < array.count; i ++) {
        
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10 + i * (10+imageWidth), 15 , imageWidth, imageWidth)];
        self.imageView.userInteractionEnabled = YES;
        [self.imageView setImage:array[i]];
        self.imageView.tag = 1000+i;
        [self.imgView addSubview:self.imageView];
        
        UILongPressGestureRecognizer *longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
        [longPressRecognizer setMinimumPressDuration:1.0];
        [self.imageView addGestureRecognizer:longPressRecognizer];
        
        self.addButton.frame = CGRectMake(10 + (i+1) * (10+imageWidth), 15 , imageWidth, imageWidth);
        
        _delButton = [UIButton buttonWithType:UIButtonTypeCustom];
        float w = 20;
        float h = 20;
        
        [_delButton setFrame:CGRectMake(self.imageView.frame.size.width-20,0, w, h)];
        [_delButton setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        _delButton.backgroundColor = [UIColor clearColor];
        [_delButton addTarget:self action:@selector(removeImageClicked:) forControlEvents:UIControlEventTouchUpInside];
        _delButton.tag = i;
        _delButton.hidden = YES;
        [self.imageView addSubview:_delButton];
        
    }
    
    if(array.count == 8)//设置可以放多少张图片
    {
        self.addButton.hidden = YES;
    }
    if (array.count == 0) {
        
        self.addButton.frame = CGRectMake(10 , 15 , imageWidth, imageWidth);
    }
    [self.imgView addSubview:self.addButton];
    [self.scrollView addSubview:self.imgView];
    
    //计算scrollview的滚动范围
    if(array.count >= 4)
    {
        
        self.scrollView.contentSize =  CGSizeMake(SCREEN_WIDTH + (array.count + 1 - 4) * (imageWidth + 10), [self.scrollView contentSize].height);
    }
    
}

#pragma mark 删除图片
-(void)handleLongPress:(UILongPressGestureRecognizer*)recognizer{
    
    //多选
    for (UIView *view in self.imgView.subviews) {
        
        if ([view isKindOfClass:[UIImageView class]]) {
            self.imageView = (UIImageView *)view;
            _delButton = [self.imageView viewWithTag:self.imageView.tag - 1000];
            [self rotation:self.imageView];
            _delButton.hidden = NO;
        }
        
    }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    NSLog(@"您取消了选择图片");
    [self dismissViewControllerAnimated:YES completion:^(void){}];
}

#pragma mark 删除图片
- (void) removeImageClicked:(UIButton *)sender  {
    
    [_imageArray removeObjectAtIndex:sender.tag];
    [self.imgView removeFromSuperview];
    [self setImageViews:_imageArray];
    [self handleLongPress];
}

#pragma mark 删除图片后保存动画效果
-(void)handleLongPress{
    
    for (UIView *view in self.imgView.subviews) {
        
        if ([view isKindOfClass:[UIImageView class]]) {
            self.imageView = (UIImageView *)view;
            _delButton = [self.imageView viewWithTag:self.imageView.tag - 1000];
            [self rotation:self.imageView];
            _delButton.hidden = NO;
        }
        
    }
}

-(void)BeginWobble//开始抖动
{
    for (UIView *view in self.view.subviews)
    {
        srand([[NSDate date] timeIntervalSince1970]);
        float rand=(float)random();
        CFTimeInterval t=rand*0.0000000001;
        [UIView animateWithDuration:0.1 delay:t options:0 animations:^
        {
            view.transform=CGAffineTransformMakeRotation(-0.05);
        } completion:^(BOOL finished)
        {
            [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionRepeat|UIViewAnimationOptionAutoreverse|UIViewAnimationOptionAllowUserInteraction animations:^
            {
                view.transform=CGAffineTransformMakeRotation(0.05);
            } completion:^(BOOL finished) {}];
        }];
    }
}

-(void)EndWobble//取消抖动
{
    for (UIView *view in self.view.subviews)
    {
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState animations:^
        {
            view.transform=CGAffineTransformIdentity;
        } completion:^(BOOL finished) {}];
    }
}

#pragma mark 抖动动画
- (void)rotation:(UIImageView *)imageView {
    //1,创建核心动画
    
    
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
    
    
//    CAKeyframeAnimation *frame=[CAKeyframeAnimation animation];
//    CGFloat left=-M_PI_2*0.125;
//    CGFloat right=M_PI_2*0.125;
//    
//    
//    frame.keyPath=@"postion";
//    frame.keyPath=@"transform.rotation";
//    
//    frame.values=@[@(left),@(right),@(left)];
//    frame.duration=0.1;
//    frame.repeatCount=10;
//    [imageView.layer addAnimation:frame forKey:nil];
//    
//    //取消动画
//    [imageView.layer removeAnimationForKey:@"transform.rotation"];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event//开始触摸的方法
{
    [super touchesBegan:touches withEvent:event];
//    keyAnima.values = 0;
    keyAnima.repeatCount = 10;
//    keyAnima.removedOnCompletion = YES;
    for (UIView *view in self.view.subviews)
    {
//        [view.layer addAnimation:keyAnima forKey:nil];
        [view.layer removeAnimationForKey:@"transform.rotation"];
//        [view.layer removeAllAnimations];
    }

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
