//
//  CategoryViewController.m
//  angelslike
//
//  Created by angelslike on 15/8/6.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "CategoryViewController.h"

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCellInfo];
    [self initialSetting];
    
    // Do any additional setup after loading the view.
}


-(void)setCellInfo{
    //设置数据
    self.infos = @{@"品类":@[@{@"Name":@"日用百货",@"IMG":@"pinglei_00.png",@"ID":@"88",@"Type":@"pt"},
                             @{@"Name":@"穿搭配饰",@"IMG":@"pinglei_01.png",@"ID":@"96",@"Type":@"pt"},
                             @{@"Name":@"美妆护肤",@"IMG":@"pinglei_02.png",@"ID":@"101",@"Type":@"pt"},
                             @{@"Name":@"美食养生",@"IMG":@"pinglei_03.png",@"ID":@"108",@"Type":@"pt"},
                             @{@"Name":@"亲子玩具",@"IMG":@"pinglei_04.png",@"ID":@"115",@"Type":@"pt"},
                             @{@"Name":@"户外运动",@"IMG":@"pinglei_05.png",@"ID":@"120",@"Type":@"pt"},
                             @{@"Name":@"数码电器",@"IMG":@"pinglei_06.png",@"ID":@"125",@"Type":@"pt"},
                             @{@"Name":@"文化办公",@"IMG":@"pinglei_07.png",@"ID":@"132",@"Type":@"pt"},
                             @{@"Name":@"爱车萌宠",@"IMG":@"pinglei_08.png",@"ID":@"136",@"Type":@"pt"}
                            ],
                   @"对象":@[@{@"Name":@"送长辈",@"IMG":@"duixiang_00.png",@"ID":@"39",@"Type":@"ob"},
                           @{@"Name":@"送恋人",@"IMG":@"duixiang_01.png",@"ID":@"35",@"Type":@"ob"},
                           @{@"Name":@"送同事",@"IMG":@"duixiang_02.png",@"ID":@"36",@"Type":@"ob"},
                           @{@"Name":@"送朋友",@"IMG":@"duixiang_03.png",@"ID":@"37",@"Type":@"ob"},
                           @{@"Name":@"送老师",@"IMG":@"duixiang_04.png",@"ID":@"60",@"Type":@"ob"},
                           @{@"Name":@"送儿童",@"IMG":@"duixiang_05.png",@"ID":@"38",@"Type":@"ob"},
                           @{@"Name":@"送亲人",@"IMG":@"duixiang_06.png",@"ID":@"61",@"Type":@"ob"},
                           @{@"Name":@"送嘉宾",@"IMG":@"duixiang_07.png",@"ID":@"62",@"Type":@"ob"}
                           ],
                   @"场合":@[@{@"Name":@"亲情礼",@"IMG":@"changhe_00.png",@"ID":@"41",@"Type":@"se"},
                           @{@"Name":@"爱情礼",@"IMG":@"changhe_01.png",@"ID":@"42",@"Type":@"se"},
                           @{@"Name":@"人情礼",@"IMG":@"changhe_02.png",@"ID":@"44",@"Type":@"se"},
                           @{@"Name":@"生日礼",@"IMG":@"changhe_03.png",@"ID":@"45",@"Type":@"se"},
                           @{@"Name":@"婚庆礼",@"IMG":@"changhe_04.png",@"ID":@"63",@"Type":@"se"},
                           @{@"Name":@"节日礼",@"IMG":@"changhe_05.png",@"ID":@"46",@"Type":@"se"}
                           ],
                   @"价格":@[@{@"Name":@"¥50以下",@"IMG":@"jiage_00.png",@"ID":@"1",@"Type":@"pp"},
                           @{@"Name":@"¥50-200",@"IMG":@"jiage_01.png",@"ID":@"2",@"Type":@"pp"},
                           @{@"Name":@"¥200-500",@"IMG":@"jiage_02.png",@"ID":@"3",@"Type":@"pp"},
                           @{@"Name":@"¥500-1000",@"IMG":@"jiage_03.png",@"ID":@"4",@"Type":@"pp"},
                           @{@"Name":@"¥1000以上",@"IMG":@"jiage_04.png",@"ID":@"5",@"Type":@"pp"}
                           ],
                   @"个性":@[@{@"Name":@"高逼格",@"IMG":@"gexin_00.png",@"ID":@"4",@"Type":@"ct"},
                           @{@"Name":@"清新美物",@"IMG":@"gexin_01.png",@"ID":@"5",@"Type":@"ct"},
                           @{@"Name":@"整蛊搞笑",@"IMG":@"gexin_02.png",@"ID":@"6",@"Type":@"ct"},
                           @{@"Name":@"科技苑",@"IMG":@"gexin_03.png",@"ID":@"7",@"Type":@"ct"},
                           @{@"Name":@"低调宅",@"IMG":@"gexin_04.png",@"ID":@"8",@"Type":@"ct"},
                           @{@"Name":@"中国风",@"IMG":@"gexin_05.png",@"ID":@"9",@"Type":@"ct"},
                           @{@"Name":@"文化范",@"IMG":@"gexin_06.png",@"ID":@"10",@"Type":@"ct"}
                           ]
                   };
}


-(void)initialSetting{
    
    
    //table view
    self.tableView = [[LoadMoreTableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.currentPage = 0;
    self.tableView.totalPage = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
    
    //顶部配置
    seg = [[UISegmentedControl alloc]initWithItems:@[@"礼物分类",@"主题分类"]];
    seg.frame = CGRectMake(0, 6 , 200, 32);
    seg.tintColor = [UIColor whiteColor];
    seg.selectedSegmentIndex = 0;
    [seg addTarget:self action:@selector(viewChange:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = seg;
    
    //搜索按钮
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchClick:)];
    barButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = barButtonItem;
    
    self.tvc = [[ThemeViewController alloc]init];
    self.tvc.view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    [self.view addSubview:self.tvc.view];
    self.tvc.view.hidden = YES;
    
    //搜索栏
    _searchBar = [[UISearchBar alloc]init];
    _searchBar.delegate = self;
}

#pragma mark -

-(void)viewChange:(UISegmentedControl *)sender{
    
    [UIView beginAnimations:nil context:nil];
    //持续时间
    [UIView setAnimationDuration:.5];
    //在出动画的时候减缓速度
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    //添加动画开始及结束的代理
    [UIView setAnimationDelegate:self];
    //动画效果
//    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];

    
    if (sender.selectedSegmentIndex == 0) {
        self.tvc.view.hidden = YES;
        [self.view sendSubviewToBack:self.tvc.view];
    }else{
        self.tvc.view.hidden = NO;
        [self.view bringSubviewToFront:self.tvc.view];
    }
    
    [UIView commitAnimations];
}

-(void)searchClick:(id)sender{
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(dismissSearchBar:)];
    barButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = barButtonItem;
    self.navigationItem.titleView.transform = CGAffineTransformMakeTranslation(0, -44);
    [UIView animateWithDuration:0.35 animations:^{
        self.navigationItem.titleView.alpha = 0.0;
    } completion:^(BOOL finished) {
        self.navigationItem.titleView = _searchBar;
        [UIView animateWithDuration:0.35 animations:^{
            self.navigationItem.titleView.transform = CGAffineTransformMakeTranslation(0, 44);
        }];
    }];}

-(void)dismissSearchBar:(id)sender{
    if(seg.selectedSegmentIndex == 0){
        _searchBar.text = @"";

    }else{
        [self.tvc.searchInfo setObject:@"" forKey:@"key"];
        [self.tvc reloadData];
    }
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchClick:)];
    barButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = barButtonItem;
    self.navigationItem.titleView.transform = CGAffineTransformMakeTranslation(0, -44);
    [UIView animateWithDuration:0.35 animations:^{
        self.navigationItem.titleView.alpha = 0.0;
    } completion:^(BOOL finished) {
        self.navigationItem.titleView = seg;
        [UIView animateWithDuration:0.34 animations:^{
            self.navigationItem.titleView.transform = CGAffineTransformMakeTranslation(0, 44);
        }];
    }];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [_searchBar resignFirstResponder];
    
    if(seg.selectedSegmentIndex == 0){
        ProductlistViewController *vc = [[ProductlistViewController alloc]init];
        vc.dic = @{@"key":_searchBar.text};
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [self.tvc.searchInfo setObject:_searchBar.text forKey:@"key"];
        [self.tvc reloadData];
    }
}



-(void)cellClick:(NSDictionary *)info{
    ProductlistViewController *vc = [[ProductlistViewController alloc]init];
    vc.dic = info;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -
#pragma mark table view


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *identify = [NSString stringWithFormat:@"Cell%ld",(long)indexPath.row];
    CategoryCell *cell = (CategoryCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[CategoryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        cell.backgroundColor =  [UIColor clearColor];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.title = [[self.infos allKeys] objectAtIndex:indexPath.row];
        cell.buttonInfos = [self.infos objectForKey:cell.title];
        cell.delegate = self;
    }

    
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  [[self.infos allKeys]count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CatCellHeight + CatCellGap;
}

@end
