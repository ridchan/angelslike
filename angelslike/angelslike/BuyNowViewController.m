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
    
    UIPickerView *picker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, 320, 1)];
    picker.delegate = self;
    picker.dataSource = self;
    picker.frame = CGRectMake(0, ScreenHeight - picker.frame.size.height, 320, 1);
    [self.view addSubview:picker];
    __block UIPickerView *tempView = picker;
    [[NetWork shared]query:AddressUrl info:@{@"type":@"pro"} block:^(id Obj) {
        NSLog(@"a=>%@",[[Obj objectForKey:@"data"] class]);
        [tempView reloadAllComponents];
    } lock:NO];
    
    [[NetWork shared]query:AddressUrl info:@{@"type":@"city"} block:^(id Obj) {
        NSLog(@"b=>%@",[[Obj objectForKey:@"data"] class]);
        [tempView reloadComponent:1];
    } lock:NO];
    
    [[NetWork shared]query:AddressUrl info:@{@"type":@"dis"} block:^(id Obj) {
        NSLog(@"b=>%@",[[Obj objectForKey:@"data"] class]);
        [tempView reloadComponent:2];
    } lock:NO];
    

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark picker delegate

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return @"aaaaaaaaaaaaa";
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        // Setup label properties - frame, font, colors etc
        //adjustsFontSizeToFitWidth property to YES
        pickerLabel.minimumScaleFactor = 0.5;
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:15]];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

//-(NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
//    NSAttributedString *str = [[NSAttributedString alloc]initWithString:@"aaaaaaaaaaaaa" attributes:@{NSFontAttributeName:FontWS(9)}];
//    return str;
//}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 10;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
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
