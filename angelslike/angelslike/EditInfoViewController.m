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
    [self initialSetting];
    // Do any additional setup after loading the view.
    self.info = [NSMutableDictionary dictionaryWithDictionary:[UserInfo shared].info];
    [self setTextInfo];
}

-(void)setTextInfo{
    nametxt.text = [self.info strForKey:@"name"];
    detailtxt.text = [self.info strForKey:@"address"];
    phonetxt.text = [self.info strForKey:@"phone"];
    mp.items = @[[self.info strForKey:@"pro"],[self.info strForKey:@"city"],[self.info strForKey:@"dis"]];
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
//    [self SelectAddress:view];
    
    mp = [[MutilePickerView alloc]initWithFrame:RECT(view.frame.size.width / 3, 60, view.frame.size.width / 3 * 2 - 10, 40)];
    mp.items = @[@"省",@"市",@"区"];
    mp.keys = @[@"pro",@"city",@"dis"];
    [view addSubview:mp];
    
    
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
    
    NSMutableDictionary *eidtInfo = [NSMutableDictionary dictionary];
    if ([nametxt.text length] == 0) {
        [self showMessage:@"请输入姓名"];
        return;
    }
    
    if ([detailtxt.text length] == 0) {
        [self showMessage:@"请输入详细地址"];
        return;
    }
    
    if ([phonetxt.text length] == 0) {
        [self showMessage:@"请输入名称"];
        return;
    }
    
    if ([newpass.text length] > 0 || [comfirmpass.text length] > 0) {
        if (![newpass.text isEqualToString:comfirmpass.text]) {
            [self showMessage:@"输入密码不一致"];
            return;
        }
        [eidtInfo setObject:newpass.text forKey:@"password"];
    }
    [eidtInfo setObject:nametxt.text forKey:@"name"];
    [eidtInfo setObject:detailtxt.text forKey:@"address"];
    [eidtInfo setObject:phonetxt.text forKey:@"phone"];
    [eidtInfo addEntriesFromDictionary:mp.result];
    
    [self.info removeObjectsForKeys:@[@"name",@"address",@"phone",@"pro",@"city",@"dis"]];
    [self.info addEntriesFromDictionary:eidtInfo];

    [[NetWork shared] query:UpdateMyInfoUrl info:eidtInfo block:^(id Obj) {
        if ([Obj intForKey:@"status"] == 1) {
            [tempSelf showMessage:@"修改成功"];
            [UserInfo shared].info = self.info;
        }else{
            [tempSelf showMessage:@"修改失败"];
        }
    } lock:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
