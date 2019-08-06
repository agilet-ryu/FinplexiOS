//
//  ResultModel.m
//  demoApp
//
//  Created by agilet-ryu on 2019/7/17.
//  Copyright © 2019 fujitsu. All rights reserved.
//

#import "ResultModel.h"

@implementation ResultModel
static ResultModel *result = nil;
+ (instancetype)shareResultModel{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        result = [[ResultModel alloc] init];
    });
    return result;
}
@end
