//
//  CouDetail.m
//  angelslike
//
//  Created by angelslike on 15/8/13.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "CouDetail.h"
#define iconr 12
#define iconGap 3

@implementation DayLabel

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                       byRoundingCorners:UIRectCornerBottomRight | UIRectCornerTopRight
                                                             cornerRadii:CGSizeMake(10.0, 10.0)];
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.frame         = self.bounds;
        maskLayer.path          = maskPath.CGPath;
        self.layer.mask         = maskLayer;
    }
    
    return self;
}

@end

@implementation IconView

-(instancetype)initWithFrame:(CGRect)frame{
    if ( self = [super initWithFrame:frame]) {
        UIColor *color = RGBA(0, 0, 0, 0.6);
        
        self.backgroundColor = [UIColor clearColor];
        imgView1 = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width, 0, iconr, iconr)];
        imgView1.image = [[UIImage imageNamed:@"iconfont-wodexiangqingyanjing"] rt_tintedImageWithColor:color];
        imgView1.contentMode = UIViewContentModeScaleAspectFit;

        
        imgView2 = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width, 0, iconr, iconr)];
        imgView2.image = [[UIImage imageNamed:@"iconfont-fenxiang"] rt_tintedImageWithColor:color];
        imgView2.contentMode = UIViewContentModeScaleAspectFit;
        
        imgView3 = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width, 0, iconr, iconr)];
        imgView3.image = [[UIImage imageNamed:@"iconfont-zhuanfa"] rt_tintedImageWithColor:color];
        imgView3.contentMode = UIViewContentModeScaleAspectFit;
        
        label1 = [[UILabel alloc]initWithFrame:CGRectMake(frame.size.width, 0, iconr, iconr)];
        label1.backgroundColor = [UIColor clearColor];
        label1.textColor = color;
        label1.font = FontWS(9);
        
        label2 = [[UILabel alloc]initWithFrame:CGRectMake(frame.size.width, 0, iconr, iconr)];
        label2.backgroundColor = [UIColor clearColor];
        label2.textColor = color;
        label2.font = FontWS(9);
        
        label3 = [[UILabel alloc]initWithFrame:CGRectMake(frame.size.width, 0, iconr, iconr)];
        label3.backgroundColor = [UIColor clearColor];
        label3.textColor = color;
        label3.font = FontWS(9);
        
        [self addSubview:imgView1];
        [self addSubview:imgView2];
        [self addSubview:imgView3];
        [self addSubview:label1];
        [self addSubview:label2];
        [self addSubview:label3];
    }
    
    return self;
}

-(void)setFavitor:(NSString *)forward share:(NSString *)share views:(NSString *)views{
    CGSize size3 = [forward sizeWithAttributes:@{NSFontAttributeName:FontWS(9)}];
    CGSize size2 = [share sizeWithAttributes:@{NSFontAttributeName:FontWS(9)}];
    CGSize size1 = [views sizeWithAttributes:@{NSFontAttributeName:FontWS(9)}];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    label3.text = forward;
    label3.frame = CGRectMake(self.frame.size.width - size3.width, 0, size3.width, iconr);
    imgView3.frame = CGRectMake(label3.frame.origin.x - iconr - iconGap, 0, iconr, iconr);
    
    label2.text = share;
    label2.frame = CGRectMake(imgView3.frame.origin.x - size2.width - iconGap, 0, size2.width, iconr);
    imgView2.frame = CGRectMake(label2.frame.origin.x - iconr - iconGap, 0, iconr, iconr);
    
    label1.text = views;
    label1.frame = CGRectMake(imgView2.frame.origin.x - size1.width - iconGap, 0, size1.width,iconr);
    imgView1.frame = CGRectMake(label1.frame.origin.x - iconr - iconGap, 0, iconr, iconr);
    [UIView commitAnimations];
    
    
}

@end

@implementation CouDetail

@synthesize info = _info;

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        scView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        scView.backgroundColor = [UIColor whiteColor];
        scView.delegate = self;
        [self addSubview:scView];
        
        if (!imageView) {
            imageView =  [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 70, 70)];
            imageView.layer.cornerRadius = 35.0;
            imageView.layer.masksToBounds = YES;
            [scView addSubview:imageView];
        }
        
        if (!nameLabel) {
            nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 5, frame.size.width - 160, 30)];
            nameLabel.font = FontWS(14);
            nameLabel.backgroundColor = [UIColor clearColor];
            [scView addSubview:nameLabel];
        }
        
        if (!timeStartLabel) {
            timeStartLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 35, frame.size.width - 160, 20)];
            timeStartLabel.font = FontWS(11);
            timeStartLabel.backgroundColor = [UIColor clearColor];
            [scView addSubview:timeStartLabel];
        }
        
        if (!timeEndLabel) {
            timeEndLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 55, frame.size.width - 160, 20)];
            timeEndLabel.font = FontWS(11);
            timeEndLabel.backgroundColor = [UIColor clearColor];
            [scView addSubview:timeEndLabel];
        }
        
        
        
        if (!statuLabel) {
            statuLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth - 60 - CouCellMargin * 2, 50, 50, 22)];
            statuLabel.backgroundColor = [UIColor clearColor];
            statuLabel.font = FontWS(10);
            statuLabel.textAlignment = NSTextAlignmentCenter;
            statuLabel.textColor = [UIColor getHexColor:@"F88F19"];
            statuLabel.layer.borderWidth = 1;
            statuLabel.layer.masksToBounds = YES;
            statuLabel.layer.cornerRadius = 3;
            statuLabel.layer.borderColor = statuLabel.textColor.CGColor;
            [scView addSubview:statuLabel];
        }
        
        
        
        CALayer *line1 = [self lineLayer:CGPointMake(0, 80)];
        [scView.layer addSublayer:line1];
        
        
        
        targetLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 80, ScreenWidth / 3, 30)];
        targetLabel.font = FontWS(11);
        targetLabel.backgroundColor = [UIColor clearColor];
        targetLabel.textAlignment = NSTextAlignmentCenter;
        [scView addSubview:targetLabel];
        
        priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth / 3, 80, ScreenWidth / 3, 30)];
        priceLabel.backgroundColor = [UIColor clearColor];
        priceLabel.textAlignment = NSTextAlignmentCenter;
        priceLabel.font = FontWS(11);
        [scView addSubview:priceLabel];
        
        totalLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth / 3 * 2, 80, ScreenWidth / 3, 30)];
        totalLabel.backgroundColor = [UIColor clearColor];
        totalLabel.textAlignment = NSTextAlignmentCenter;
        totalLabel.font = FontWS(11);
        [scView addSubview:totalLabel];
        
        CALayer *line2 = [self lineLayer:CGPointMake(0, 110)];
        [scView.layer addSublayer:line2];
        
        iconView = [[IconView alloc]initWithFrame:CGRectMake(frame.size.width - 200, 5, 195, 20)];
        iconView.hidden = YES;
        [scView addSubview:iconView];
        
        
        //
        daylabel = [[DayLabel alloc] initWithFrame:CGRectMake(0, 120, 60, 30)];
        daylabel.backgroundColor = [UIColor getHexColor:@"ff6969"];
        daylabel.textColor = [UIColor whiteColor];
        daylabel.font = FontWS(14);
        daylabel.textAlignment = NSTextAlignmentCenter;
        [scView addSubview:daylabel];
        
        titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 120, frame.size.width - 85, 45)];
        titlelabel.backgroundColor = [UIColor clearColor];
        titlelabel.font = [UIFont boldSystemFontOfSize:15];
        titlelabel.numberOfLines = 2;
        [scView addSubview:titlelabel];
        //
        
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 160, frame.size.width , 1)];//frame.size.height - 160)];
        _webView.delegate = self;
        _webView.scalesPageToFit = NO;
        _webView.scrollView.scrollEnabled = NO;
        [scView addSubview:_webView];
        
        

        
        
        cp = [[CouProduct alloc]initWithFrame:CGRectMake(0, 165, frame.size.width, 1)];
        cp.hidden = YES;
        cp.delegate = self;
        [scView addSubview:cp];
        
        process = [[CouProcess alloc]initWithFrame:CGRectMake(0, 150, frame.size.width, 150)];
        [scView addSubview:process];
    }
    
    return self;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    imageView.center = CGPointMake(40, 104 + scrollView.contentOffset.y);
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    CGRect rect = webView.frame;

    NSString *htmlHeight = [webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"];
    webView.frame = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, [htmlHeight floatValue]);
    cp.frame = CGRectMake(cp.frame.origin.x, webView.frame.origin.y + webView.frame.size.height , cp.frame.size.width, cp.frame.size.height);
    process.frame = CGRectMake(process.frame.origin.x, cp.frame.origin.y + cp.frame.size.height, process.frame.size.width, process.frame.size.height);
    scView.contentSize = CGSizeMake(1, process.frame.origin.y + process.frame.size.height);

}

#pragma mark -
#pragma mark delegate

-(void)beResize:(CGRect)rect{
    [self webViewDidFinishLoad:_webView];
}

-(void)checkButtonClick:(id)sender{
    
}

#pragma mark -


-(NSMutableAttributedString *)setColorText:(NSString *)str range:(NSRange)range{
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:str];
    [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor getHexColor:@"ff6969"] range:range];
    return  attrString;
}


-(CAShapeLayer *)lineLayer:(CGPoint)position{
    CAShapeLayer *layer = [CAShapeLayer new];
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(ScreenWidth, 0)];
    
    
    layer.path = path.CGPath;
    layer.lineWidth = 0.5;
    layer.strokeColor = RGBA(178,177,182,.9).CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.position = position;
    return layer;
}

-(void)setInfo:(NSDictionary *)info{
    _info = [info mutableCopy];
    [imageView sd_setImageWithURL:[NSURL URLWithString:[_info strForKey:@"uimg"]]];
    nameLabel.text = [_info strForKey:@"uname"];
    timeStartLabel.text = [NSString stringWithFormat:@"开始时间:%@",[_info strForKey:@"starttime"]];
    timeEndLabel.text = [NSString stringWithFormat:@"结束时间:%@",[_info strForKey:@"endtime"]];
    statuLabel.text = [_info strForKey:@"nowstatus"];
    
    iconView.hidden = NO;
    [iconView setFavitor:[_info strForKey:@"forwarding"] share:[_info strForKey:@"share"] views:[_info strForKey:@"views"]];
    
    NSString *str1 = [NSString stringWithFormat:@"目标"];
    NSString *str2 = [NSString stringWithFormat:@"￥%0.2f元",[_info floatForKey:@"price"]];
    targetLabel.attributedText = [self setColorText:[NSString stringWithFormat:@"%@%@",str1,str2] range:NSMakeRange([str1 length] , [str2 length])];
    
    
    str1 = [NSString stringWithFormat:@"每份"];
    if ([_info floatForKey:@"copies"] > 0) {
        str2 = [NSString stringWithFormat:@"￥%0.2f元",[_info floatForKey:@"everyprice"]];// / [_info floatForKey:@"copies"]];
        priceLabel.attributedText = [self setColorText:[NSString stringWithFormat:@"%@%@",str1,str2] range:NSMakeRange([str1 length] , [str2 length])];
    }

    
    str1 = [NSString stringWithFormat:@"共 "];
    str2 = [NSString stringWithFormat:@"%@份",[_info strForKey:@"copies"]];
    totalLabel.attributedText = [self setColorText:[NSString stringWithFormat:@"%@%@",str1,str2] range:NSMakeRange([str1 length], [str2 length])];
    
    
    daylabel.text = [[[_info strForKey:@"outday"] stringByReplacingOccurrencesOfString:@"<font>" withString:@""] stringByReplacingOccurrencesOfString:@"</font>" withString:@""];
    titlelabel.text = [_info strForKey:@"title"];
    
    if ([_info intForKey:@"type"] == 1) {
        cp.hidden = NO;
        [cp setImg:[_info strForKey:@"pimg"] name:[_info strForKey:@"pname"]  price:[_info strForKey:@"pprice"]  content:[_info strForKey:@"pcontent"] ];
    }
    

    
    if ([[_info strForKey:@"content"] length] > 0) {
        NSMutableString *rss = [NSMutableString stringWithString:[_info strForKey:@"content"]];
        [self reSizeImage:rss];
        [_webView loadHTMLString:rss baseURL:[NSURL URLWithString:@"http://www.angelslike.com"]];
    }
    
    [process setTarget:[_info strForKey:@"copies"]
              complete:[_info strForKey:@"currentcopies"]
     ];
    
    
    
    
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
        
        if (imgStart.location != NSNotFound) {
            @try {
                curRange = NSMakeRange(loc, length - loc - 1);
                NSRange pngEnd = [result rangeOfString:@"png\"" options:NSCaseInsensitiveSearch range:curRange];
                NSRange jpgEnd = [result rangeOfString:@"jpg\"" options:NSCaseInsensitiveSearch range:curRange];
                if (pngEnd.location < jpgEnd.location) {
                    loc = pngEnd.location;
                    //                    length = length - imgEnd.location;
                    [arr addObject:[NSString stringWithFormat:@"%ld",pngEnd.location + 4] ]; // 4  为 jpg" 偏移量
                }else{
                    loc = jpgEnd.location;
                    //                    length = length - imgEnd.location;
                    [arr addObject:[NSString stringWithFormat:@"%ld",jpgEnd.location + 4] ]; // 4  为 jpg" 偏移量
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
