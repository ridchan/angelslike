//
//  CouRecrodCell.m
//  angelslike
//
//  Created by angelslike on 15/9/7.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "CouRecrodCell.h"

@implementation CouRecrodCell

- (void)awakeFromNib {
    // Initialization code
}

@synthesize info = _info;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //
        backView = [[UIView alloc]initWithFrame:CGRectMake(0, 5, self.frame.size.width, 80)];
        backView.backgroundColor = [UIColor whiteColor];
        [self addSubview:backView];
        
        self.backgroundColor = [UIColor clearColor];
        imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 40, 40)];
        imageView.layer.cornerRadius = 20;
        imageView.layer.masksToBounds = YES;
        [self addSubview:imageView];
        
        nameLabel =  [[UILabel alloc]initWithFrame:CGRectMake(60, 15, 200, 20)];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.font = FontWS(14);
        [self addSubview:nameLabel];
        
        dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 40, 200, 10)];
        dateLabel.backgroundColor = [UIColor clearColor];
        dateLabel.textColor = HexColor(@"7B7B7B");
        dateLabel.font = FontWS(9);
        [self addSubview:dateLabel];
        
        commentLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 55, 250, 20)];
        commentLabel.font = FontWS(14);
        commentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        commentLabel.numberOfLines = 99;
        [self addSubview:commentLabel];

        
        
        qtylabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, 310, 20)];
        qtylabel.backgroundColor = [UIColor clearColor];
        qtylabel.textAlignment = NSTextAlignmentRight;
        qtylabel.font = FontWS(12);
        [self addSubview:qtylabel];
        
        r1 = [[ReplayView alloc]initWithFrame:CGRectMake(10, 80, self.frame.size.width - 20, 0)];
        [self addSubview:r1];
        
        r2 = [[ReplayView alloc]initWithFrame:CGRectMake(10, 80, self.frame.size.width - 20, 0)];
        [self addSubview:r2];
        
        
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        UIImageView *img1 = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width - 115, 15, 40, 20)];
        [img1 addGestureRecognizer:tap1];
        img1.tag = CouCellType_Comment;
        img1.image = [[UIImage imageNamed:@"iconfont-pinglun"] rt_tintedImageWithColor:HexColor(@"797979")];
        img1.userInteractionEnabled = YES;
        img1.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:img1];
        
        reviewLbl = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width - 75, 15, 20, 20)];
        reviewLbl.backgroundColor = [UIColor clearColor];
        reviewLbl.font = FontWS(11);
        reviewLbl.text = @"0";
        reviewLbl.textColor = HexColor(@"797979");
        [self addSubview:reviewLbl];
        
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        UIImageView *img2 = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width - 60  , 15, 40, 20)];
        [img2 addGestureRecognizer:tap2];
        img2.tag = CouCellType_Praise;
        img2.image = [[UIImage imageNamed:@"iconfont-dianzan"] rt_tintedImageWithColor:HexColor(@"797979")];
        img2.userInteractionEnabled = YES;
        img2.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:img2];
        
        pariseLbl = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width - 20 - 5 , 15, 20, 20)];
        pariseLbl.backgroundColor = [UIColor clearColor];
        pariseLbl.font = FontWS(11);
        pariseLbl.text = @"0";
        pariseLbl.textColor = HexColor(@"797979");
        [self addSubview:pariseLbl];
        
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [button setTitle:@"查看更多" forState:UIControlStateNormal];
        button.frame = CGRectMake(self.frame.size.width - 80, 0, 60, 30);
        [button addTarget:self action:@selector(showMore:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = FontWS(13);
        button.hidden = YES;
        button.tag = CouCellType_More;
        [self addSubview:button];
        
    }
    
    return self;
}

-(void)showMore:(UIButton *)b{
    if ([tar respondsToSelector:act]) {
        [tar performSelector:act withObject:b];
    }
}

-(void)tap:(UIGestureRecognizer *)gesture{
    if ([tar respondsToSelector:act]) {
        [tar performSelector:act withObject:[gesture view]];
    }
}

-(void)addTarget:(id)target action:(SEL)action{
    tar = target;
    act = action;
}

-(void)setInfo:(NSDictionary *)info{
    _info = nil;
    _info = info;
    r1.hidden = YES;
    r2.hidden = YES;
    button.hidden = YES;
    if (_info) {
        
        NSString *qty = [NSString stringWithFormat:@"%@份 ",[_info strForKey:@"copies"]];
        NSString *price = [NSString stringWithFormat:@"￥%@  ",[_info strForKey:@"price"]];
        
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",qty,price]];
        
        
        [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor getHexColor:@"F44236"] range:NSMakeRange([qty length], [price length])];
        [attrString addAttribute:NSFontAttributeName value:FontWS(14) range:NSMakeRange([qty length], [price length])];
        qtylabel.attributedText = attrString;
        
        
        [imageView setPreImageWithUrl:[_info strForKey:@"uimg"] domain:MainUrl];
        nameLabel.text = [_info strForKey:@"uname"];
        dateLabel.text = [_info strForKey:@"time"];
        commentLabel.text = [_info strForKey:@"content"];
        reviewLbl.text = [_info strForKey:@"review"];
        pariseLbl.text = [_info strForKey:@"praise"];
        CGRect rect = [commentLabel.text boundingRectWithSize:CGSizeMake(commentLabel.frame.size.width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:commentLabel.font} context:nil];
        
        commentLabel.frame = CGRectMake(commentLabel.frame.origin.x, commentLabel.frame.origin.y, commentLabel.frame.size.width, rect.size.height + 5);
        
        
        
        CGRect subRect = commentLabel.frame;
        NSArray *arr = [_info objectForKey:@"comment_list"];
        if ([arr count] > 0) {
            
            r1.frame = CGRectMake(r1.frame.origin.x, commentLabel.frame.origin.y + commentLabel.frame.size.height, r1.frame.size.width, r1.frame.size.height);
            r1.info = arr[0];
            subRect = r1.frame;
            r1.hidden = NO;
            
        }
        if ([arr count] > 1) {
            
            r2.frame = CGRectMake(r2.frame.origin.x, r1.frame.origin.y + r1.frame.size.height, r2.frame.size.width, r2.frame.size.height);
            r2.info = arr[1];
            subRect = r2.frame;
            r2.hidden = NO;
            
        }
        
        if ([arr count] > 2) {
            button.frame = CGRectMake(button.frame.origin.x, r2.frame.origin.y + r2.frame.size.height, button.frame.size.width, button.frame.size.height);
            
            button.hidden = NO;
            subRect = button.frame;
        }
        
        backView.frame = CGRectMake(0, 0, backView.frame.size.width ,subRect.origin.y + subRect.size.height + 5);
        
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, backView.frame.origin.y + backView.frame.size.height);


    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
