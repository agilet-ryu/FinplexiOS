//
//  AppComLogSend.h
//  demoApp
//
//  Created by agilet-ryu on 2019/8/2.
//  Copyright © 2019 fujitsu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^logSendCallback)(NSString *result, NSString *errorCode);

@interface AppComLogSend : NSObject
+ (instancetype)sendLogWithResult:(logSendCallback)result;
@end

NS_ASSUME_NONNULL_END
