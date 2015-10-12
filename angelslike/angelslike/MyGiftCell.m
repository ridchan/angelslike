//
//  MyGiftCell.m
//  angelslike
//
//  Created by angelslike on 15/10/10.
//  Copyright © 2015年 angelslike. All rights reserved.
//

#import "MyGiftCell.h"

@implementation MyGiftCell

- (void)awakeFromNib {
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addline:CGPointMake(0, 0) color:nil];
        dateLbl = [[UILabel alloc]initWithFrame:RECT(10, 0, ScreenWidth - 20, 30)];
        dateLbl.textColor = [UIColor lightGrayColor];
        [self addSubview:dateLbl];
        [self addline:CGPointMake(0, 30) color:nil];
        
        UIView *view = [[UIView alloc]initWithFrame:RECT(0, 30, ScreenWidth, 120)];
        view.backgroundColor = RGBA(241, 240, 246, 1.0);
        [self addSubview:view];

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTap:)];
        productImg = [[UIImageView alloc]initWithFrame:RECT(10, MaxY(dateLbl) + 10, 90, 90)];
        productImg.userInteractionEnabled =  YES;
        productImg.tag = CellActionType_Left;
        [productImg addGestureRecognizer:tap];

        [self addSubview:productImg];
        
        label = [[UILabel alloc]initWithFrame:RECT(self.frame.size.width - 60, MaxY(dateLbl) + 10, 50, 20)];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor lightGrayColor];
        label.font = FontWS(12);
        label.text = @"收礼人:";
        [self addSubview:label];
        
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTap:)];
        peopleImg = [[UIImageView alloc]initWithFrame:RECT(self.frame.size.width - 60, MaxY(label), 50, 50)];
        peopleImg.layer.cornerRadius = 25;
        peopleImg.layer.masksToBounds = YES;
        peopleImg.userInteractionEnabled = YES;
        peopleImg.tag = CellActionType_Right;
        [peopleImg addGestureRecognizer:tap2];
        [self addSubview:peopleImg];
        
        peopleLbl = [[UILabel alloc]initWithFrame:RECT(self.frame.size.width - 60, MaxY(peopleImg), 50, 40)];
        peopleLbl.textAlignment = NSTextAlignmentCenter;
        peopleLbl.font = FontWS(12);
        peopleLbl.numberOfLines = 2;
        [self addSubview:peopleLbl];
        
        
        nameLbl = [[UILabel alloc]initWithFrame:RECT(MaxX(productImg) + 10, MaxY(dateLbl) + 10, self.frame.size.width - 80 - MaxX(productImg), 80)];
        nameLbl.numberOfLines = 5;
        [self addSubview:nameLbl];
        
        priceLbl = [[UILabel alloc]initWithFrame:RECT(MaxX(productImg) + 10, MaxY(peopleImg), 80, 40)];
        priceLbl.textColor = HexColor(@"F94626");
        [self addSubview:priceLbl];
    }
    return self;
}


-(void)imageTap:(UITapGestureRecognizer *)tap{
    if ([tar respondsToSelector:act]) {
        self.isLeft = tap.view.tag == CellActionType_Left;
        [tar performSelector:act withObject:self];
    }
}

-(void)addTarget:(id)target action:(SEL)action{
    tar = target ;
    act = action ;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setType:(NSInteger)type{
    _type = type;
    label.text = type == 0?@"收礼人:":@"送礼人";
}

-(void)setInfo:(NSDictionary *)info{
    _info = info;
    dateLbl.text = [_info strForKey:@"time"];
    
    [productImg setPreImageWithUrl:[_info strForKey:@"pimg"]];
    
    [peopleImg setPreImageWithUrl:[_info strForKey:@"uimg"] placeHolderImage:@"null_user"];
    
    
    peopleLbl.text = [_info strForKey:@"uname"];
    if (_type == 0 & [[_info strForKey:@"uname"] length] == 0) peopleLbl.text = @"立即转发";
    
    nameLbl.text = [_info strForKey:@"pname"];
    
    CGRect rect = [nameLbl.text boundingRectWithSize:CGSizeMake(nameLbl.frame.size.width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:nameLbl.font} context:nil];
    nameLbl.frame  = ResizeHeight(nameLbl, rect.size.height);
    
    priceLbl.text = Format2(MoneySign, [_info strForKey:@"price"]);
    priceLbl.frame = ResizeY(priceLbl, MaxY(nameLbl));
}


@end
