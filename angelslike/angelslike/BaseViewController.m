//
//  BaseViewController.m
//  angelslike
//
//  Created by angelslike on 15/8/6.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "BaseViewController.h"

@implementation BaseViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor getHexColor:@"F1F0F6"];
}

-(void)hideTabBar{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hideCustomTabBar" object:nil];
}

-(void)showTabbar{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"bringCustomTabBarToFront" object:nil];
}


- (NSMutableAttributedString *)filterLinkWithContent:(NSString *)content {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:content];
    NSError *error = NULL;
    NSDataDetector *detector =
    [NSDataDetector dataDetectorWithTypes:(NSTextCheckingTypes)NSTextCheckingTypeLink | NSTextCheckingTypePhoneNumber
                                    error:&error];
    NSArray *matches = [detector matchesInString:content
                                         options:0
                                           range:NSMakeRange(0, [content length])];
    for (NSTextCheckingResult *match in matches) {
        
        if (([match resultType] == NSTextCheckingTypeLink)) {
            
            NSURL *url = [match URL];
            [attributedString addAttribute:NSLinkAttributeName value:url range:match.range];
        }
    }
    return attributedString;
}

-(void)showMessage:(NSString *)msg{
    UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alterView show];
}


-(void)setTextFieldAttribute:(UITextField *)textField img:(NSString *)imgName bottom:(NSInteger)txtType{
    textField.borderStyle = UITextBorderStyleNone;
    textField.backgroundColor = [UIColor whiteColor];

//    CAShapeLayer *maskLayer = [CAShapeLayer layer];
//    maskLayer.path = [bezierPath CGPath];
//    maskLayer.fillColor = [[UIColor whiteColor] CGColor];
//    maskLayer.frame = textField.frame;
//    textField.layer.mask = maskLayer;
    
//    CALayer *layer = [self createBound:textField.frame bottom:txtType];
//    layer.backgroundColor = textField.backgroundColor.CGColor;
//    textField.layer.mask = [self createBound:textField.frame bottom:txtType];
    
    [textField.layer addSublayer:[self createBound:textField.frame bottom:txtType]];
    
    textField.leftViewMode = UITextFieldViewModeAlways;
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 32, 18)];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.image = [UIImage imageNamed:imgName];
    textField.leftView = imageView;
    
}

-(CAShapeLayer *)createFrame:(CGRect)rect bottom:(NSInteger)txtType{
    CAShapeLayer *layer = [CAShapeLayer new];
    static float conner = 10;
    UIBezierPath *path = [UIBezierPath new];
    if (txtType == 0) {
        // 第一个
        [path moveToPoint:CGPointMake(0,rect.size.height)];
        [path addLineToPoint:CGPointMake(0,conner)];
        [path addArcWithCenter:CGPointMake(conner, conner) radius:conner startAngle:M_PI endAngle:M_PI * 1.5 clockwise:YES];
        [path addLineToPoint:CGPointMake(rect.size.width - conner,0)];
        [path addArcWithCenter:CGPointMake(rect.size.width - conner, conner) radius:conner startAngle:-M_PI_2 endAngle:0 clockwise:YES];
        [path addLineToPoint:CGPointMake(rect.size.width,rect.size.height)];
        [path addLineToPoint:CGPointMake(0,rect.size.height)];
        
    }else if (txtType == 1){
        //中间
        
        [path moveToPoint:CGPointMake(0,0)];
        [path addLineToPoint:CGPointMake(0,rect.size.height)];
        [path moveToPoint:CGPointMake(rect.size.width,0)];
        [path addLineToPoint:CGPointMake(rect.size.width,rect.size.height)];
        [path addLineToPoint:CGPointMake(0,rect.size.height)];
        
    }else{
        //底部
        
        //        [path moveToPoint:CGPointMake(0,0)];
        [path moveToPoint:CGPointMake(rect.size.width,0)];
        [path addLineToPoint:CGPointMake(rect.size.width,rect.size.height - conner)];
        
        [path addArcWithCenter:CGPointMake(rect.size.width - conner,rect.size.height - conner) radius:conner startAngle:0 endAngle:M_PI_2 clockwise:YES];
        
        [path addLineToPoint:CGPointMake(conner,rect.size.height)];
        
        [path addArcWithCenter:CGPointMake(conner,rect.size.height - conner) radius:conner startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
        [path addLineToPoint:CGPointMake(0,0)];
        
    }
    layer.path = path.CGPath;
    layer.fillColor = [[UIColor whiteColor] CGColor];
    layer.frame = rect;
    
    return layer;
}

-(CAShapeLayer *)createBound:(CGRect)rect bottom:(NSInteger)txtType{
    CAShapeLayer *layer = [CAShapeLayer new];
    static float conner = 5;
    UIBezierPath *path = [UIBezierPath new];
    if (txtType == 0) {
        // 第一个
        [path moveToPoint:CGPointMake(0,rect.size.height)];
        [path addLineToPoint:CGPointMake(0,conner)];
        [path addArcWithCenter:CGPointMake(conner, conner) radius:conner startAngle:M_PI endAngle:M_PI * 1.5 clockwise:YES];
        [path addLineToPoint:CGPointMake(rect.size.width - conner,0)];
        [path addArcWithCenter:CGPointMake(rect.size.width - conner, conner) radius:conner startAngle:-M_PI_2 endAngle:0 clockwise:YES];
        [path addLineToPoint:CGPointMake(rect.size.width,rect.size.height)];
        [path addLineToPoint:CGPointMake(0,rect.size.height)];

    }else if (txtType == 1){
        //中间

        [path moveToPoint:CGPointMake(0,0)];
        [path addLineToPoint:CGPointMake(0,rect.size.height)];
        [path moveToPoint:CGPointMake(rect.size.width,0)];
        [path addLineToPoint:CGPointMake(rect.size.width,rect.size.height)];
        [path addLineToPoint:CGPointMake(0,rect.size.height)];
        
    }else{
        //底部
        
//        [path moveToPoint:CGPointMake(0,0)];
        [path moveToPoint:CGPointMake(rect.size.width,0)];
        [path addLineToPoint:CGPointMake(rect.size.width,rect.size.height - conner)];
        
        [path addArcWithCenter:CGPointMake(rect.size.width - conner,rect.size.height - conner) radius:conner startAngle:0 endAngle:M_PI_2 clockwise:YES];
        
        [path addLineToPoint:CGPointMake(conner,rect.size.height)];
        
        [path addArcWithCenter:CGPointMake(conner,rect.size.height - conner) radius:conner startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
        [path addLineToPoint:CGPointMake(0,0)];
        
    }
    layer.backgroundColor = [UIColor clearColor].CGColor;
    layer.path = path.CGPath;
    layer.lineWidth = 1.0;
    layer.strokeColor = [UIColor lightGrayColor].CGColor;
    
    layer.path = path.CGPath;
    layer.fillColor = [UIColor clearColor].CGColor;
    
    return layer;
}


-(void)reSizeImage:(NSMutableString *)result{
    BOOL find = YES;
    NSInteger loc = 0;
    NSInteger length = [result length];
    NSMutableArray *arr = [NSMutableArray array];
    NSRange curRange;
    while (find) {
        curRange = NSMakeRange(loc, length - loc - 1);
        NSRange imgStart = [result rangeOfString:@"<img" options:NSCaseInsensitiveSearch range:curRange];
        loc = imgStart.location;
        //        length = length - imgStart.location;
        
        if (imgStart.location != NSNotFound) {
            @try {
                curRange = NSMakeRange(loc, length - loc - 1);
                NSRange pngEnd = [result rangeOfString:@"png\"" options:NSCaseInsensitiveSearch range:curRange];
                NSRange jpgEnd = [result rangeOfString:@"jpg\"" options:NSCaseInsensitiveSearch range:curRange];
                if (pngEnd.location < jpgEnd.location) {
                    loc = pngEnd.location;
                    //                    length = length - imgEnd.location;
                    [arr addObject:[NSString stringWithFormat:@"%d",pngEnd.location + 4] ]; // 4  为 jpg" 偏移量
                }else{
                    loc = jpgEnd.location;
                    //                    length = length - imgEnd.location;
                    [arr addObject:[NSString stringWithFormat:@"%d",jpgEnd.location + 4] ]; // 4  为 jpg" 偏移量
                }
 
                
            }
            @catch (NSException *exception) {
                NSLog(@"exception %@",exception);
                find = NO;
            }
        }else{
            find = NO;
        }
        
    }
    NSString *add = [NSString stringWithFormat:@" width=\"100%%\""];
    NSUInteger offset = 0;
    for (NSString *lc in arr){
        [result insertString:add
                     atIndex:[lc integerValue] + offset ];
        offset += [add length];
    }
    
}

@end
