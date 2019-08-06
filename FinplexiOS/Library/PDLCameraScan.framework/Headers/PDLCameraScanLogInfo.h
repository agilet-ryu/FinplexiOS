//
//  Copyright PFU Limited 2017-2018
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, PDLCameraScanLogInfo) {
    PDLCameraScanLogInfoInfo = 0,
    PDLCameraScanLogInfoWarning,
    PDLCameraScanLogInfoError,
};

/** Log用Callback型定義 */
typedef void (^PDLCameraScanLogCallbackBlock)(PDLCameraScanLogInfo, NSString * __nonnull, NSInteger, NSString *__nonnull);
