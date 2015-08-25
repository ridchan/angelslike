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
    self.infos = @{@"对象":@[@{@"Name":@"送长辈",@"IMG":@"duixiang_00.png",@"ID":@"39",@"Type":@"ob"},
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
                           ],
                   @"品类":@[@{@"Name":@"生活用品",@"IMG":@"pinglei_00.png",@"ID":@"22",@"Type":@"pt"},
                           @{@"Name":@"创意家居",@"IMG":@"pinglei_01.png",@"ID":@"24",@"Type":@"pt"},
                           @{@"Name":@"数码电器",@"IMG":@"pinglei_02.png",@"ID":@"31",@"Type":@"pt"},
                           @{@"Name":@"时尚穿搭",@"IMG":@"pinglei_03.png",@"ID":@"35",@"Type":@"pt"},
                           @{@"Name":@"美妆护理",@"IMG":@"pinglei_04.png",@"ID":@"47",@"Type":@"pt"},
                           @{@"Name":@"潮流饰物",@"IMG":@"pinglei_05.png",@"ID":@"55",@"Type":@"pt"},
                           @{@"Name":@"文体娱乐",@"IMG":@"pinglei_06.png",@"ID":@"60",@"Type":@"pt"},
                           @{@"Name":@"健康食品",@"IMG":@"pinglei_07.png",@"ID":@"67",@"Type":@"pt"},
                           @{@"Name":@"汽车用品",@"IMG":@"pinglei_08.png",@"ID":@"71",@"Type":@"pt"}
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
    UISegmentedControl *seg = [[UISegmentedControl alloc]initWithItems:@[@"礼物分类",@"主题分类"]];
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
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self showTabbar];
}


-(void)cellClick:(NSDictionary *)info{
    ProductlistViewController *vc = [[ProductlistViewController alloc]init];
    vc.dic = info;
    [self hideTabBar];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -
#pragma mark table view


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *identify = [NSString stringWithFormat:@"Cell%ld",indexPath.row];
    CategoryCell *cell = (CategoryCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[CategoryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        cell.backgroundColor =  [UIColor clearColor];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.title = [@[@"对象",@"场合",@"价格",@"个性",@"品类"] objectAtIndex:indexPath.row];
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
