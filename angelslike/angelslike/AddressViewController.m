//
//  AddressViewController.m
//  angelslike
//
//  Created by angelslike on 15/9/1.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "AddressViewController.h"

@interface AddressViewController ()

@end

@implementation AddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialSetting];
//    [self.navigationController setNavigationBarHidden:YES];
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initialSetting{
    bCenter = YES;
    float cen =  ScreenHeight / 2 + 32 ;
    mv = [[MineView alloc]initWithFrame:CGRectMake(0, cen - (ScreenHeight - 64) , ScreenWidth, ScreenHeight - 64 )];
    [self.view addSubview:mv];
    
    hv = [[HerView alloc]initWithFrame:CGRectMake(0, cen , ScreenWidth, ScreenHeight - 64)];
    [self.view addSubview:hv];
    
    cb = [[CircleButton alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    cb.center = CGPointMake(ScreenWidth / 2 , cen);
    [cb addTarget:self action:@selector(buttonClick:)];
    [self.view addSubview:cb];
    
    [self setBackButtonAction:@selector(backClick:)];
}

-(void)backClick:(id)sender{
    [self showTabbar];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)buttonClick:(UIButton *)sender{
    CGFloat off = 0;
    
    if (bCenter) {
        off = ScreenHeight / 2 + 32 - 64 ;
    }else{
        off = ScreenHeight - 64;
    }
    
    [UIView animateWithDuration:0.75 animations:^{
        if (sender.tag == 1) {
            mv.center = CGPointMake(ScreenWidth / 2, mv.center.y + off);
            hv.center = CGPointMake(ScreenWidth / 2, hv.center.y + off);
            cb.center = CGPointMake(ScreenWidth / 2, cb.center.y + off);
            [mv show];
            [hv dismiss];
        }else{
            [hv show];
            [mv dismiss];
            mv.center = CGPointMake(ScreenWidth / 2, mv.center.y - off);
            hv.center = CGPointMake(ScreenWidth / 2, hv.center.y - off);
            cb.center = CGPointMake(ScreenWidth / 2, cb.center.y - off);
        }
    } completion:^(BOOL finished) {
        [cb startAnimation:bCenter];
        bCenter = NO;
    }];
    
}


-(CABasicAnimation *)animation{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    // 设定动画选项
    animation.duration = 2.5; // 持续时间
    animation.repeatCount = 1; // 重复次数
    
    // 设定旋转角度
    animation.fromValue = [NSNumber numberWithFloat:0.0]; // 起始角度
    animation.toValue = [NSNumber numberWithFloat:2 * M_PI]; // 终止角度
    
    // 添加动画
    return animation;
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
