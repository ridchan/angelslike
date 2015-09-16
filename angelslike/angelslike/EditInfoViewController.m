//
//  EditInfoViewController.m
//  angelslike
//
//  Created by angelslike on 15/9/16.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "EditInfoViewController.h"

@interface EditInfoViewController ()

@end

@implementation EditInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"编辑资料";
    [self setBackButtonAction:@selector(backClick:)];
    [self initialSetting];
    // Do any additional setup after loading the view.
    self.info = [NSMutableDictionary dictionaryWithDictionary:[UserInfo shared].info];
    [self setTextInfo];
}

-(void)setTextInfo{
    nametxt.text = [self.info strForKey:@"name"];
    detailtxt.text = [self.info strForKey:@"address"];
    phonetxt.text = [self.info strForKey:@"phone"];
}


-(void)initialSetting{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, 212)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    [view addSubview:[self labelName:@"姓名" frame:CGRectMake(10, 10, 100, 48)]];
    [view addline:CGPointMake(0, 58) color:nil];
    [view addSubview:[self labelName:@"地址" frame:CGRectMake(10, 58, 100, 48)]];
    [view addline:CGPointMake(0, 106) color:nil];
    [view addSubview:[self labelName:@"详细地址" frame:CGRectMake(10, 106, 100, 48)]];
    [view addline:CGPointMake(0, 154) color:nil];
    [view addSubview:[self labelName:@"电话" frame:CGRectMake(10, 154, 100, 48)]];
    
    nametxt = [self textField:CGRectMake(view.frame.size.width / 3, 18, view.frame.size.width / 3 * 2 - 10, 32) withTag:11];
    [view addSubview:nametxt];
    [self SelectAddress:view];
    detailtxt = [self textField:CGRectMake(view.frame.size.width / 3, 112, view.frame.size.width / 3 * 2 - 10, 32) withTag:12];
    [view addSubview:detailtxt];
    phonetxt = [self textField:CGRectMake(view.frame.size.width / 3, 162, view.frame.size.width / 3 * 2 - 10, 32) withTag:13];
    [view addSubview:phonetxt];
    
    UILabel *lbl = [[UILabel alloc]initWithFrame:RECT(10, 276, ScreenWidth - 20, 30)];
    lbl.backgroundColor = [UIColor clearColor];
    lbl.textColor = [UIColor lightGrayColor];
    lbl.font = FontWS(12);
    lbl.text = @"修改密码";
    [self.view addSubview:lbl];
    
    UIView *view2 = [[UIView alloc]initWithFrame:RECT(0, 306, ScreenWidth, 106)];
    view2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view2];
    
    [view2 addSubview:[self labelName:@"新密码" frame:CGRectMake(10, 10, 100, 48)]];
    [view2 addline:CGPointMake(0, 58) color:nil];
    [view2 addSubview:[self labelName:@"确认密码" frame:CGRectMake(10, 58, 100, 48)]];

    newpass = [self textField:CGRectMake(view2.frame.size.width / 3, 18, view2.frame.size.width / 3 * 2 - 10, 30) withTag:14];
    newpass.secureTextEntry = YES;
    [view2 addSubview:newpass];
    comfirmpass = [self textField:CGRectMake(view2.frame.size.width / 3, 66, view2.frame.size.width / 3 * 2 - 10, 30) withTag:15];
    comfirmpass.secureTextEntry = YES;
    [view2 addSubview:comfirmpass];
    
    RCRoundButton *button = [RCRoundButton buttonWithType:UIButtonTypeCustom];
    [button setCorner:8.0];
    [button setBackgroundColor:HexColor(@"F85C85")];
    [button setTitleShadowColor:HexColor(@"F7356A") forState:UIControlStateNormal];
    [button setTitle:@"提交" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(editbuttonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = RECT(20, 430 , ScreenWidth - 40, 40);
    [self.view addSubview:button];
}

-(void)editbuttonClick:(id)sender{
    __block EditInfoViewController *tempSelf = self;
    [self.info setObject:newpass.text forKey:@"password"];
    [[NetWork shared] query:UpdateMyInfoUrl info:self.info block:^(id Obj) {
        if ([Obj intForKey:@"status"] == 1) {
            [tempSelf showMessage:@"修改成功"];
            [UserInfo shared].info = tempSelf.info;
        }
    } lock:YES];
}

-(void)backClick:(id)obj{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)SelectAddress:(UIView *)view{
    NSArray *arr = @[@"省",@"市",@"区"];
    CGFloat width = ((self.view.frame.size.width / 3 * 2 - 10) - 10) / 3;
    CGFloat left = self.view.frame.size.width / 3;
    for (int i  = 0 ; i < 3 ; i ++){
        PickerView *pk = [[PickerView alloc]initWithFrame:RECT(left + (width + 5) * i , 66, width, 32)];
        pk.tag = i + 1;
        pk.text = [arr objectAtIndex:i];
        [pk addTarget:self action:@selector(addressSelect:)];
        [view addSubview:pk];
    }
}

-(void)addressSelect:(PickerView *)pk{
    NSString *type = @"";
    if (pk.tag == 1) {
        type = @"pro";
    }else if (pk.tag == 2){
        type = @"city";
    }else{
        type = @"dis";
    }
    
    id address = [UserDefault objectForKey:type];
    if (!address) {
        [[NetWork shared]query:AddressUrl info:@{@"type":type} block:^(id Obj) {
            id newAddress = [Obj objectForKey:@"data"];
            [UserDefault setObject:newAddress forKey:type];
            
            if (pk.tag == 1) {
                [self showSelection:newAddress picker:pk];
            }else if (pk.tag == 2){
                PickerView *pk1 = (PickerView *)[self.view viewWithTag:1];
                NSArray *newArr = [newAddress objectForKey:pk1.text];
                [self showSelection:newArr picker:pk];
            }else{
                PickerView *pk2 = (PickerView *)[self.view viewWithTag:2];
                NSArray *newArr = [newAddress objectForKey:pk2.text];
                [self showSelection:newArr picker:pk];
            }
        } lock:NO];
    }else{
        if (pk.tag == 1) {
            [self showSelection:address picker:pk];
        }else if (pk.tag == 2){
            PickerView *pk1 = (PickerView *)[self.view viewWithTag:1];
            NSArray *newArr = [address objectForKey:pk1.text];
            [self showSelection:newArr picker:pk];
        }else{
            PickerView *pk2 = (PickerView *)[self.view viewWithTag:2];
            NSArray *newArr = [address objectForKey:pk2.text];
            [self showSelection:newArr picker:pk];
        }
    }
    
}

-(void)showSelection:(NSArray *)arr picker:(PickerView *)pk{
    if (!popView)
        popView = [[SGPopSelectView alloc] init];
    popView.selections = arr;
    __block SGPopSelectView *tempView = popView;
    __block EditInfoViewController *tempSelf = self;
    popView.selectedHandle = ^(NSInteger selectedIndex){
        pk.text = tempView.selections[selectedIndex];
        NSArray *arr = @[@"pro",@"city",@"dis"];
        [tempSelf.info setObject:pk.text forKey:arr[pk.tag - 1]];
        [tempView hide:NO];
    };
    
//    CGRect rect=[pk convertRect:pk.frame toView:self.view];
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    CGRect rect=[pk convertRect:pk.bounds toView:window];
    
    [popView showFromView:window atPoint:rect.origin animated:YES];
}


-(UITextField *)textField:(CGRect)frame withTag:(NSInteger)tag{
    UITextField *txt = [[UITextField alloc]initWithFrame:frame];
    txt.font = FontWS(14);
    txt.backgroundColor = HexColor(@"F8F8F8");
    txt.borderStyle = UITextBorderStyleNone;
    txt.layer.borderColor = HexColor(@"bbbbbb").CGColor;
    txt.layer.borderWidth = 1.0;
    txt.layer.cornerRadius = 4;
    txt.layer.masksToBounds = YES;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(1, 1, 5, 1)];
    view.backgroundColor = [UIColor clearColor];
    txt.leftViewMode = UITextFieldViewModeAlways;
    txt.leftView = view;
    txt.tag = tag;
    return txt;
}

-(UILabel *)labelName:(NSString *)name frame:(CGRect)frame{
    UILabel *label1 = [[UILabel alloc]initWithFrame:frame];
    label1.backgroundColor = [UIColor clearColor];
    label1.font = FontWS(12);
    label1.text = name;
    return label1;
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
