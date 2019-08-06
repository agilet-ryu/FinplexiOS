//
//  AppComGetFaceIDSign.h
//  FinplexiOS
//
//  Created by agilet-ryu on 2019/8/4.
//  Copyright © 2019 Fujitsu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
typedef void(^getFaceIDSignResult)(NSString *result);
@interface AppComGetFaceIDSign : NSObject

//  SF-002認証機能初期化
+ (instancetype)getFaceIDSignWithController:(UIViewController *)controller andCallback:(getFaceIDSignResult)result;
@end

NS_ASSUME_NONNULL_END
