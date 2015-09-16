//
//  OrderDetailViewController.m
//  angelslike
//
//  Created by angelslike on 15/9/16.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "OrderDetailViewController.h"

@interface OrderDetailViewController ()

@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"订单详情";
    [self setBackButtonAction:@selector(backClick:)];
    
    [self initialSetting];
    [self refreshClick:nil];
    
    self.result = @[@[@{@"Name":@"订单单号",@"key":@"orderid"},
                      @{@"Name":@"流水单号",@"key":@"transaction_id"},
                      @{@"Name":@"交易时间",@"key":@"time"},
                      @{@"Name":@"总金额",@"key":@"price"}],
                    @[@{@"Name":@"",@"key":@"ename"}],
                    @[@{@"Name":@"姓名",@"key":@"name"},
                      @{@"Name":@"地址",@"key":@"pro,city,dis"},
                      @{@"Name":@"详细地址",@"key":@"address"},
                      @{@"Name":@"电话",@"key":@"phone"}],
                    @[@{@"Name":@"",@"key":@"paytype"}]
                    ];
    // Do any additional setup after loading the view.
}

-(void)refreshClick:(id)sender{
    __block OrderDetailViewController *tempSelf = self;
    [[NetWork shared] query:OrderDetailUrl info:@{@"id":self.orderid,@"loginkey":[[UserInfo shared].info strForKey:@"loginkey"]} block:^(id Obj) {
        if (![tempSelf showNetworkError:[Obj intForKey:@"status"] == 0]){
            tempSelf.info = [Obj objectForKey:@"data"];
            [tempSelf.tableView reloadData];
        }

    } lock:YES];
}

-(void)initialSetting{
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"查看物流" style:UIBarButtonItemStylePlain target:self action:@selector(addressClick:)];
    self.navigationItem.rightBarButtonItem = right;
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];

}

-(void)addressClick:(id)obj{
    
}

-(void)backClick:(id)obj{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:RECT(0, 0, ScreenWidth, 30)];
    UILabel *label = [[UILabel alloc]initWithFrame:RECT(10, 0, ScreenWidth - 20, 25)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor lightGrayColor];
    label.font = FontWS(16);
    label.text = @[@"订单信息",@"物流信息",@"收货信息",@"支付方式"][section];
    [view addSubview:label];
    return view;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.info?[self.result[section] count]:0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.result count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
        cell.textLabel.textColor = HexColor(@"000000");
        cell.detailTextLabel.textColor = HexColor(@"000000");
        cell.textLabel.font = FontWS(12);
        cell.detailTextLabel.font = FontWS(12);
    }
    NSDictionary *dic = self.result[indexPath.section][indexPath.row];
    if ([[dic strForKey:@"Name"] length] > 0 ){
        cell.textLabel.text = [dic strForKey:@"Name"];
        cell.detailTextLabel.text = [self stringInKeys:[dic strForKey:@"key"] info:self.info];
    }else{
        cell.textLabel.text = [self stringInKeys:[dic strForKey:@"key"] info:self.info];
    }
    return cell;
}


-(NSString *)stringInKeys:(NSString *)keys info:(NSDictionary *)inf{
    NSArray *arr = [keys componentsSeparatedByString:@","];
    NSMutableString *res = [[NSMutableString alloc] init];
    for (NSString *key in arr){
        [res appendString:[inf strForKey:key]];
    }
    return res;
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
