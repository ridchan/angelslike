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
    [self.P setObject:@"4" forKey:@"paytype"];
    
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

-(void)weixinpayResult:(NSNotification *)notification{
    [[NSNotificationCenter defaultCenter]removeObserver:self forKeyPath:@"WeiXinPayResult"];
    NSDictionary *dic = notification.object;
    if ([dic intForKey:@"status"] == 0) {
        [self showMessage:@"支付成功"];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self showMessage:@"支付失败"];
    }
    
}

-(void)couClick:(id)sender{
//    [self.P setObject:[[UserInfo shared].info strForKey:@"loginkey"] forKey:@"loginkey"];
    if ([[self.P strForKey:@"title"] length] == 0) [self showMessage:@"请输入标题"];
    if ([[self.P strForKey:@"content"] length] == 0) [self showMessage:@"请输入内容"];
    
    __block StartCouViewViewController *tempSelf = self;
    
    [[NetWork shared] query:ComfirmCouUrl info:self.P block:^(id Obj) {
        if ([Obj intForKey:@"status"] == 1){
            [tempSelf payInOrder:[[Obj objectForKey:@"data"] strForKey:@"orderid"] withAmount:[tempSelf.P strForKey:@"MyCouAmount"]];
        }
        
    } lock:YES];
}


-(void)payInOrder:(NSString *)orderNo withAmount:(NSString *)amount{
    __block StartCouViewViewController *tempSelf = self;
    NSString *amt = [amount stringByReplacingOccurrencesOfString:MoneySign withString:@""];
    if ([tempSelf.P intForKey:@"paytype"] == 4) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weixinpayResult:) name:@"WeiXinPayResult" object:nil];
        NSString *namt = [NSString stringWithFormat:@"%.0f",[amt floatValue] * 100];
        [WeiXinPayObj payWithInfo:@{@"orderno":orderNo,@"amount":namt} successBlock:nil failBlock:nil];
        
//        [[NetWork shared] query:CancelCouUrl info:@{@"orderid":orderNo} block:nil lock:YES];
    }else{
        [AliPayObj payWithInfo:@{@"orderno":orderNo,@"amount":amt} successBlock:^(id obj) {
            [tempSelf showMessage:@"支付成功"];
            [tempSelf.navigationController popViewControllerAnimated:YES];
        } failBlock:^(id obj) {
            [[NetWork shared] query:CancelCouUrl info:@{@"orderid":orderNo} block:nil lock:YES];
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
