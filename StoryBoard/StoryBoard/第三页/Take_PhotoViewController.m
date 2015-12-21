//
//  Take_PhotoViewController.m
//  High_Quality_Fabric
//
//  Created by 黎金 on 15/10/30.
//  Copyright © 2015年 sixgui. All rights reserved.
//

#import "Take_PhotoViewController.h"
#import "Header.h"
#import "tollView.h"
@interface Take_PhotoViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{

    NSMutableArray *imagesArray;//图片data数组
    NSMutableArray *imageArray;//图片image数组
    UIView *imgView;
    UIImageView *imageView;
    
    NSString *attributeStr;//行业属性
    NSString *typeStr;//执法类别
    CGFloat imageW ;
    
    UIButton *deleteButton;//删除按钮
}
@end

@implementation Take_PhotoViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    if ([_stateStr  isEqual: @"买家"]) {
        
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"YNavi"] forBarMetrics:UIBarMetricsDefault];
    }
    
    
    self.topPhotoView.frame = CGRectMake(10, 10, SCREEN_WIDTH - 20, 45 + imageW + 30);
    [self.scrollView addSubview:self.topPhotoView];
    [self.imagesView addSubview:_addBtn];
    [_addBtn setImage:[UIImage imageNamed:@"add1"] forState:UIControlStateNormal];
    NSLog(@"%f++%f",self.addBtn.frame.origin.x ,self.addBtn.frame.size.height);
    
    self.bottomView.frame = CGRectMake(10, 20 + self.topPhotoView.frame.size.height, SCREEN_WIDTH - 20, 200);
    [self.scrollView addSubview:self.bottomView];
    
    self.submitBtn.frame = CGRectMake(10, self.bottomView.frame.size.height + self.bottomView.frame.origin.y + 20, SCREEN_WIDTH - 20, 45);
    [self.scrollView addSubview:self.submitBtn];
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"找面料";
   
    imagesArray = @[].mutableCopy;
    imageArray = @[].mutableCopy;
    
    imageW = (SCREEN_WIDTH - 70)/4;
    _addBtn.frame = CGRectMake(10 , 15 , imageW, imageW);
   
    
    attributeStr = @"";
    typeStr = @"";
    [self setInitView];
    self.submitBtn.enabled = NO;
    self.submitBtn.backgroundColor = UIColorRGBA(196, 196, 196, 1);
}

#pragma mark 提示
-(void)setActiv{
    
}

#pragma mark 初始化
-(void)setInitView{
    [tollView makeCircular:self.submitBtn Circularfloat:10];
    [tollView makeCircular:self.topPhotoView Circularfloat:5];
    [tollView makeCircular:self.bottomView Circularfloat:5];
    
    self.threeLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    [self.threeLabel addGestureRecognizer:singleTap];
    
    if (IS_IPHONE_4_OR_LESS) {
        self.scrollView.contentSize = CGSizeMake(0, 500);
    }
}


#pragma mark 调用相机或图库
- (IBAction)AddBtn:(UIButton *)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"拍照",@"从手机中选择",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
}

#pragma mark 相机
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    if (buttonIndex == 0) {//拍照
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [self showTakePhoto:self isCamera:YES];
            
        }else{
            
            NSLog(@"没有相机");
        }
    }else if (buttonIndex == 1) {//从手机中选择
        
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
        [imageArray addObject:image];
        
        UIImage *newImage = [self imageWithImage:image scaledToSize:CGSizeMake(image.size.width * 0.2, image.size.height * 0.2)];
        NSData *buffer = UIImageJPEGRepresentation(newImage, 0.1);
        NSString *type = @"image/jpg";
        if (buffer == nil) {
            buffer = UIImagePNGRepresentation(newImage);
            type = @"image/png";
        }
        NSDictionary *dic = @{
                              @"thumbImg":buffer
                              };
        [imagesArray addObject:dic];
    }
    [self dismissViewControllerAnimated:YES completion:^(void){}];
    [imgView removeFromSuperview];
    [self setImageView:imageArray];

}

#pragma mark 添加图片
- (void)setImageView:(NSMutableArray *)array{
    imgView = [[UIView alloc]initWithFrame:self.imagesView.bounds];
    imgView.autoresizesSubviews = NO;
    _addBtn.hidden = NO;
    for (int i = 0; i < array.count; i ++) {
      
        imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10 + i * (10+imageW), 15 , imageW, imageW)];
        imageView.userInteractionEnabled = YES;
        [imageView setImage:array[i]];
        imageView.tag = 1000+i;
        [imgView addSubview:imageView];
        
        UILongPressGestureRecognizer *longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
        [longPressRecognizer setMinimumPressDuration:1.0];
        [imageView addGestureRecognizer:longPressRecognizer];
        
        _addBtn.frame = CGRectMake(10 + (i+1) * (10+imageW), 15 , imageW, imageW);
        
        deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        float w = 20;
        float h = 20;
        
        [deleteButton setFrame:CGRectMake(imageView.frame.size.width-20,0, w, h)];
        [deleteButton setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        deleteButton.backgroundColor = [UIColor clearColor];
        [deleteButton addTarget:self action:@selector(removeImageClicked:) forControlEvents:UIControlEventTouchUpInside];
        deleteButton.tag = i;
        deleteButton.hidden = YES;
        [imageView addSubview:deleteButton];
        
    }
    
    if(array.count == 4)
    {
        _addBtn.hidden = YES;
    }
    if (array.count == 0) {
    
       _addBtn.frame = CGRectMake(10 , 15 , imageW, imageW);
    }
    [imgView addSubview:_addBtn];
    [self.imagesView addSubview:imgView];

    [self getState];
}

#pragma mark 删除图片
-(void)handleLongPress:(UILongPressGestureRecognizer*)recognizer{
    //处理长按操作--单选
//    NSInteger tag = recognizer.view.tag;
//    imageView = [recognizer.view viewWithTag:tag];
//    deleteButton = [imageView viewWithTag:tag - 1000];
//    NSLog(@"长按, %f", recognizer.minimumPressDuration);
//    [tollView rotation:imageView];
//    deleteButton.hidden = NO;
    
    //多选
    for (UIView *view in imgView.subviews) {
        
        if ([view isKindOfClass:[UIImageView class]]) {
            imageView = (UIImageView *)view;
            deleteButton = [imageView viewWithTag:imageView.tag - 1000];
            [tollView rotation:imageView];
            deleteButton.hidden = NO;
        }
        
    }
}


-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    NSLog(@"您取消了选择图片");
    [self dismissViewControllerAnimated:YES completion:^(void){}];
}

#pragma mark 删除图片
- (void) removeImageClicked:(UIButton *)sender  {
    
    [imageArray removeObjectAtIndex:sender.tag];
    [imagesArray removeObjectAtIndex:sender.tag];
    [imgView removeFromSuperview];
    [self setImageView:imageArray];
    [self handleLongPress];
    [self getState];
}

#pragma mark 删除图片后保存动画效果
-(void)handleLongPress{

    for (UIView *view in imgView.subviews) {
        
        if ([view isKindOfClass:[UIImageView class]]) {
            imageView = (UIImageView *)view;
            deleteButton = [imageView viewWithTag:imageView.tag - 1000];
            [tollView rotation:imageView];
            deleteButton.hidden = NO;
        }
        
    }
}

#pragma mark 面料种类
-(void)fingerTapped:(UITapGestureRecognizer *)tapgesture{
    
    
    
}

#pragma mark 选中面料种类后回调
-(void)Lining_TypeViewController:(NSString *)name{

    self.threeLabel.text = name;
    [self getState];
}

#pragma mark 判断按钮状态
-(void)getState{

        if(imagesArray.count == 0){
    
            NSLog(@"请选择图片");
            [self getStates];
    
        }else if([attributeStr  isEqual: @""]){
    
            NSLog(@"请选择行业属性");
            [self getStates];
    
        }else if([typeStr  isEqual: @""]){
    
            NSLog(@"请选择织法类别");
            [self getStates];
    
        }else if([self.threeLabel.text  isEqualToString: @""]){
    
            NSLog(@"请选择面料种类");
            [self getStates];
            
        }else{
        
            self.submitBtn.enabled = YES;
            self.submitBtn.backgroundColor = UIColorRGBA(66, 215, 198, 1);
            
        }
}

#pragma mark 条件未满足时按钮不可点击
-(void)getStates{

    self.submitBtn.enabled = NO;
    self.submitBtn.backgroundColor = UIColorRGBA(196, 196, 196, 1);
}

#pragma mark 提交
- (IBAction)SubmitBtn:(UIButton *)sender {

    [self setActiv];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


@end
