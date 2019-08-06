//
//  NSArray+checkArray.m
//  demoApp
//
//  Created by agilet-ryu  on 2019/7/8.
//  Copyright © 2019 fujitsu. All rights reserved.
//

#import "NSArray+checkArray.h"

@implementation NSArray (checkArray)
+ (BOOL)isBlankArray:(NSArray *)aArray{
    if (aArray == nil) {
        return YES;
    }
    if ([aArray isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if (aArray.count == 0){
        return YES;
    }
    return NO;
}
@end
