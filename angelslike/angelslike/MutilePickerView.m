//
//  MutilePickerView.m
//  angelslike
//
//  Created by angelslike on 15/9/17.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "MutilePickerView.h"
#define TagOff  5566

@implementation MutilePickerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.result = [NSMutableDictionary dictionary];
    }
    return self;
}

-(void)setItems:(NSArray *)items{
    _items = items;
    CGFloat gap = 5;
    CGFloat width =  (self.frame.size.width - ([_items count] - 1) * gap) / [_items count];
    for (int i = 0 ; i < [_items count] ; i ++){
        PickerView *pk = (PickerView *) [self viewWithTag:TagOff + i];
        if (pk == nil){
            pk = [[PickerView alloc]initWithFrame:RECT((width + gap) * i , gap, width, self.frame.size.height - gap * 2)];
            pk.tag = TagOff + i ;
            [pk addTarget:self action:@selector(addressSelect:)];
            [self addSubview:pk];
        }
        pk.text = [items objectAtIndex:i];

    }
}

-(void)setKeys:(NSArray *)keys{
    _keys = keys;
    for(NSString *key in keys){
        id address = [UserDefault objectForKey:key];
        if (!address){
            [[NetWork shared]query:AddressUrl info:@{@"type":key} block:^(id Obj) {
                id newAddress = [Obj objectForKey:@"data"];
                [UserDefault setObject:newAddress forKey:key];
            } lock:NO];
        }
    }
}

-(NSMutableDictionary *)result{
     NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (int i  = 0 ;  i  < [self.keys count] ; i ++){
        PickerView *pk = (PickerView *) [self viewWithTag:TagOff + i];
        [dic setObject:pk.text forKey:self.keys[i]];
    }
    return dic;
}

-(void)addressSelect:(PickerView *)pk{
    
    NSInteger idx = pk.tag - TagOff;
    NSString *type = [self.keys objectAtIndex:idx];
    
    id address = [UserDefault objectForKey:type];

    if (pk.tag == TagOff ){
        [self showSelection:address picker:pk];
    }else{
        PickerView *pk1 = (PickerView *)[self viewWithTag:pk.tag - 1];
        NSArray *newArr = [address objectForKey:pk1.text];
        [self showSelection:newArr picker:pk];
    }
}

-(void)setDefaultFromTag:(NSInteger)tag{
    for (int i = (int)(tag - TagOff) + 1 ; i < [self.items count] ; i ++){
        [self setDefaultWithTag:i + TagOff];
    }
}


-(void)setDefaultWithTag:(NSInteger)tag{
    if (tag > TagOff){
        PickerView *lpk = (PickerView *) [self viewWithTag:tag - 1];
        PickerView *pk = (PickerView *) [self viewWithTag:tag];
        id address = [[UserDefault objectForKey:self.keys[tag - TagOff]] objectForKey:lpk.text];
        if (address)
            pk.text = address[0];
        else
            pk.text = @"";
    }

}

-(UIView *)GetSuperView:(UIView *)view{
    UIView *sup = [view superview];
    if (![sup isKindOfClass:[UIWindow class]] && sup) {
        return [self GetSuperView:sup];
    }else{
        return view;
    }
}

-(void)showSelection:(NSArray *)arr picker:(PickerView *)pk{
        
    
    if (!popView)
        popView = [[SGPopSelectView alloc] init];
    popView.selections = arr;
    __block SGPopSelectView *tempView = popView;
    __block MutilePickerView *tempSelf = self;
    popView.selectedHandle = ^(NSInteger selectedIndex){
        pk.text = tempView.selections[selectedIndex];
        [tempSelf setDefaultFromTag:pk.tag];
        [tempView hide:NO];
    };
    

    UIViewController *vc = [self findViewController:self];
    CGRect rect=[pk convertRect:pk.bounds toView:vc.view];
    
    [popView showFromView:vc.view atPoint:CGPointMake(CGRectGetMinX(rect), CGRectGetMaxY(rect)) animated:YES];

}

@end
