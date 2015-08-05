//
//  UIImageView+NetWork.m
//  angelslike
//
//  Created by angelslike on 15/8/4.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "UIImageView+NetWork.h"

@implementation UIImageView (NetWork)

-(void)setImageView:(NSString *)link{
    __block UIImageView *tempSelf = self;

    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:link]];
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [tempSelf setImage:[[UIImage alloc]initWithData:data]];
        });
        
    }];
}

@end
