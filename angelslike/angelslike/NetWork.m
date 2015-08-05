//
//  NetWork.m
//  angelslike
//
//  Created by angelslike on 15/8/4.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "NetWork.h"



@implementation NetWork

+(instancetype)shared{
    static NetWork *shareInstance = nil ;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        shareInstance = [[NetWork alloc]init];
    });
    
    return shareInstance;
}

-(NSOperationQueue *)GetQueue{
    return queue;
}

-(instancetype)init{
    self = [super init];
    queue = [[NSOperationQueue alloc]init];
    return self;
}

-(void)startQuery:(NSString *)link info:(NSDictionary *)info completeBlock:(NetWorkBlock)block{
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:link]];
    NSMutableString *postString = [NSMutableString string];
    if (info!=nil) {
        for (NSString *key in [info allKeys]) {
            [postString appendFormat:@"&%@=%@",key,[info objectForKey:key]];
        }
        
    }
    NSData *postdata = [postString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postlength = [NSString stringWithFormat:@"%lu",(unsigned long)[postdata length]];
    [request setValue:postlength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postdata];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        dispatch_async(dispatch_get_main_queue(), ^{
            block([NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil]);
        });
        
        
    }];
}

@end
