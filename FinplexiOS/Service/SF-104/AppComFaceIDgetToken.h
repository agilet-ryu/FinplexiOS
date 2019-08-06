//
//  AppComFaceIDgetToken.h
//  demoApp
//
//  Created by agilet-ryu on 2019/8/1.
//  Copyright © 2019 fujitsu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN
typedef void(^getFaceIDBizTokenResult)(NSString *result);

@interface AppComFaceIDgetToken : NSObject

/**
 「顔照合認証要求(App-GetBizToken)」のREST APIを利用しリクエスト発行。
 */
+ (instancetype)sendGetFaceIDTokenRequestWithController:(UIViewController *)controller andCallback:(getFaceIDBizTokenResult)result;
@end

NS_ASSUME_NONNULL_END
