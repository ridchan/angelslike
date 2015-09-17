//
//  MineViewController.m
//  angelslike
//
//  Created by angelslike on 15/8/7.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "MineViewController.h"


@implementation MineViewController

@synthesize tableView = _tableView;



-(void)viewDidLoad{
    [super viewDidLoad];
    [self initialSetting];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)initialSetting{
    
    self.navigationItem.title = @"我的";
    
    self.infos = @[@[@{@"Name":@"用户信息"}],
                   @[@{@"Name":@"我的凑分子",@"IMG":@"mine_00",@"Action":@"myCouClick:"},
                     @{@"Name":@"我的订单",@"IMG":@"mine_01",@"Action":@"myOrderClick:"},
                     @{@"Name":@"我的购物车",@"IMG":@"mine_002"}
                     ],
                   @[@{@"Name":@"达人专区",@"IMG":@"mine_03"},
                     @{@"Name":@"邀请朋友",@"IMG":@"mine_04"},
                     @{@"Name":@"设置",@"IMG":@"mine_05",@"Action":@"settingClick:"}
                     ]
                   ];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
    
}


-(void)myOrderClick:(id)order{
    OrderListViewController *vc = [[OrderListViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)settingClick:(id)sender{
    SettingViewController *vc = [[SettingViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)myCouClick:(id)sender{
//    AddressViewController *vc = [[AddressViewController alloc] init];
    MyCouViewController *vc = [[MyCouViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.ctype = CouViewTypeFromSetting;
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)imageViewTap:(UIGestureRecognizer *)gesture{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择",@"拍照", nil];
    [sheet showInView:self.view];
    sheetIndex = -2;
    while (sheetIndex < -1) {
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    }
    if (sheetIndex < 0 | sheetIndex > 1 ) return;
    [self hideTabBar];
    UIImagePickerController *vc = [[UIImagePickerController alloc]init];
    vc.delegate = self;
    vc.sourceType = sheetIndex == 0?UIImagePickerControllerSourceTypePhotoLibrary:UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:vc animated:YES completion:NULL];
    
}


-(void)wallentTap:(UITapGestureRecognizer *)gesture{
    MyWallentViewController *vc = [[MyWallentViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self showTabbar];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImage *newImage = [self resizeImage:image];
    
//    __block MineViewController *tempSelf = self;
    __block UIImageView *tempImg = userImg;
    [picker dismissViewControllerAnimated:YES completion:^{
        NSData *_data = UIImageJPEGRepresentation(newImage,1.0);
        NSString *_encodedImageStr = Format2(@"data:image/png;base64,",[self encodeURL:[_data base64Encoding]]) ;
        [[NetWork shared] query:SaveImageUrl info:@{@"type":@"avatar",@"base64":_encodedImageStr,@"loginkey":[[UserInfo shared].info strForKey:@"loginkey"]} block:^(id Obj) {
            if ([Obj intForKey:@"status"] == 1) {
                NSString *link = [[Obj objectForKey:@"data"] strForKey:@"file"];
                [tempImg setPreImageWithUrl:link  domain:nil];
                [[UserInfo shared].info setObject:link forKey:@"img"];
            }else{
                
            }
            
        } lock:YES];
    }];
    [self showTabbar];
}

- (NSString*)encodeURL:(NSString *)string
{
    NSString *newString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)string, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"),kCFStringEncodingUTF8));
    if (newString) {
        return newString;
    }
    return @"";
}

-(UIImage *)resizeImage:(UIImage *)image{
    
    if (image.size.height > 300 | image.size.width >300) {
        CGRect rect = CGRectZero;
        if (image.size.height > image.size.width) {
            rect.size = CGSizeMake(300 * image.size.width / image.size.height, 300);
        }else{
            rect.size = CGSizeMake(300 , 300 * image.size.height / image.size.width );
        }
        UIGraphicsBeginImageContext(rect.size);
        [image drawInRect:rect];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImage;
    }else{
        return image;
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    sheetIndex = buttonIndex;
}


-(void)editButtonClick:(id)obj{
    EditInfoViewController *vc = [[EditInfoViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -
#pragma mark table view delegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    if (scrollView.contentOffset.y <= scrollView.contentInset.top) {
//        NSNumber *off = [NSNumber numberWithFloat:scrollView.contentOffset.y];
//        NSLog(@"off %@",off);
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"UserInfoCell" object:off];
//    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01;
    }else{
        return 2.0;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 200;
    }else{
        return 44;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *info = [[self.infos objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    if ([self respondsToSelector:NSSelectorFromString([info strForKey:@"Action"])]) {
        [self performSelector:NSSelectorFromString([info strForKey:@"Action"]) withObject:nil];
    }

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        UserInfoCell *cell = (UserInfoCell *)[tableView dequeueReusableCellWithIdentifier:@"UserCell"];
        if (cell == nil) {
            cell = [[UserInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UserCell"];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewTap:)];
            [cell.imageView addGestureRecognizer:tap];
            userImg = cell.imageView;
            
            UITapGestureRecognizer *wallentTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(wallentTap:)];
            [cell.wallent addGestureRecognizer:wallentTap];
            
            [cell.editButton addTarget:self action:@selector(editButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        cell.info = [UserInfo shared].info;
        return cell;
    }else{
        static NSString *identify = @"Cell";
        MineCell *cell = (MineCell *) [tableView dequeueReusableCellWithIdentifier:identify];
        if (cell == nil) {
            cell = [[MineCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        }
        NSDictionary *info = [[self.infos objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        cell.info = info;
        
        return cell;
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  [[self.infos objectAtIndex:section] count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.infos count];
}


@end
