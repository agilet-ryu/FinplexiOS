//
//  NSString+checkString.m
//  demoApp
//
//  Created by agilet-ryu  on 2019/7/8.
//  Copyright © 2019 fujitsu. All rights reserved.
//

#import "NSString+checkString.h"

@implementation NSString (checkString)

+ (BOOL)isEngNumString:(NSString *)aStr{
    NSInteger alength = [aStr length];
    for (int i = 0; i<alength; i++) {
        char commitChar = [aStr characterAtIndex:i];
        NSString *temp = [aStr substringWithRange:NSMakeRange(i,1)];
        const char *u8Temp = [temp UTF8String];
        if (3==strlen(u8Temp)){
            NSLog(@"字符串中含有中文");
        }else if((commitChar>64)&&(commitChar<91)){
            NSLog(@"字符串中含有大写英文字母");
        }else if((commitChar>96)&&(commitChar<123)){
            NSLog(@"字符串中含有小写英文字母");
        }else if((commitChar>47)&&(commitChar<58)){
            NSLog(@"字符串中含有数字");
        }else{
            NSLog(@"字符串中含有非法字符");
        }
    }
    return NO;
}


+ (BOOL)isBlankString:(NSString *)aStr{
    if (!aStr) {
        return YES;
    }
    if ([aStr isKindOfClass:[NSNull class]]) {
        return YES;
    }
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedStr = [aStr stringByTrimmingCharactersInSet:set];
    if (!trimmedStr.length) {
        return YES;
    }
    return NO;
}


@end
