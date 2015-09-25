//
//  ProductDetail.m
//  angelslike
//
//  Created by angelslike on 15/8/25.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "ProductDetail.h"

@implementation ProductDetail

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.width  * 9 / 16)];
        [self addSubview:imageView];
        
        namelabel = [[UILabel alloc]initWithFrame:CGRectMake(10, MaxY(imageView), frame.size.width - 20, 30)];
        namelabel.backgroundColor = [UIColor clearColor];
        [self addSubview:namelabel];
        
        pricelabel = [[UILabel alloc]initWithFrame:CGRectMake(10, MaxY(namelabel) , frame.size.width - 20, 30)];
        pricelabel.backgroundColor = [UIColor clearColor];
        pricelabel.textColor = HexColor(@"f44236");
        pricelabel.font = FontWS(23);
        [self addSubview:pricelabel];
        
        
        lbl1 = [[UILabel alloc]initWithFrame:CGRectMake(10, MaxY(namelabel) , frame.size.width - 20, 30)];
        lbl1.backgroundColor = [UIColor clearColor];
        lbl1.textAlignment = NSTextAlignmentRight;
        lbl1.textColor = HexColor(@"f44236");
        lbl1.font = FontWS(15);
        [self addSubview:pricelabel];
        
        lbl2 = [[UILabel alloc]initWithFrame:CGRectMake(10, MaxY(pricelabel) , frame.size.width - 20, 30)];
        lbl2.backgroundColor = [UIColor clearColor];
        lbl2.textColor = HexColor(@"333333");
        lbl2.font = FontWS(13);
        [self addSubview:lbl2];
        
        lbl3 = [[UILabel alloc]initWithFrame:CGRectMake(10, MaxY(lbl2) , frame.size.width - 20, 30)];
        lbl3.backgroundColor = [UIColor clearColor];
        lbl3.textColor = HexColor(@"333333");
        lbl3.font = FontWS(13);
        [self addSubview:lbl3];
        
        
        content = [[UIWebView alloc]initWithFrame:CGRectMake(10, MaxY(lbl3) , frame.size.width - 20, 30)];
        content.scrollView.scrollEnabled = NO;
        content.delegate = self;
        [self addSubview:content];
    }
    
    return self;
}

-(void)setInfo:(NSDictionary *)info{
    
    NSInteger showType = [info intForKey:@"show"];
    
    [imageView setPreImageWithUrl:[info strForKey:@"img"]];
    namelabel.text = [info strForKey:@"name"];
    
    NSString *price = [NSString stringWithFormat:@"￥%@",[info strForKey:@"price"]];
    NSString *oldprice = [NSString stringWithFormat:@"￥%@",[info strForKey:@"otherprice"]];
    NSString *stock = [NSString stringWithFormat:@"剩余:%.0f",[info floatForKey:@"stock"]];
    
    NSString *temp = @"";
    NSString *desc = @"";
    
    switch (showType) {
        case 0:
            
            break;
        case 1:
            desc = @" 包邮";
            break;
        case 2:
            desc = @" /2件 包邮(3-5天发货)";
            lbl1.text = @"现正特价: 买一送一";
            break;
        case 3:
            desc = [NSString stringWithFormat:@"  免税 原价: %@  含税",oldprice];
            temp = Format2(price, @"  免税 原价: ");
            break;
        default:
            break;
    }
    
    if (showType == 0){
        pricelabel.text = price;
    }else{
        NSMutableAttributedString *priceString = [[NSMutableAttributedString alloc]initWithString:Format2(price, desc)];
        [priceString addAttribute:NSFontAttributeName value:FontWS(13) range:NSMakeRange([price length], [desc length])];
        [priceString addAttribute:NSForegroundColorAttributeName value:HexColor(@"6A6A6A") range:NSMakeRange([price length], [desc length])];
        if ([temp length] > 0)
            [priceString addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange([temp length], [oldprice length])];
        pricelabel.attributedText = priceString;
    }
    
    if (showType == 1 || showType == 2){
        NSString *disPrice = Format2(MoneySign, [info strForKey:@"otherprice"]);
        NSMutableAttributedString *disString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"原价: %@   %@折",disPrice,[info strForKey:@"discount"]]];
        [disString addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange([@"原价: " length], [disPrice length])];
        lbl2.attributedText = disString;
        
        lbl3.text = stock;
    }else{
        content.frame = RECT(10, MaxY(pricelabel) , CGRectGetWidth(content.frame), 30);
    }
    
    
    [content loadHTMLString:[info strForKey:@"content"] baseURL:[NSURL URLWithString:MainUrl]];
    

}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= 'gray'"];
    
    CGRect rect = webView.frame;
    
    NSString *htmlHeight = [webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"];
    webView.frame = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, [htmlHeight floatValue]);
    self.frame = CGRectMake(self.frame.origin.x,self.frame.origin.y , self.frame.size.width,  webView.frame.origin.y + webView.frame.size.height);
}

@end
