//
//  UIColor+hexString.h
//  demoApp
//
//  Created by agilet on 2019/06/18.
//  Copyright © 2019 fujitsu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (hexString)

+(UIColor *)colorWithHexString:(NSString *)hexColor alpha:(float)opacity;

@end

NS_ASSUME_NONNULL_END
