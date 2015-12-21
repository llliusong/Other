//
//  SecondViewController.m
//  StoryBoard
//
//  Created by lius on 15/9/9.
//  Copyright (c) 2015年 LiuS. All rights reserved.
//

#import "SecondViewController.h"
#import "TableViewDetailController.h"
#import "TestTableViewCell.h"
#import "SecondCell.h"
#import "HQF_MineTableViewCell.h"
#import "PersonalCenterOrderViewController.h"

@interface SecondViewController ()
@property (nonatomic,retain) NSMutableArray *allDataArray;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"第二页";
    self.navigationController.navigationBar.translucent = NO;
    _tableView.tableFooterView = [UIView new];
    
    self.allDataArray =[[NSMutableArray alloc]initWithObjects:@"王菲",@"周迅",@"李冰冰",@"白冰",@"紫薇",@"马苏",@"刘诗诗",@"赵薇",@"angelbaby",@"熊黛林",nil];
    
#warning iOS8 - 分割线样式
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    
    UIVibrancyEffect *vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:blurEffect];
    
    _tableView.separatorEffect = vibrancyEffect;
     [_tableView   setSeparatorColor:[UIColor    blueColor]];  //设置分割线为蓝色
    
    //右上角编辑按钮
    
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.navigationItem.rightBarButtonItem =self.editButtonItem;
    
    //注册tableview
//    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellIdentifier"];
}

#pragma mark 编辑按钮

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    
    [super setEditing:editing animated:animated];
    [_tableView setEditing:!_tableView.isEditing animated:YES];
    
}

#pragma mark - tableview deldgate and datasoure

#pragma mark 设置有多少分组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark 设置每个分组有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _allDataArray.count;
}

#pragma mark 设置cell的估计值
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath//（**iOS 7专用**）
//{
//    return 200;
//}

#pragma mark 设置每行的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

#pragma mark 设置某行上显示的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *CellIdentifier = @"kkk";
//    UITableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    TestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if(cell == nil)
//    {
//        cell= [[TestTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
//                                   reuseIdentifier:CellIdentifier];
//        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
//    }
//    cell.textLabel.text=_allDataArray[indexPath.row];
//    cell.cellLabel.text = _allDataArray[indexPath.row];
    
//    SecondCell *cell = [SecondCell cellWithTableView:tableView];
    
//    UITableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if(cell == nil)
//    {
//        cell= [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
//                                      reuseIdentifier:CellIdentifier];
//        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
//    }
//    UILabel *labelText = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 60, 28)];
//    labelText.textColor = [UIColor blackColor];
//    labelText.textAlignment = NSTextAlignmentLeft;
//    labelText.font = [UIFont systemFontOfSize:14];
//    [cell addSubview:labelText];
//    UILabel *labelTime = [[UILabel alloc] initWithFrame:CGRectMake(20, 28, 100, 28)];
////    labelTime.textColor = [ETTool stringTOColor:@"#b4b4b4"];
//    labelTime.textAlignment = NSTextAlignmentLeft;
//    labelTime.font = [UIFont systemFontOfSize:11];
//    [cell addSubview:labelTime];
//    
//    UILabel *labelMoney = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, [[UIScreen mainScreen] bounds].size.width, 28*2)];
//    
//    labelMoney.textAlignment = NSTextAlignmentRight;
//    labelMoney.font = [UIFont systemFontOfSize:17];
//    
//    [cell addSubview:labelMoney];
//    cell.name.text = _allDataArray[indexPath.row];
    
    static NSString *CellIdentifier = @"detacell";
    HQF_MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[HQF_MineTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell HQF_MineTableViewCell:@"home5" Title:_allDataArray[indexPath.row]];
    
    [tollView setBottomView:cell];
    return cell;
}

#pragma mark 设置可以进行编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark 设置编辑的样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

#pragma mark 设置处理编辑情况
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle ==UITableViewCellEditingStyleDelete) {
        // 1.更新数据
        [_allDataArray removeObjectAtIndex:indexPath.row];
        
        // 2.更新UI
        
        [tableView deleteRowsAtIndexPaths:@[indexPath]withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}


#pragma mark 设置可以移动
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark 处理移动的情况
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    // 1. 更新数据
    
    NSString *title =_allDataArray[sourceIndexPath.row];
    [_allDataArray removeObject:title];
    
    [_allDataArray insertObject:title atIndex:destinationIndexPath.row];
    
    // 2. 更新UI
    [tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
    
}

#pragma mark 在滑动手势删除某一行的时候，显示出更多的按钮
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 添加一个删除按钮
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction *action,NSIndexPath *indexPath) {
        
        NSLog(@"点击了删除");
        // 1. 更新数据
        [_allDataArray removeObjectAtIndex:indexPath.row];
        // 2. 更新UI
        [tableView deleteRowsAtIndexPaths:@[indexPath]withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }];
    
    
    
    //    // 删除一个置顶按钮
    
    //    UITableViewRowAction *topRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"置顶" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
    
    //        NSLog(@"点击了置顶");
    
    //
    
    //        // 1. 更新数据
    
    //        [_allDataArray exchangeObjectAtIndex:indexPath.row withObjectAtIndex:0];
    
    //
    
    //        // 2. 更新UI
    
    //        NSIndexPath *firstIndexPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
    
    //        [tableView moveRowAtIndexPath:indexPath toIndexPath:firstIndexPath];
    
    //    }];
    
    //    topRowAction.backgroundColor = [UIColor blueColor];
    
    
    
    //添加一个更多按钮
    
    UITableViewRowAction *moreRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"更多"handler:^(UITableViewRowAction *action,NSIndexPath *indexPath) {
        
        NSLog(@"点击了更多");
        
        
        
        [tableView reloadRowsAtIndexPaths:@[indexPath]withRowAnimation:UITableViewRowAnimationMiddle];
        
    }];
    
    moreRowAction.backgroundEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    
    
    
    //将设置好的按钮放到数组中返回
    
    // return @[deleteRowAction, topRowAction, moreRowAction];
    
    return@[deleteRowAction,moreRowAction];
    
}

#pragma mark 选择选中行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewDetailController *Tab = [TableViewDetailController new];
//    PersonalCenterOrderViewController *Tab = [PersonalCenterOrderViewController new];
    [self.navigationController pushViewController:Tab animated:YES];
    
//    NSString *partner = PartnerID;
//    NSString *seller = SellerID;
//    NSString *privateKey = PartnerPrivKey;
//    
//    /*============================================================================*/
//    /*============================================================================*/
//    /*============================================================================*/
//    
//    //partner和seller获取失败,提示
//    if ([partner length] == 0 ||
//        [seller length] == 0 ||
//        [privateKey length] == 0)
//    {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
//                                                        message:@"缺少partner或者seller或者私钥。"
//                                                       delegate:self
//                                              cancelButtonTitle:@"确定"
//                                              otherButtonTitles:nil];
//        [alert show];
//        return;
//    }
//    
//    /*
//     *生成订单信息及签名
//     */
//    //将商品信息赋予AlixPayOrder的成员变量
//    Order *order = [[Order alloc] init];
//    order.partner = partner;
//    order.seller = seller;
//    order.tradeNO = [self generateTradeNO]; //订单ID（由商家自行制定）
//    order.productName = product.subject; //商品标题
//    order.productDescription = product.body; //商品描述
//    order.amount = [NSString stringWithFormat:@"%.2f",product.price]; //商品价格
//    order.notifyURL =  @"http://www.xxx.com"; //回调URL
//    
//    order.service = @"mobile.securitypay.pay";
//    order.paymentType = @"1";
//    order.inputCharset = @"utf-8";
//    order.itBPay = @"30m";
//    order.showUrl = @"m.alipay.com";
//    
//    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
//    NSString *appScheme = @"alisdkdemo";
//    
//    //将商品信息拼接成字符串
//    NSString *orderSpec = [order description];
//    NSLog(@"orderSpec = %@",orderSpec);
//    
//    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
//    id<DataSigner> signer = CreateRSADataSigner(privateKey);
//    NSString *signedString = [signer signString:orderSpec];
//    
//    //将签名成功字符串格式化为订单字符串,请严格按照该格式
//    NSString *orderString = nil;
//    if (signedString != nil) {
//        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
//                       orderSpec, signedString, @"RSA"];
//        
//        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
//            NSLog(@"reslut = %@",resultDic);
//            
//            /*9000:订单支付成功
//             *8000:正在处理中（"支付结果确认中"）  代表支付结果因为支付渠道原因或者系统原因还在等待支付结果确认，最终交易是否成功以服务端异步通知为准（小概率状态）
//             *4000:订单支付失败
//             *6001:用户中途取消
//             *6002:网络连接出错  */
//        }];
//        
//        [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    }

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
