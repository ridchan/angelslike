//
//  StartCouViewViewController.m
//  angelslike
//
//  Created by angelslike on 15/9/7.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "StartCouViewViewController.h"

@interface StartCouViewViewController ()

@end

@implementation StartCouViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *arr =  @[@[@"CouNameCell",@"CouTitleCell",@"CouContentCell",@"CouImageCell"],
                      @[@"CouQtyCell"],
                      @[@"PayCell"],
                      @[@"MyAddressCell",@"HerAddressCell"],
                      @[@"CouMyQtyCell"],
                      @[@"ValDayCell",@"OpenCell",@"MutileCopiesCell"]
                     ];
    self.infos = [NSMutableArray arrayWithArray:arr];
    
    NSString *everyprice = [NSString stringWithFormat:@"%0.2f",[self.P floatForKey:@"price"] / 2];
    [self.P setObject:everyprice forKey:@"everyprice"];
    [self.P setObject:@"2" forKey:@"qty"];
    [self.P setObject:@"1" forKey:@"mycopies"];
    [self.P setObject:everyprice forKey:@"MyCouAmount"];
    [self.P setObject:[self.P strForKey:@"id"] forKey:@"pid"];
    
    [self.P setObject:[[UserInfo shared].info strForKey:@"name"] forKey:@"username"];
    for (NSString *key in @[@"address",@"phone",@"city",@"pro",@"dis"]){
        [self.P setObject:[[UserInfo shared].info strForKey:key] forKey:key];
    }
    

    [self initialSetting];
    // Do any additional setup after loading the view.
}


-(void)initialSetting{
    self.navigationItem.title = @"发起凑分子";
    [self setBackButtonAction:@selector(backClick:)];
    
    self.tableView = [[UITableView alloc]initWithFrame:RECT(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    bottomView.backgroundColor = [UIColor clearColor];
    RCRoundButton *button = [RCRoundButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(couClick:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = HexColor(@"FF686A");
    button.frame = RECT(10, 0, ScreenWidth - 20, 40);
    [button setTitle:@"我先来凑，再找人凑" forState:UIControlStateNormal];
    [button setCorner:8];
    [bottomView addSubview:button];
    self.tableView.tableFooterView = bottomView;
    
}

-(void)couClick:(id)sender{
    [self.P setObject:[[UserInfo shared].info strForKey:@"loginkey"] forKey:@"loginkey"];
    __block StartCouViewViewController *tempSelf = self;
    [[NetWork shared] query:ComfirmCouUrl info:self.P block:^(id Obj) {
        if ([Obj intForKey:@"status"] == 1)
            [tempSelf payInOrder:[[Obj objectForKey:@"data"] strForKey:@"orderid"]];
    } lock:YES];
}


-(void)payInOrder:(NSString *)orderNo{
    
    
    
    
     NSMutableString *privateKey = [NSMutableString string];
     [privateKey appendString:@"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAK6PtuuJiEWczsOI\n"];
     [privateKey appendString:@"X4J1plCApFUqgV5sJfSatHakdO+o0CX/ufM7qHOdp0sLL8Y+DAjNMzJBSqmKgtkB\n"];
     [privateKey appendString:@"Iz3Ow9JqmfUi4VwhLolYzdiSqhuwSPE8VUYDZvjBP0tNpsbSaFX/Gvn8Qmqz5R0v\n"];
     [privateKey appendString:@"oIsIfNtt1wnd3uXPExW5E/IMpqYjAgMBAAECgYEAoaP2kBiklUFkvO808csbnIPi\n"];
     [privateKey appendString:@"p/JaJSMj6mKvJQWYOqwpQmaQu8jMbXLZDMZpELs3zZamB60qA+B81ZEWHw+th0wH\n"];
     [privateKey appendString:@"K4PfaBq2clFm0IIK1YbH7aFbirrn7gwU6y0u/12aUxWAnuSs3oshKiLFP0cZFEYn\n"];
     [privateKey appendString:@"kWM90ZAj1dOkrA3u2nECQQDkJlcu4hcYCjfyb8Jc2mhi+rJyWXVtOrG8vGgbf+Hf\n"];
     [privateKey appendString:@"Y0UJJgoGyuAQD/C4VYQYLBympUoCwVimrQrBg05l/Dm9AkEAw9697KlfvOdqkVTs\n"];
     [privateKey appendString:@"uPTzdSNvUiZaZqmCpBUK5BW27HLi2HZ1YeyH0Emuenwc1LmviTFDFGE8rbzKeChe\n"];
     [privateKey appendString:@"hnMtXwJAHiTesggXSwrWl4aipIgK8MD04NznAfaWUzyFeNStsEk6btoCyyD098pT\n"];
     [privateKey appendString:@"YNeTq2nwoygFnlWTc/o7CJRjwF/R9QJAfv4cz6NlIjo8Wuvf629NpeYKmA2r0SIY\n"];
     [privateKey appendString:@"RMAr5oO5rQYz07rCEnJkAAS1rk5n9vhJOj8JSd5dlBtyfoNV/gARKwJAc6eBXPNA\n"];
     [privateKey appendString:@"HC5gLOIZNfqW7/sXhjZR47W3AdQsoKQekmVfHsh6ixq4vKn3TJtC8rbwTNknRLs4\n"];
     [privateKey appendString:@"ti1V2itso6belw==\n"];
     
     
     
     //生成订单信息及签名
     
     //将商品信息赋予AlixPayOrder的成员变量
     Order *order = [[Order alloc] init];
     order.partner = AliPID;
     order.seller = AliSID;
     order.tradeNO = orderNo; //订单ID（由商家自行制定）
     order.productName = @"天使礼客"; //商品标题
     order.productDescription = @"天使礼客"; //商品描述
     order.amount = [NSString stringWithFormat:@"%.2f",0.01]; //商品价格
     order.notifyURL =  @"http://app.angelslike.com/notify/index"; //回调URL
     
     order.service = @"mobile.securitypay.pay";
     order.paymentType = @"1";
     order.inputCharset = @"utf-8";
     order.itBPay = @"30m";
     order.showUrl = @"m.alipay.com";
     
     //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
     NSString *appScheme = @"angelslike";
     
     //将商品信息拼接成字符串
     NSString *orderSpec = [order description];
     NSLog(@"orderSpec = %@",orderSpec);
     
     //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
     id<DataSigner> signer = CreateRSADataSigner(privateKey);
     NSString *signedString = [signer signString:orderSpec];
     
     //将签名成功字符串格式化为订单字符串,请严格按照该格式
     NSString *orderString = nil;
     if (signedString != nil) {
         orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
         orderSpec, signedString, @"RSA"];
         
         __block StartCouViewViewController *tempSelf = self;
         [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
             if ([resultDic intForKey:@"resultStatus"] == 9000) {
                 [tempSelf showMessage:@"支付成功"];
                 [tempSelf backClick:nil];
             }else{
                 [[NetWork shared] query:CancelCouUrl info:@{@"orderid":orderNo} block:nil lock:NO];
//
             }
         }];
         
     }
     
    
}

-(void)backClick:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark cell action

-(void)valDayClick:(id)obj{
    UITableViewCell *cell = (UITableViewCell *)obj;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    CGRect rect = [self.tableView rectForRowAtIndexPath:indexPath];
    [popView showFromView:self.tableView atPoint:CGPointMake(rect.size.width - 10, rect.origin.y) animated:YES];
}

#pragma mark -
#pragma mark table view

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 3) {
        MyAddressCell *mcell = (MyAddressCell *) [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:3]];
        HerAddressCell *hcell = (HerAddressCell *) [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:3]];
        if (indexPath.row == 0) {
            if (!mcell.bCheck){
                [self.P setObject:@"1" forKey:@"Address"];
                mcell.bCheck = YES;
                hcell.bCheck = NO;
                [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:3]] withRowAnimation:UITableViewRowAnimationNone];
            }
        }else{
            if (!hcell.bCheck) {
                [self.P setObject:@"2" forKey:@"Address"];
                mcell.bCheck = NO;
                hcell.bCheck = YES;
                [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:3]] withRowAnimation:UITableViewRowAnimationNone];
            }
        }
    }
    if (indexPath.section == 5) {
        if (indexPath.row == 1) {
            OpenCell *cell = (OpenCell *) [self.tableView cellForRowAtIndexPath:indexPath];
            cell.bCheck = !cell.bCheck;
            NSString *check = [[NSNumber numberWithBool:cell.bCheck] stringValue];
            [self.P setObject:check forKey:@"is_show"];
        }else if (indexPath.row == 2){
            MutileCopiesCell *cell = (MutileCopiesCell *) [self.tableView cellForRowAtIndexPath:indexPath];
            cell.bCheck = !cell.bCheck;
            NSString *check = [[NSNumber numberWithBool:cell.bCheck] stringValue];
            [self.P setObject:check forKey:@"is_more"];
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0 & indexPath.section == 3) {
        
        if ([self.P intForKey:@"Address"] == 1) {
            return 210;
        }else{
            return 48;
        }
    }else{
        NSArray *arr =  @[@[@"107",@"37",@"100",@"180"],
                          @[@"69"],
                          @[@"48"],
                          @[@"48",@"89"],
                          @[@"69"],
                          @[@"52",@"52",@"52"]
                          ];
        return [arr[indexPath.section][indexPath.row] floatValue];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.infos[section]  count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.infos count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSArray *array = self.infos[indexPath.section];
    UITableViewCell *cell = [self CellFromName:array[indexPath.row]];
    if ([cell respondsToSelector:@selector(setInfo:)]) {
        [cell performSelector:@selector(setInfo:) withObject:self.P];
    }
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSArray *titles = @[@"",@"设置份数",@"支付方式",@"填写收货信息",@"自己先凑(可以多凑几份)",@"更多设置"];
    return titles[section];
}


#pragma mark -
#pragma mark cell


-(UITableViewCell *)CellFromName:(NSString *)name{
    Class class = NSClassFromString(name);
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:name];
    if (cell == nil) {
        cell = [[class alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:name];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
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
