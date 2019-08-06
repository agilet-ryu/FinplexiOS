//
//  AppComReadOCR.h
//  FinplexiOS
//
//  Created by agilet-ryu on 2019/8/4.
//  Copyright © 2019 Fujitsu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^readOCRResult)(NSString *result, NSString *errorCode);
@interface AppComReadOCR : NSObject

// SF-010サーバOCR機能初期化
+ (instancetype)readOCRWithController:(UIViewController *)controller andCallback:(readOCRResult)result;
@end

NS_ASSUME_NONNULL_END
