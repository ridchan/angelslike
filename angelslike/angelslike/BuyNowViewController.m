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
    

    self.adds = [NSMutableArray arrayWithArray:@[@"姓名",@"地址",@"详细地址",@"电话",@"备注"]];
    
    
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
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight - 44, ScreenWidth, 44)];
    v.backgroundColor = [UIColor whiteColor];
    [v.layer addSublayer:[self lineLayer:CGPointMake(0, 0)]];
    
    
//    RCRoundButton *b1 =  [RCRoundButton buttonWithType:UIButtonTypeCustom];
    totalLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, ScreenWidth / 2 - 15, 34)];
    totalLabel.backgroundColor = [UIColor clearColor];
    totalLabel.font = FontWS(14);
    [self setTotalLabel];


    [v addSubview:totalLabel];
    
    RCRoundButton *b2 =  [RCRoundButton buttonWithType:UIButtonTypeCustom];
    b2.frame = CGRectMake(ScreenWidth / 2 + 5 + 40, 5, ScreenWidth / 2 - 15 - 40, 34);
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
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    [self setTotalLabel];
}


#pragma mark -
#pragma mark table view delegate

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [@[@"22",@"22",@"22"][section] floatValue];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @[@"",@"收货信息",@"支付方式"][section];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 90;
    }else{
        return 44;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return [self.products count];
        case 1:
            return [self.adds count];
        case 2:
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
    }else if (indexPath.section == 1){
        AddressCell *cell = (AddressCell *)[tableView dequeueReusableCellWithIdentifier:@"AddressCell"];
        if (cell == nil) {
            cell = [[AddressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AddressCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }

        cell.textLabel.text = [self.adds objectAtIndex:indexPath.row];
        return cell;
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
