//
//  NSString+checkString.h
//  demoApp
//
//  Created by agilet-ryu  on 2019/7/8.
//  Copyright © 2019 fujitsu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (checkString)
+ (BOOL)isBlankString:(NSString *)aStr;
@end

NS_ASSUME_NONNULL_END
