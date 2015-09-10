//
//  BuyNowViewController.m
//  angelslike
//
//  Created by ridchan on 15/8/26.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "BuyNowViewController.h"

@interface BuyNowViewController ()

@end

@implementation BuyNowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initailSetting];
    [self addBottomButton];
    // Do any additional setup after loading the view.
}

#pragma mark -
#pragma mark  set view

-(void)initailSetting{
    
    self.navigationItem.title = @"立即购买";
    
    //tableview

    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0 , ScreenWidth, ScreenHeight - 44) style:UITableViewStyleGrouped];

    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    
    self.tableView.backgroundColor = [UIColor clearColor];

    [self.view addSubview:self.tableView];
    

//    self.adds = [NSMutableArray arrayWithArray:@[@"姓名",@"地址",@"详细地址",@"电话",@"备注"]];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 25, 25);
    [button setImage:[[UIImage imageNamed:@"iconfont-houtui"] rt_tintedImageWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = barItem;
    
    av = [[AreaView alloc]init];
    [self.view addSubview:av];
    
}




-(void)addBottomButton{
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight - 48, ScreenWidth, 48)];
    v.backgroundColor = [UIColor whiteColor];
    [v.layer addSublayer:[self lineLayer:CGPointMake(0, 0)]];
    
    
//    RCRoundButton *b1 =  [RCRoundButton buttonWithType:UIButtonTypeCustom];
    totalLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 4, ScreenWidth / 2 - 15, 40)];
    totalLabel.backgroundColor = [UIColor clearColor];
    totalLabel.font = FontWS(14);
    [self setTotalLabel];


    [v addSubview:totalLabel];
    
    RCRoundButton *b2 =  [RCRoundButton buttonWithType:UIButtonTypeCustom];
    b2.frame = CGRectMake(ScreenWidth / 2 + 5 + 50, 4, ScreenWidth / 2 - 15 - 50, 40);
    [b2.titleLabel setFont:FontWS(14)];
    [b2 setBackgroundColor:[UIColor getHexColor:@"F85C85"]];
    [b2 setTitle:@"确认支付" forState:UIControlStateNormal];
    [b2 addTarget:self action:@selector(comfirmPay:) forControlEvents:UIControlEventTouchUpInside];
    [v addSubview:b2];
    
    
    [self.view addSubview:v];
}

#pragma mark -
#pragma mark action

-(void)addObservers{
    for(NSDictionary *dic in self.products){
        [dic addObserver:self forKeyPath:@"qty" options:NSKeyValueObservingOptionNew context:nil];
    }
}

-(void)setTotalLabel{
    NSString *str1 = @"合计: ￥";
    NSString *str2 = [self getTotal];
    totalLabel.attributedText = [self setColorText:[NSString stringWithFormat:@"%@%@",str1,str2] range:NSMakeRange([str1 length], [str2 length])];
}

-(NSString *)getTotal{
    CGFloat total = 0;
    for(NSDictionary *dic in self.products){
        total += [dic floatForKey:@"qty"] * [dic floatForKey:@"price"];
    }
    return [NSString stringWithFormat:@"%0.2f",total];
}

-(NSMutableAttributedString *)setColorText:(NSString *)str range:(NSRange)range{
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:str];
    [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor getHexColor:@"ff6969"] range:range];
    [attrString addAttribute:NSFontAttributeName value:FontWS(17) range:range];
    return  attrString;
}

-(void)backClick:(id)sender{
    [[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]] removeObserver:self forKeyPath:@"info.qty"];
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)comfirmPay:(id)sender{
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
    
    NSMutableDictionary *info = [NSMutableDictionary dictionary];
    for(NSDictionary *dic in self.products){
        [info setObject:[dic strForKey:@"id"] forKey:@"id"];//产品id
        [info setObject:[dic strForKey:@"qty"] forKey:@"qty"];//产品数量
    }
    [info setObject:[[UserInfo shared].info strForKey:@"loginkey"] forKey:@"loginkey"];
    [info setObject:@"4" forKey:@"paytype"];
    
    __block BuyNowViewController *tempSelf = self;
    [[NetWork shared] query:BuyNowUrl info:info block:^(id Obj) {
        if ([Obj intForKey:@"status"] == 1) {
            NSDictionary *data = [Obj objectForKey:@"data"];
            [tempSelf cancelOrder:[data strForKey:@"orderid"]];
        }
    } lock:YES];
}

-(void)cancelOrder:(NSString *)orderid{
    [[NetWork shared] query:CancelOrderUrl info:@{@"orderid":orderid} block:^(id Obj) {
        if ([Obj intForKey:@"status"] == 1) {
            NSLog(@"取消成功");
        }
    } lock:YES];
}


-(void)payInOrder:(NSString *)orderNo{
/*    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
 
    //生成订单信息及签名
 
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = [self generateTradeNO]; //订单ID（由商家自行制定）
    order.productName = product.subject; //商品标题
    order.productDescription = product.body; //商品描述
    order.amount = [NSString stringWithFormat:@"%.2f",product.price]; //商品价格
    order.notifyURL =  @"http://www.xxx.com"; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"alisdkdemo";
    
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
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
        }];
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    */
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    [self setTotalLabel];
}


#pragma mark -
#pragma mark table view delegate

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [@[@"22",@"22"][section] floatValue];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @[@"",@"支付方式"][section];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 90;
    }else{
        return 44;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return [self.products count];
        case 1:
            return 1;
        default:
            return 0;
            break;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        BuyCell *cell = (BuyCell *)[tableView dequeueReusableCellWithIdentifier:@"BuyCell"];
        if (cell == nil) {
            cell = [[BuyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BuyCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell addObserver:self forKeyPath:@"info.qty" options:NSKeyValueObservingOptionNew context:nil];
        }
        cell.info = [self.products objectAtIndex:indexPath.row];
        return cell;
//    }else if (indexPath.section == 1){
//        AddressCell *cell = (AddressCell *)[tableView dequeueReusableCellWithIdentifier:@"AddressCell"];
//        if (cell == nil) {
//            cell = [[AddressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AddressCell"];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        }
//
//        cell.textLabel.text = [self.adds objectAtIndex:indexPath.row];
//        return cell;
    }else{
        PayCell *cell = (PayCell *) [tableView dequeueReusableCellWithIdentifier:@"PayCell"];
        if (cell == nil) {
            cell = [[PayCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PayCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell;
    }
}


#pragma mark -

//-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
//    [av show];
//    return NO;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark picker delegate



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
