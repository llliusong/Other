//
//  TableShiLiViewController.m
//  StoryBoard
//
//  Created by lius on 15/12/14.
//  Copyright © 2015年 LiuS. All rights reserved.
//

#import "TableShiLiViewController.h"
#import "Model.h"

@interface TableShiLiViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_listArray;
}

@end

@implementation TableShiLiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"1"] forBarMetrics:UIBarMetricsDefault];
    self.title = @"table";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    _listArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < 30; i++) {
        Model *model = [[Model alloc]init];
        model.title = [NSString stringWithFormat:@"这是测试内容%d",i];
        [_listArray addObject:model];
    }
   
    
}


#pragma mark 设置有多少分组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_listArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             CellIdentifier];
    
    if (0 == indexPath.section) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
        if (0 == indexPath.row) {
            cell.textLabel.text = @"新浪微博"; //cell的text内容
            
            UILabel *label = [[UILabel alloc] init]; //定义一个在cell最右边显示的label
            label.text = @"Dark0921";
            label.font = [UIFont boldSystemFontOfSize:14];
            [label sizeToFit];
            label.backgroundColor = [UIColor clearColor];
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
                label.frame =CGRectMake(SCREEN_WIDTH - label.frame.size.width - 10,\
                                        12, label.frame.size.width, label.frame.size.height);
            } else {
                label.frame =CGRectMake(SCREEN_WIDTH - label.frame.size.width - 20,\
                                        12, label.frame.size.width, label.frame.size.height);
            }
            [cell.contentView addSubview:label];
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor grayColor];
        }
        
        else if (1 == indexPath.row){
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
            cell.textLabel.text = @"添加好友";
        }
        else
        {
            Model *model = _listArray[indexPath.row];
            cell.textLabel.text = model.title;
            //设置自定义字体
            cell.textLabel.font = [UIFont fontWithName:@"OpenSans-Bold" size:20.0];
//            cell.textLabel.text = @"百度贴吧";
        }
    }
    
    UIView *lbl = [[UIView alloc] init]; //定义一个label用于显示cell之间的分割线（未使用系统自带的分割线），也可以用view来画分割线
    lbl.frame = CGRectMake(cell.frame.origin.x + 10, cell.frame.size.height - 5, cell.frame.size.width - 20, 1);
    lbl.backgroundColor =  [UIColor lightGrayColor];
    [cell.contentView addSubview:lbl];
    return cell;
}

#pragma mark 滑动效果
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
     if (self.tableView.contentOffset.y < 64)
     {
         NSLog(@"%f",self.tableView.frame.origin.y);
         NSLog(@"%f",[scrollView contentSize].height);
         NSLog(@"%f",scrollView.contentOffset.y);
         self.title = @"新浪微博";
    
     }
    else
    {
        self.title = @"百度贴吧";
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
