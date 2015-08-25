//
//  CouCell.m
//  angelslike
//
//  Created by angelslike on 15/8/6.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "CouCell.h"

@implementation CouCell

@synthesize info = _info;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        if (!bg) {
            bg = [[UIView alloc]initWithFrame:CGRectMake(CouCellMargin, 0, ScreenWidth - CouCellMargin * 2, CouCellHeight)];
            bg.layer.borderWidth = 0.5;
            bg.layer.borderColor = [UIColor getHexColor:@"e0e0e0"].CGColor;
            bg.backgroundColor = [UIColor whiteColor];
            [self addSubview:bg];
        }

        if (!imageView) {
            imageView = [[UIImageView alloc]initWithFrame:CGRectMake(CouCellMargin + 5, 15, 63, 63)];
            imageView.layer.cornerRadius = 5;
            imageView.layer.masksToBounds = YES;
            [self addSubview:imageView];
        }
        
        if (!companyLabel) {
            companyLabel = [[UILabel alloc]initWithFrame:CGRectMake(CouCellMargin + 5, 78, 63, 30)];
            companyLabel.backgroundColor = [UIColor clearColor];
            companyLabel.textAlignment = NSTextAlignmentCenter;
            companyLabel.font = FontWS(9);
            companyLabel.numberOfLines = 2;
            [self addSubview:companyLabel];
        }
        
        if (!nameLabel) {
            nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CouCellMargin + 75, 5, ScreenWidth - CouCellMargin * 2 - 75, 40)];
            nameLabel.backgroundColor = [UIColor clearColor];
            nameLabel.numberOfLines = 2;
            nameLabel.font = FontWS(14);
            [self addSubview:nameLabel];
        }
        
        if (!pnameLabel) {
            pnameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CouCellMargin + 75, 40, ScreenWidth - CouCellMargin * 2 - 75, 20)];
            pnameLabel.backgroundColor = [UIColor clearColor];
            pnameLabel.numberOfLines = 2;
            pnameLabel.font = FontWS(12);
            [self addSubview:pnameLabel];
        }
        
        if (!dayLabel) {
            dayLabel = [[UILabel alloc]initWithFrame:CGRectMake(CouCellMargin + 75, 70, ScreenWidth - CouCellMargin * 2 - 75, 20)];
            dayLabel.backgroundColor = [UIColor clearColor];
            dayLabel.font = FontWS(11);
            dayLabel.textColor = RGBA(0.0, 0.0, 0.0, 0.6);
            [self addSubview:dayLabel];
        }
        
        if (!targetLabel) {
            targetLabel = [[UILabel alloc]initWithFrame:CGRectMake(CouCellMargin + 75, 90, ScreenWidth - CouCellMargin * 2 - 75, 20)];
            targetLabel.backgroundColor = [UIColor clearColor];
            targetLabel.font = FontWS(11);
            targetLabel.textColor = RGBA(0.0, 0.0, 0.0, 0.6);
            [self addSubview:targetLabel];
        }
        
        if (!statuLabel) {
            statuLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth - 60 - CouCellMargin * 2, 80, 50, 22)];
            statuLabel.backgroundColor = [UIColor clearColor];
            statuLabel.font = FontWS(10);
            statuLabel.textAlignment = NSTextAlignmentCenter;
            statuLabel.textColor = [UIColor getHexColor:@"F88F19"];
            statuLabel.layer.borderWidth = 1;
            statuLabel.layer.masksToBounds = YES;
            statuLabel.layer.cornerRadius = 3;
            statuLabel.layer.borderColor = statuLabel.textColor.CGColor;
            [self addSubview:statuLabel];
        }
        
        if (!progress) {
            progress = [[UILabel alloc]initWithFrame:CGRectMake(0, bg.frame.size.height - 2, 0, 2)];
            progress.backgroundColor = [UIColor getHexColor:@"ff6969"];
            [bg addSubview:progress];
        }
        
        
    }
    return self;
}

-(void)setName:(NSString *)name andType:(NSString *)strType inLabel:(UILabel *)attrLabel{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@(%@)",name,strType]];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange([name length] ,[strType length] + 2)];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue" size:9.0] range:NSMakeRange([name length],[strType length] + 2)];
    attrLabel.attributedText = str;
}

-(void)setInfo:(NSDictionary *)info{
    _info = info;
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:[info strForKey:@"img"]]  placeholderImage:[UIImage imageNamed:@"hui_logo"]];
    
    companyLabel.text = [info strForKey:@"name"];
    nameLabel.text = [info strForKey:@"title"];
    pnameLabel.text = [NSString stringWithFormat:@"[凑什么]%@",[info strForKey:@"pname"]];

    NSString *price = [NSString stringWithFormat:@"%0.2f",[[info strForKey:@"price"] doubleValue] / [[info strForKey:@"copies"] doubleValue]];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"每份: %@ 元  %@",price,[info strForKey:@"outday"]]];
    NSRange range = NSMakeRange([@"每份: " length],[price length]);
    
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor getHexColor:@"FA9E47"] range:range];
    [str addAttribute:NSFontAttributeName value:FontWS(dayLabel.font.pointSize + 3) range:range];
    dayLabel.attributedText = str;
    
    targetLabel.text = [NSString stringWithFormat:@"目标 %@ 份 | 已凑 %@ 份",[info strForKey:@"copies"],[info strForKey:@"currentcopies"]];
    
    statuLabel.text = [info strForKey:@"status"];
    
    if ([[info strForKey:@"copies"] doubleValue] > 0) {
        CGFloat p = [[info strForKey:@"currentcopies"] doubleValue] / [[info strForKey:@"copies"] doubleValue] * bg.frame.size.width;
        
        progress.frame = CGRectMake(progress.frame.origin.x, progress.frame.origin.y, p, 2);
    }


}

@end
