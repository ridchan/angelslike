//
//  MyWallentViewController.m
//  angelslike
//
//  Created by angelslike on 15/9/15.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "MyWallentViewController.h"

@interface MyWallentViewController ()

@end

@implementation MyWallentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的钱包";
    
    self.infos = @[@{@"Name":@"支付记录",@"IMG":@"mine_03"},
                   @{@"Name":@"提现记录",@"IMG":@"mine_04"},
                   ];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableHeaderView = [self headerView];
    self.tableView.tableFooterView = [self bottmView];
    
    
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
    
    [self refreshClick:nil];
    // Do any additional setup after loading the view.
}

-(void)refreshClick:(id)sender{
    __block MyWallentViewController *tempSelf = self;
    [[NetWork shared] query:MyWallentUrl info:@{@"loginkey":[[UserInfo shared].info strForKey:@"loginkey"]} block:^(id Obj) {
        [tempSelf showNetworkError:[Obj intForKey:@"status"] == 0];
        
        if ([Obj intForKey:@"status"] == 1) {
            tempSelf.info = [Obj objectForKey:@"data"];
        }
        tempSelf.tableView.tableHeaderView = [tempSelf headerView];
    } lock:NO];
}

-(UIView *)headerView{
    CGFloat width = ScreenWidth / 3;
    UIView *view = [[UIView alloc]initWithFrame:RECT(0, 0, ScreenWidth, 75)];
    NSArray *arr = @[@"当前余额",@"历史总额",@"获得金额"];
    NSArray *keys = @[@"currencymoney",@"historymoney",@"getamount"];
    for (int i = 0 ; i < [arr count] ; i ++){
        NSString *str = @"0";
        if (self.info) str = [self.info strForKey:keys[i]];
        [view addSubview:[self headSubView:RECT(width * i, 0, width, 65) price:str title:arr[i]]];
    }
    [view.layer addSublayer:[self lineLayer:CGPointMake(0, 65)]];
    return view;
}

-(UIView *)headSubView:(CGRect)rect price:(NSString *)price title:(NSString *)title{
    UIView *view = [[UIView alloc]initWithFrame:rect];
    view.backgroundColor = [UIColor whiteColor];

    
    UILabel *label = [[UILabel alloc] initWithFrame:RECT(0, 10, rect.size.width, rect.size.height / 2)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = RGBA(0, 0, 0, 0.85);
    label.text = [NSString stringWithFormat:@"￥%0.2f",[price floatValue]];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = FontWS(14);
    [view addSubview:label];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:RECT(0, rect.size.height / 2, rect.size.width, rect.size.height / 2)];
    label2.backgroundColor = [UIColor clearColor];
    label2.textColor = RGBA(0, 0, 0, 0.85);
    label2.text = title;
    label2.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label2];
    
    return view;
}

-(UIView *)bottmView{
    CGFloat margin = ScreenWidth * 0.04;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 70)];
    view.backgroundColor = [UIColor clearColor];
    RCRoundButton *button1 = [RCRoundButton buttonWithType:UIButtonTypeCustom];
    [button1 setCorner:8];
    button1.frame = RECT(margin, 30, ScreenWidth * 0.44, 40);
    button1.backgroundColor = HexColor(@"FAC116");
    [button1 setTitleShadowColor:HexColor(@"E4AD05") forState:UIControlStateNormal];
    [button1 setTitle:@"充值" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(payMoney:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button1];
    
    RCRoundButton *button2 = [RCRoundButton buttonWithType:UIButtonTypeCustom];
    [button2 setCorner:8];
    button2.frame = RECT(ScreenWidth * 0.52, 30, ScreenWidth * 0.44, 40);
    button2.backgroundColor = HexColor(@"F85C85");
    [button2 setTitleShadowColor:HexColor(@"F7356A") forState:UIControlStateNormal];
    [button2 setTitle:@"提现" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(getMoney:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button2];
    
    return view;
    
}

-(void)payMoney:(id)obj{
//    [self showHudMsg:@"x231dafdafdafdrfgfdafdafdafdafdafdafdafdafd"];
}

-(void)getMoney:(id)obj{
    AnswerView *anView = [[AnswerView alloc]init];
    anView.block = ^(id obj,AnswerViewType type){
        
    };
    [anView showWithObject:nil withTitle:@"请输入提现金额"];
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

//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if (section == 0) {
//        return 0.01;
//    }else{
//        return 2.0;
//    }
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section == 0) {
//        return 200;
//    }else{
//        return 44;
//    }
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        UIViewController *vc = [[NSClassFromString(@"PayRecordsViewController") alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identify = @"Cell";
    MineCell *cell = (MineCell *) [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[MineCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    NSDictionary *dic = [self.infos objectAtIndex:indexPath.row];
    cell.info = dic;
    
    return cell;
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  [self.infos count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

@end
