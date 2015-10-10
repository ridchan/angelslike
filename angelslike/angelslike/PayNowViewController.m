//
//  PayNowViewController.m
//  angelslike
//
//  Created by angelslike on 15/9/23.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "PayNowViewController.h"

@interface PayNowViewController ()

@end

@implementation PayNowViewController

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc]initWithFrame:RECT(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weixinPayResult:) name:WeiXinPayNotification object:nil];
    [self addBottomButton];
    // Do any additional setup after loading the view.
}



-(void)addBottomButton{
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight - 48, ScreenWidth, 48)];
    v.backgroundColor = [UIColor whiteColor];
    [v.layer addSublayer:[self lineLayer:CGPointMake(0, 0)]];
    
    
    //    RCRoundButton *b1 =  [RCRoundButton buttonWithType:UIButtonTypeCustom];
    UILabel  *totalLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 4, ScreenWidth / 2 - 15, 40)];
    totalLabel.backgroundColor = [UIColor clearColor];
    totalLabel.font = FontWS(14);
    
    NSString *str1 = @"合计: ￥";
    NSString *str2 = self.price;
    totalLabel.attributedText = [self setColorText:[NSString stringWithFormat:@"%@%@",str1,str2] range:NSMakeRange([str1 length], [str2 length])];
    
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

-(void)weixinPayResult:(NSNotification *)notification{
    [[NSNotificationCenter defaultCenter] removeObserver:self forKeyPath:WeiXinPayNotification];
    NSDictionary *dic = notification.object;
    if ([dic intForKey:@"status"] == 0) {
        [self showMessage:@"支付成功"];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self showMessage:@"支付失败"];
    }
}

-(void)comfirmPay:(id)sender{
    
    PayCell *cell = (PayCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    NSInteger idx = cell.selectIndex;
    
    [[NetWork shared] query:BuyNowUrl  info:@{} block:^(id Obj) {
        if (idx == 0) {
            //微信支付
            NSString *namt = [NSString stringWithFormat:@"%.0f",[self.price floatValue] * 100];
            
            [WeiXinPayObj payWithInfo:@{@"orderno":self.orderid,@"amount":namt} successBlock:nil failBlock:nil];
        }else{
            //支付宝支付
            __weak PayNowViewController *tempSelf = self;
            [AliPayObj payWithInfo:@{@"orderno":self.orderid,@"amount":self.price} successBlock:^(id obj) {
                [tempSelf showMessage:@"支付成功"];
                [tempSelf.navigationController popViewControllerAnimated:YES];
            } failBlock:^(id obj) {
                
            }];
        }
    } lock:YES];
    

}


-(NSMutableAttributedString *)setColorText:(NSString *)str range:(NSRange)range{
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:str];
    [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor getHexColor:@"ff6969"] range:range];
    [attrString addAttribute:NSFontAttributeName value:FontWS(17) range:range];
    return  attrString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PayCell *cell = (PayCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[PayCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"支付方式";
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
