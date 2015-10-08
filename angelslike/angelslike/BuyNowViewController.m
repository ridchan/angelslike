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
    self.addInfo = [NSMutableDictionary dictionaryWithObject:@"-1" forKey:@"Address"];
    // Do any additional setup after loading the view.
}

#pragma mark -
#pragma mark  set view

-(void)initailSetting{
    
    self.navigationItem.title = @"立即购买";
    
    //tableview

//    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0 , ScreenWidth, ScreenHeight - 44) style:UITableViewStyleGrouped];
//
//    self.tableView.dataSource = self;
//    self.tableView.delegate = self;
//    self.tableView.backgroundColor = [UIColor clearColor];
//    [self.view addSubview:self.tableView];
    
    
    _scrollView = [[UIScrollView alloc]initWithFrame:RECT(0, 0, ScreenWidth, ScreenHeight)];
    [self.view addSubview:_scrollView];
    
    
//    self.adds = [NSMutableArray arrayWithArray:@[@"姓名",@"地址",@"详细地址",@"电话",@"备注"]];
    addSelect = -1;
    
    [self setBackButtonAction:@selector(backClick:)];
    
    av = [[AreaView alloc]init];
    [self.view addSubview:av];
    
    
    switch ([self.products[0] intForKey:@"show"]) {
        case 0:
        case 1:
            [self addBasicInfo];
            break;
        case 2:
            [self addBuyOneView];
            break;
        case 3:
            [self addBoundView];
            break;
        default:
            break;
    }
    
}

-(void)addBasicInfo{
    BuyView *bv = [[BuyView alloc]initWithFrame:RECT(0, 10, ScreenWidth, 90)];
    bv.info = [self.products objectAtIndex:0];
    [bv addObserver:self forKeyPath:@"info.qty" options:NSKeyValueObservingOptionNew context:nil];
    [_scrollView addSubview:bv];
    
    UILabel *label1 = [self normalLabel:RECT(10, MaxY(bv), ScreenWidth - 20, 38) title:@"支付方式"];
    [_scrollView addSubview:label1];
    
    PayView *pv = [[PayView alloc]initWithFrame:RECT(0, MaxY(label1), ScreenWidth, 44)];
    pv.selectIndex = 0;
    [_scrollView addSubview:pv];
    
    UILabel *label2 = [self normalLabel:RECT(10, MaxY(pv), ScreenWidth - 20, 38) title:@"收货方式"];
    [_scrollView addSubview:label2];
    
    MyAddressView *mv = [[MyAddressView alloc]initWithFrame:RECT(0, MaxY(label2), ScreenWidth, 44)];
    [_scrollView addSubview:mv];
    HerAddressView *hv = [[HerAddressView alloc]initWithFrame:RECT(0, MaxY(mv), ScreenWidth, 80)];
    [_scrollView addSubview:hv];
    _scrollView.contentSize = CGSizeMake(1, MaxY(hv));
    
    
    __block MyAddressView *tempMV = mv;
    __block HerAddressView *tempHV = hv;
    
    mv.block = ^(id obj){
        hv.bCheck = ![obj boolValue];
        [UIView animateWithDuration:0.35 animations:^{
            [[self.view viewWithTag:9099] removeFromSuperview];
            tempCover = nil;
            tempMV.frame = RECT(tempMV.frame.origin.x, tempMV.frame.origin.y, ScreenWidth, 220);
            tempHV.frame = RECT(0, MaxY(tempMV), ScreenWidth, 80);
            _scrollView.contentSize = CGSizeMake(1, MaxY(tempHV));
            
        }];

    };
    
    __block BuyNowViewController *tempSelf = self;
    hv.block = ^(id obj){
        mv.bCheck = ![obj boolValue];
        tempMV.frame = RECT(tempMV.frame.origin.x, tempMV.frame.origin.y, ScreenWidth, 44);
        tempHV.frame = RECT(0, MaxY(tempMV), ScreenWidth, 80);
        UIView *anView = [tempSelf animationView:RECT(0, MaxY(tempHV), ScreenWidth, 320)];
        anView.tag = 9099;
        _scrollView.contentSize = CGSizeMake(1, MaxY(anView));
        [_scrollView scrollRectToVisible:RECT(0, MaxY(anView), ScreenWidth, 1) animated:NO];
        [_scrollView addSubview:anView];
        [anView.layer addAnimation:[tempSelf animation] forKey:nil];
    };
}


-(UIView *)animationView:(CGRect)rect{
    UIView *view = [[UIView alloc] initWithFrame:rect];
    UILabel *label = [[UILabel alloc] initWithFrame:RECT(0, 0, rect.size.width, 44)];
    label.backgroundColor = RGBA(241, 241, 247, 1.0);
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"收礼人收到的礼物是这样的,很贴心吧?";
    [view addSubview:label];
    
    UIView *scaleView = [[UIView alloc]initWithFrame:RECT((ScreenWidth - 250) / 2, 60, 250, 250)];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:RECT(0, 0, 250, 250)];
    UIImageView *coverView = [[UIImageView alloc]initWithFrame:imageView.frame];
    coverView.image =  IMAGE(@"giftCover");
    UIImageView *borderView = [[UIImageView alloc]initWithFrame:imageView.frame];
    borderView.image =  IMAGE(@"product-box");
    
    [scaleView addSubview:imageView];
    [scaleView addSubview:borderView];
    [scaleView addSubview:coverView];
    
    [view addSubview:scaleView];
    
    tempCover = coverView;

    [imageView setPreImageWithUrl:[self.products[0] strForKey:@"imgs"] block:^(id Obj) {
        
    }];
    
    return view;
}

-(void)runViewAnimation{
    if (tempCover == nil) return;
    __block BuyNowViewController *tempSelf = self;
    [UIView animateWithDuration:1.5 animations:^{
        tempCover.center = CGPointMake(tempCover.center.x - 200, tempCover.center.y);
        tempCover.alpha = 0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0 animations:^{
            tempCover.center = CGPointMake(tempCover.center.x + 200, tempCover.center.y);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.7 animations:^{
                tempCover.alpha = 1.0;
            } completion:^(BOOL finished) {
                [tempSelf runViewAnimation];
            }];
        }];
    }];

}

-(CABasicAnimation *)animation{
    CABasicAnimation *an = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    an.duration = 0.35;
    an.fromValue = [NSNumber numberWithFloat:0.5];
    an.toValue = [NSNumber numberWithFloat:1.0];
    an.removedOnCompletion = YES;
    an.delegate = self;
    an.fillMode = kCAFillModeForwards;
    return an;
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (flag) {
        [self runViewAnimation];
    }
}

//保税品

-(void)addBoundView{
    BuyView *bv = [[BuyView alloc]initWithFrame:RECT(0, 10, ScreenWidth, 90)];
    bv.info = [self.products objectAtIndex:0];
    [bv addObserver:self forKeyPath:@"info.qty" options:NSKeyValueObservingOptionNew context:nil];
    [_scrollView addSubview:bv];
    
    UILabel *label1 = [self normalLabel:RECT(10, MaxY(bv), ScreenWidth - 20, 38) title:@"收货信息"];
    [_scrollView addSubview:label1];
    
    UIView *notice = [self noticeView:RECT(0, MaxY(label1), ScreenWidth, 80) title:@"本品为海关监管保税品，合法报关享受免税，需验证客户真实身份信息。\n相关信息直接对接公安机关系统，严格加密，他人无法盗用，请您放心。"];
    [notice addline:CGPointMake(0, 80) color:nil];

    [_scrollView addSubview:notice];
    
    BoundView *bnv = [[BoundView alloc]initWithFrame:RECT(0, MaxY(notice), ScreenWidth, 210)];
    [_scrollView addSubview:bnv];
    
    UILabel *label2 = [self normalLabel:RECT(10, MaxY(bnv), ScreenWidth - 20, 38) title:@"运费"];
    [_scrollView addSubview:label2];
    
    UIView *postage = [self postageView:RECT(0, MaxY(label2), ScreenWidth, 44)];
    [_scrollView addSubview:postage];
    
    
    UILabel *label3 = [self normalLabel:RECT(10, MaxY(postage), ScreenWidth - 20, 38) title:@"支付方式"];
    [_scrollView addSubview:label3];
    
    PayView *pv = [[PayView alloc]initWithFrame:RECT(0, MaxY(label3), ScreenWidth, 44)];
    pv.selectIndex = 0;
    [_scrollView addSubview:pv];
    
    _scrollView.contentSize = CGSizeMake(1, MaxY(pv));
//    _scrollView.contentSize = CGSizeMake(1, MaxY(hv));
}





-(UIView *)noticeView:(CGRect)rect title:(NSString *)title{
    UIView *view = [[UIView alloc]initWithFrame:rect];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *notice = [[UILabel alloc]initWithFrame:RECT(10, 5, ScreenWidth - 20, rect.size.height - 10)];
    notice.numberOfLines = 10;
    notice.font = FontWS(11);
    notice.textColor = HexColor(@"ff6969");
    notice.text = title;
    [view addSubview:notice];
    return view;
}

-(UIView *)postageView:(CGRect)rect{
    UIView *view = [[UIView alloc]initWithFrame:rect];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc]initWithFrame:RECT(10, 0, ScreenWidth - 20, rect.size.height)];
    
    NSString *price = Format2(MoneySign, @"8.00");
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:price];
    [att addAttribute:NSForegroundColorAttributeName value:HexColor(@"ff6969") range:NSMakeRange(1, 4)];
    label.attributedText = att;
    
    [view addSubview:label];
    return view;
}


//买一送一

-(void)addBuyOneView{
    BuyView *bv = [[BuyView alloc]initWithFrame:RECT(0, 10, ScreenWidth, 90)];
    bv.info = [self.products objectAtIndex:0];
    [bv addObserver:self forKeyPath:@"info.qty" options:NSKeyValueObservingOptionNew context:nil];
    [_scrollView addSubview:bv];
    
    
    
    UILabel *label1 = [self normalLabel:RECT(10, MaxY(bv), ScreenWidth - 20, 38) title:@"支付方式"];
    [_scrollView addSubview:label1];
    
    PayView *pv = [[PayView alloc]initWithFrame:RECT(0, MaxY(label1), ScreenWidth, 44)];
    pv.selectIndex = 0;
    [_scrollView addSubview:pv];
    
    
    UILabel *label2 = [self normalLabel:RECT(10, MaxY(pv), ScreenWidth - 20, 38) title:@"填写收货信息"];
    [_scrollView addSubview:label2];
    
    AddressView *adv = [[AddressView alloc]initWithFrame:RECT(0, MaxY(label2), ScreenWidth, 180)];
    [_scrollView addSubview:adv];
    
    UIView *notice = [self noticeView:RECT(0, MaxY(adv), ScreenWidth, 44) title:@"付款后把收礼物页面发送给你的闺蜜，让Ta填上收货信息，才能完成此订单。"];
    [notice addline:CGPointMake(0, 0) color:nil];
    [_scrollView addSubview:notice];
    

    
    UILabel *label3 = [self normalLabel:RECT(10, MaxY(notice), ScreenWidth - 20, 38) title:@"给客服留言"];
    [_scrollView addSubview:label3];
    
    UIView *remark = [self customerTextView:RECT(0, MaxY(label3), ScreenWidth, 95)];
    [_scrollView addSubview:remark];
    
    

    
    _scrollView.contentSize = CGSizeMake(1, MaxY(remark));
    //    _scrollView.contentSize = CGSizeMake(1, MaxY(hv));
}

-(UIView *)customerTextView:(CGRect)rect{
    UIView *view = [[UIView alloc]initWithFrame:rect];
    view.backgroundColor = [UIColor whiteColor];
    UITextView *textView = [[UITextView alloc]initWithFrame:RECT(10, 5, rect.size.width - 20, rect.size.height - 10)];
    textView.backgroundColor = RGBA(247, 247, 247, 1);
    textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    textView.layer.borderWidth = 1.0;
    textView.layer.cornerRadius = 5;
    textView.layer.masksToBounds = YES;
    [view addSubview:textView];
    return view;
}


///

-(UILabel *)normalLabel:(CGRect)rect title:(NSString *)title{
    UILabel *label = [[UILabel alloc]initWithFrame:rect];
    label.backgroundColor = [UIColor clearColor];
    label.font = FontWS(14);
    label.textColor = HexColor(@"666666");
    label.text = title;
    return label;
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
    
    NSMutableDictionary *info = [NSMutableDictionary dictionary];
    for(NSDictionary *dic in self.products){
        [info setObject:[dic strForKey:@"id"] forKey:@"id"];//产品id
        [info setObject:[dic strForKey:@"qty"] forKey:@"qty"];//产品数量
    }
    
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



-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    [self setTotalLabel];
}


#pragma mark -
#pragma mark table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        MyAddressCell *mcell = (MyAddressCell *) [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:3]];
        HerAddressCell *hcell = (HerAddressCell *) [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:3]];
        if (indexPath.row == 0) {
            if (!mcell.bCheck){
                [self.addInfo setObject:@"1" forKey:@"Address"];
                mcell.bCheck = YES;
                hcell.bCheck = NO;
                [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:2]] withRowAnimation:UITableViewRowAnimationNone];
            }
        }else{
            if (!hcell.bCheck) {
                [self.addInfo setObject:@"2" forKey:@"Address"];
                mcell.bCheck = NO;
                hcell.bCheck = YES;
                [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:2]] withRowAnimation:UITableViewRowAnimationNone];
            }
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [@[@"22",@"22",@"22"][section] floatValue];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @[@"",@"支付方式",@"送货方式"][section];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 || (indexPath.section == 2 & indexPath.row == 1)) {
        return 90;
    }else if (indexPath.section == 2 & indexPath.row == 0 & addSelect == 0){
        return 210;
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
            return 1;
        case 2:
            return 2;
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
    }else if (indexPath.section == 2){
        if (indexPath.row == 0){
            MyAddressCell *cell = (MyAddressCell *)[tableView dequeueReusableCellWithIdentifier:@"MyAddressCell"];
            if (cell == nil) {
                cell = [[MyAddressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyAddressCell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.info = self.addInfo;
    //        cell.textLabel.text = [self.adds objectAtIndex:indexPath.row];
            return cell;
        }else{
            HerAddressCell *cell = (HerAddressCell *)[tableView dequeueReusableCellWithIdentifier:@"HerAddressCell"];
            if (cell == nil) {
                cell = [[HerAddressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HerAddressCell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            //cell.textLabel.text = [self.adds objectAtIndex:indexPath.row];
            return cell;
        }
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
