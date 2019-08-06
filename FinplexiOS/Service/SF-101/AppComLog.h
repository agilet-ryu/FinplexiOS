//
//  AppComLog.h
//  demoApp
//
//  Created by agilet-ryu on 2019/8/1.
//  Copyright © 2019 fujitsu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Utils.h"

NS_ASSUME_NONNULL_BEGIN

// 
typedef void(^writeLogCallback)(NSString *resultCode);
typedef NS_ENUM(NSUInteger, LOGLEVEL) {
    LOGLEVELError,
    LOGLEVELInformation
};

@interface AppComLog : NSObject

+ (instancetype)writeEventLog:(NSString *)logString viewID:(NSString *)viewID LogLevel:(LOGLEVEL)logLevel withCallback:(writeLogCallback)callback atController:(UIViewController *)viewController;
@end

NS_ASSUME_NONNULL_END
