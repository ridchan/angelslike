//
//  NetWork.h
//  angelslike
//
//  Created by angelslike on 15/8/4.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^NetWorkBlock)(id Obj);

@interface NetWork : NSObject{
    NSOperationQueue *queue;
}


+(instancetype)shared;

-(NSOperationQueue *)GetQueue;
-(void)startQuery:(NSString *)link info:(NSDictionary *)info completeBlock:(NetWorkBlock)block;

@end
