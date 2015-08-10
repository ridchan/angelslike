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


-(void)setTextFieldAttribute:(UITextField *)textField img:(NSString *)imgName bottom:(BOOL)bottom{
    textField.borderStyle = UITextBorderStyleNone;
    textField.backgroundColor = [UIColor whiteColor];
    
    [textField.layer addSublayer:[self createBound:textField.frame bottom:bottom]];
    
    textField.leftViewMode = UITextFieldViewModeAlways;
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 32, 18)];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.image = [UIImage imageNamed:imgName];
    textField.leftView = imageView;
    
}

-(CAShapeLayer *)createBound:(CGRect)rect bottom:(BOOL)bottom{
    CAShapeLayer *layer = [CAShapeLayer new];
    
    UIBezierPath *path = [UIBezierPath new];
    if (bottom) {
        [path moveToPoint:CGPointMake(0,0)];
        [path addLineToPoint:CGPointMake(rect.size.width,0)];
        [path addLineToPoint:CGPointMake(rect.size.width,rect.size.height)];
        [path addLineToPoint:CGPointMake(0,rect.size.height)];
        [path addLineToPoint:CGPointMake(0,0)];
    }else{
        [path moveToPoint:CGPointMake(0,rect.size.height)];
        [path addLineToPoint:CGPointMake(0,0)];
        [path addLineToPoint:CGPointMake(rect.size.width,0)];
        [path addLineToPoint:CGPointMake(rect.size.width,rect.size.height)];
    }
    layer.backgroundColor = [UIColor clearColor].CGColor;
    layer.path = path.CGPath;
    layer.lineWidth = 1.0;
    layer.strokeColor = [UIColor lightGrayColor].CGColor;
    
    layer.path = path.CGPath;
    layer.fillColor = [UIColor clearColor].CGColor;
    
    return layer;
}

@end
