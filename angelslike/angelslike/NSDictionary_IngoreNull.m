//
//  NSDictionary_IngoreNull.m
//  BooksBB
//
//  Created by rid on 11-9-23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NSDictionary_IngoreNull.h"


@implementation NSDictionary(NSDictionary_IngoreNull)


-(BOOL)emptyForKey:(NSString *)aKey{
    if ([[self strForKey:aKey] isEqualToString:@""]) {
        return YES;
    }
    return NO;
}

-(NSString *)strForKey:(id)aKey{
	if ([self objectForKey:(id)aKey] && !([self objectForKey:(id)aKey]==[NSNull null])) {
		return [NSString stringWithFormat:@"%@",[self objectForKey:aKey]];
	}else {
		return [NSString stringWithFormat:@""];
	}
}

-(id)objForKey:(NSString *)aKey{
    if (!([self objectForKey:(id)aKey]==[NSNull null])) {
        return [self objectForKey:(id)aKey];
    }else {
        return nil;
    }
}

-(double)floatForKey:(id)aKey{
	if ([self objectForKey:(id)aKey] && !([self objectForKey:(id)aKey]==[NSNull null])) {
		return [[self objectForKey:aKey] doubleValue];
	}else {
		return 0.0;
	}
}

-(NSString *)preStringForKey:(NSString *)aKey{
    if ([self objectForKey:aKey] && !([self objectForKey:aKey]==[NSNull null])) {
        NSString *value = [self objectForKey:aKey];
        NSRange range = [value rangeOfString:@" "];
        if (range.location != NSNotFound) {
            return [value substringToIndex:range.location];
        }
		return [NSString stringWithFormat:@"%@",[self objectForKey:aKey]];
	}else {
		return [NSString stringWithFormat:@""];
	}
}

-(NSString *)sqlStringForKey:(NSString *)aKey{
    if ([self objectForKey:aKey] && !([self objectForKey:aKey]==[NSNull null])) {
        NSString *value = [self objectForKey:aKey];
		return [value stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
	}else {
		return [NSString stringWithFormat:@""];
	}
}

-(NSString *)numForKey:(NSString *)aKey{
	if ([self objectForKey:aKey] && !([self objectForKey:aKey]==[NSNull null])) {
		return [self objectForKey:aKey];
	}else {
		return [NSString stringWithFormat:@"0"];
	}
}

-(NSInteger)intForKey:(NSString *)aKey{
    if ([self objectForKey:aKey] && !([self objectForKey:aKey]==[NSNull null])) {
		return [[self objectForKey:aKey] integerValue];
	}else {
		return NSNotFound;
	}
}

@end
