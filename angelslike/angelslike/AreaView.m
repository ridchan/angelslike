//
//  AreaView.m
//  angelslike
//
//  Created by angelslike on 15/8/26.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "AreaView.h"

@implementation AreaView

-(instancetype)init{
    if (self = [super initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 162 + 44)]) {
        self.backgroundColor = [UIColor whiteColor];
        picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, ScreenWidth, 162)];
        picker.delegate = self;
        picker.dataSource = self;
        
        [self addSubview:picker];
        toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
        UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleBordered target:self action:@selector(finishButtonClick:)];
        
        UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        spaceItem.width = 250;
        toolbar.items = @[spaceItem,buttonItem];
        [self addSubview:toolbar];
        
        [self getData];
    }
    return self;
}

-(void)getData{
    
    __block AreaView *tempView = self;
    [[NetWork shared]query:AddressUrl info:@{@"type":@"pro"} block:^(id Obj) {
        tempView.pros = [Obj objForKey:@"data"];
        [picker reloadAllComponents];
    } lock:NO];
    
    [[NetWork shared]query:AddressUrl info:@{@"type":@"city"} block:^(id Obj) {
        tempView.citys = [Obj objForKey:@"data"];
        [picker reloadComponent:1];
    } lock:NO];
    
    [[NetWork shared]query:AddressUrl info:@{@"type":@"dis"} block:^(id Obj) {
        tempView.areas = [Obj objForKey:@"data"];
        [picker reloadComponent:2];
    } lock:NO];
}

-(void)show{
    [self.superview bringSubviewToFront:self];
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = CGRectMake(0, ScreenHeight - self.frame.size.height, ScreenWidth, self.frame.size.height);
    }];
}

-(void)finishButtonClick:(id)sender{
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = CGRectMake(0, ScreenHeight, ScreenWidth, self.frame.size.height);
    } completion:^(BOOL finished) {

    }];
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {

        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        [pickerView selectRow:0 inComponent:2 animated:YES];
    }else if(component == 1){
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];
    }else{
        
    }
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *title = nil;
    NSInteger idx = 0;
    
    switch (component) {
        case 0:
            return [self.pros objectAtIndex:row];
            break;
        case 1:
            idx = [pickerView selectedRowInComponent:0];
            title = [self pickerView:picker titleForRow:idx forComponent:0];
            return [[self.citys objectForKey:title] objectAtIndex:row];
            break;
        case 2:
            idx = [pickerView selectedRowInComponent:1];
            title = [self pickerView:picker titleForRow:idx forComponent:1];
            return [[self.areas objectForKey:title] objectAtIndex:row];
            break;
        default:
            return nil;
            break;
    }
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
    NSString *title = nil;
    NSInteger idx = 0;
    switch (component) {
        case 0:
            return [self.pros count];
            break;
        case 1:
            idx = [pickerView selectedRowInComponent:0];
            title = [self pickerView:picker titleForRow:idx forComponent:0];
            return [[self.citys objectForKey:title] count];
            break;
        case 2:
            idx = [pickerView selectedRowInComponent:1];
            title = [self pickerView:picker titleForRow:idx forComponent:1];
            return [[self.areas objectForKey:title] count];
            break;
        default:
            return 0;
            break;
    }
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

@end
