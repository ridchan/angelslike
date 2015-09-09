//
//  ValDayCell.m
//  angelslike
//
//  Created by angelslike on 15/9/8.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "ValDayCell.h"

@implementation ValDayCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        label = [[UILabel alloc]initWithFrame:RECT(10, 6, ScreenWidth - 20, 40)];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"有效天数";
        label.font = FontWS(14);
        label.textColor = HexColor(@"666666");
        
        
        
        [self addSubview:label];
        
        picker = [[PickerView alloc]initWithFrame:RECT(ScreenWidth - 70, 13.5, 60, 25)];
        picker.text = @"1";
        [picker addTarget:self action:@selector(dayClick:)];
//        textField =  [[UITextField alloc]initWithFrame:RECT(ScreenWidth - 70, 13.5, 60, 25)];
////        textField.backgroundColor = HexColor(@"");
////        textField.backgroundColor = HexColor(@"e5e5e5");
//        textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
//        textField.layer.borderWidth = 1.0;
//        textField.layer.masksToBounds = YES;
//        textField.layer.cornerRadius = 5;
//        [textField.layer addSublayer:[self shadowAsInverse]];
//        textField.rightViewMode = UITextFieldViewModeAlways;
//        UIImageView *img = [[UIImageView alloc]initWithFrame:RECT(0, 0, 20, 8)];
//        img.contentMode = UIViewContentModeScaleAspectFit;
//        img.image = IMAGE(@"arrow");
//        textField.rightView = img;
        
        [self addSubview:picker];
    }
    
    return self;
}

- (CAGradientLayer *)shadowAsInverse
{
    CAGradientLayer *newShadow = [[CAGradientLayer alloc] init] ;
    CGRect newShadowFrame = CGRectMake(0, 0, 60, 25);
    newShadow.frame = newShadowFrame;
    newShadow.cornerRadius = 5;
    newShadow.masksToBounds = YES;
    //添加渐变的颜色组合
    newShadow.colors = [NSArray arrayWithObjects:(id)HexColor(@"ffffff").CGColor,(id)HexColor(@"e5e5e5").CGColor,nil];
    return newShadow;
}


-(void)dayClick:(id)obj{
//    UIViewController *vc =  [self findViewController:self];
//    if ([vc respondsToSelector:@selector(valDayClick:)]) {
//        [vc performSelector:@selector(valDayClick:) withObject:self];
//    }
    
    SGPopSelectView *popView = [[SGPopSelectView alloc] init];
    popView.selections = @[@"1",@"3",@"7",@"10",@"16",@"24",@"30"];
    __weak SGPopSelectView *tempView = popView;
    popView.selectedHandle = ^(NSInteger selectedIndex){
        picker.text = popView.selections[selectedIndex];
        [tempView hide:NO];
    };
    
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    CGRect rect=[picker convertRect:picker.bounds toView:window];
    
    [popView showFromView:window atPoint:rect.origin animated:YES];
}





@end
