//
//  CouImageCell.m
//  angelslike
//
//  Created by angelslike on 15/9/7.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "CouImageCell.h"

@implementation ImageCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self.contentView addSubview:self.imageView];
        
        
//        self.contentView.layer.borderColor = RGBA(178,177,182,.9).CGColor;
//        self.contentView.layer.borderWidth = 0.5;
    }
    return self;
}

@end

@implementation CouImageCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //
        self.clipsToBounds = YES;
        self.images = [NSMutableArray array];
        self.imageNames = [NSMutableArray array];
        
        imageView = [[UIImageView alloc]initWithFrame:RECT(10, 1, 30, 30)];
        imageView.image = IMAGE(@"download");
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = imageView.frame;
        [button addTarget:self action:@selector(imageSelect:) forControlEvents:UIControlEventTouchUpInside];
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageSelect:)];
//        [imageView addGestureRecognizer:tap];
        [self addSubview:imageView];
        [self addSubview:button];
        
        label = [[UILabel alloc]initWithFrame:RECT(0, 1, ScreenWidth - 5, 30)];
        label.textAlignment = NSTextAlignmentRight;
        label.font = FontWS(12);
        label.text = @"最多上传9张图片";
        [self addSubview:label];
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc]initWithFrame:RECT(10, 40, ScreenWidth - 20 , 120) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[ImageCell class] forCellWithReuseIdentifier:@"ImageCell"];
        [self addSubview:_collectionView];
        
    }
    return self;
}


-(void)imageSelect:(id)obj{
    if(!vc) vc = [self findViewController:self];
    asIndex = -1;
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"选择操作" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相片选择", nil];
    [sheet showInView:vc.view];
    while(asIndex < 0) {
        [[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1.0]];
    }
    if (asIndex != 0 & asIndex != 1) return;
    
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.sourceType = asIndex == 0? UIImagePickerControllerSourceTypeCamera:UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    if (isIOS8)
        picker.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [[self findViewController:self] presentViewController:picker animated:YES completion:NULL];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{

    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImage *newImage = [self resizeImage:image];

    __block CouImageCell *tempSelf = self;
    __block UICollectionView *tempView = _collectionView;
    [picker dismissViewControllerAnimated:YES completion:^{
        NSData *_data = UIImageJPEGRepresentation(image,1.0);
        NSString *_encodedImageStr = Format2(@"data:image/png;base64,",[self encodeURL:[_data base64Encoding]]) ;
        [[NetWork shared] query:SaveImageUrl info:@{@"type":@"cou",@"base64":_encodedImageStr} block:^(id Obj) {
            if ([Obj intForKey:@"status"] == 1) {
                [tempSelf.images addObject:newImage];
                [tempSelf.imageNames addObject:[[Obj objectForKey:@"data"] strForKey:@"file"]];
                [tempView reloadData];
                [self ResetImageArray];
            }else{
                
            }
   
        } lock:YES];
    }];
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




#pragma mark action sheet

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    asIndex = buttonIndex;
}

#pragma mark -
#pragma mark collection view

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return  1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.images count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    UIImage *image = [self.images objectAtIndex:indexPath.row];
    cell.imageView.image = image;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(!vc) vc = [self findViewController:self];
    asIndex = -1;
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"是否删除此图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"否" otherButtonTitles:@"是", nil];
    [sheet showInView:vc.view];
    while(asIndex < 0) {
        [[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1.0]];
    }
    if (asIndex != 1 ) return;
    
    [self.images removeObjectAtIndex:indexPath.row];
    [self.imageNames removeObjectAtIndex:indexPath.row];
    [collectionView reloadData];
    
    [self ResetImageArray];
}


-(void)ResetImageArray{
    NSData *data = [NSJSONSerialization dataWithJSONObject:self.imageNames options:NSJSONWritingPrettyPrinted error:nil];
    NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    [self.info setObject:str forKey:@"img"];
    
}


#pragma mark- FlowDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(90, 90);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;// ScreenWidth/9;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

@end
