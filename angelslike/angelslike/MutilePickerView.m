//
//  MutilePickerView.m
//  angelslike
//
//  Created by angelslike on 15/9/17.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "MutilePickerView.h"
#define TagOff  5566
#define ViewTag 9875

@implementation MutilePickerView

static const char tableViewDataSource;
static const char tableViewDataSourceTag;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark -
#pragma tableView


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger tag = [self tableviewDataSourceTag];
    [self setText:[self tableviewDataSource][indexPath.row] tag:[self tableviewDataSourceTag]];
    [self setDefaultFromTag:[self tableviewDataSourceTag]];
    
    if (tag < self.keys.count - 1){
        PickerView *pk = (PickerView *)[self viewWithTag:tag + 1 + TagOff];
        [self addressSelect:pk];
    }else{
        [self dismissSelectTable];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self tableviewDataSource] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"cell";
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.textLabel.text = [self tableviewDataSource][indexPath.row];
    cell.accessoryType = [cell.textLabel.text isEqualToString:[self getText:[self tableviewDataSourceTag]]]?UITableViewCellAccessoryCheckmark:UITableViewCellAccessoryNone;
    return cell;
}

-(void)showSelectTable{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (![window viewWithTag:ViewTag]){
        [window addSubview:_tbView];
        _toolView.transform = CGAffineTransformMakeTranslation(0, _tableView.frame.size.height);
        _tableView.transform = CGAffineTransformMakeTranslation(0, _tableView.frame.size.height);
        [UIView animateWithDuration:0.35 animations:^{
            _toolView.transform = CGAffineTransformMakeTranslation(0, 0);
            _tableView.transform = CGAffineTransformMakeTranslation(0, 0);
        } completion:^(BOOL finished) {
            
        }];
    }
    [_tableView reloadData];
    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:NO];
    
    
    
}



-(void)dismissSelectTable{
    [UIView animateWithDuration:0.35 animations:^{
        _toolView.transform = CGAffineTransformMakeTranslation(0, _tableView.frame.size.height);
        _tableView.transform = CGAffineTransformMakeTranslation(0, _tableView.frame.size.height);
    } completion:^(BOOL finished) {
        
        [_tbView removeFromSuperview];
    }];
    
}

-(id)tableviewDataSource{
    return objc_getAssociatedObject(_tableView, &tableViewDataSource);
}

-(void)setTableViewDataSource:(id)obj{
    objc_setAssociatedObject(_tableView, &tableViewDataSource, obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSInteger)tableviewDataSourceTag{
    return [objc_getAssociatedObject(_tableView, &tableViewDataSourceTag) integerValue];
}

-(void)setTableViewDataSourceTag:(NSInteger)obj{
    objc_setAssociatedObject(_tableView, &tableViewDataSourceTag, [NSNumber numberWithInteger:obj], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


#pragma mark -

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.result = [NSMutableDictionary dictionary];
        _tbView = [[UIView alloc]initWithFrame:RECT(0, 0, ScreenWidth, ScreenHeight)];
        _tbView.backgroundColor = RGBA(0, 0, 0, 0.5);
        _tbView.tag = ViewTag;
        
        _toolView = [[UIView alloc]initWithFrame:RECT(0, ScreenHeight - 250 - 44, ScreenWidth, 44)];
        _toolView.backgroundColor = HexColor(@"F1F0F6");
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = RECT(ScreenWidth - 60 , 7, 50, 30);
        [button setTitle:@"完成" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(cancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_toolView addSubview:button];
        
        _tableView = [[UITableView alloc]initWithFrame:RECT(0, ScreenHeight - 250, ScreenWidth, 250) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tbView addSubview:_toolView];
        [_tbView addSubview:_tableView];
    }
    return self;
}

-(void)cancelButtonClick:(id)sender{
    [self dismissSelectTable];
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
        [dic setObject:[self getText:i] forKey:self.keys[i]];
    }
    return dic;
}

-(void)addressSelect:(PickerView *)pk{
    
    NSInteger idx = pk.tag - TagOff;
    NSString *type = [self.keys objectAtIndex:idx];
    id address = [UserDefault objectForKey:type];

    if (pk.tag == TagOff){
        if ([address count] > 0)
            [self showSelection:address tag:0];
    }else{
        NSArray *newArr = [address objectForKey:[self getText:idx - 1]];
        if ([newArr count] > 0)
            [self showSelection:newArr tag:idx];
    }
}

-(void)setDefaultFromTag:(NSInteger)tag{
    for (int i = (int)tag + 1 ; i < [self.items count] ; i ++){
        [self setDefaultWithTag:i];
    }
}


-(void)setDefaultWithTag:(NSInteger)tag{
    if (tag > 0){
        id address = [[UserDefault objectForKey:self.keys[tag]] objectForKey:[self getText:tag - 1]];
        if ([address count] > 0)
            [self setText:address[0] tag:tag];
        else
            [self setText:@"" tag:tag];
    }
}

-(void)setText:(NSString *)text tag:(NSInteger )tag{
    PickerView *pk = (PickerView *) [self viewWithTag:tag + TagOff];
    pk.text = text;
}

-(NSString *)getText:(NSInteger)tag{
    PickerView *pk = (PickerView *) [self viewWithTag:tag + TagOff];
    return pk.text;
}

-(UIView *)GetSuperView:(UIView *)view{
    UIView *sup = [view superview];
    if (![sup isKindOfClass:[UIWindow class]] && sup) {
        return [self GetSuperView:sup];
    }else{
        return view;
    }
}

-(void)showSelection:(NSArray *)arr tag:(NSInteger)tag{
    
    [self setTableViewDataSource:arr];
    [self setTableViewDataSourceTag:tag];
    [self showSelectTable];
}

-(void)showSelection:(NSArray *)arr picker:(PickerView *)pk{
    
    [self setTableViewDataSource:arr];
    [self showSelectTable];
    

}

@end
