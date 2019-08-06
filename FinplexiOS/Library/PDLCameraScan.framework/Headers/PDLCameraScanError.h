//
//  Copyright PFU Limited 2017-2018
//

#import <Foundation/Foundation.h>
#import "PDLCameraScanErrorCode.h"


/*!
 @brief      エラー情報を格納する
 @note
 */
@interface PDLCameraScanError : NSObject

@property (nonatomic, readonly) PDLCameraScanErrorCode code;

+ (nullable instancetype)errorWithCode:(PDLCameraScanErrorCode)code;
+ (nullable instancetype)errorWithCodeRawValue:(int32_t)rawValue;

@end
