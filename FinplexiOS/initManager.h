//
//  initManager.h
//  demoApp
//
//  Created by tourituyou on 2019/7/8.
//  Copyright © 2019 fujitsu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Config.h"
#import "ResultModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^FinplexResultBlock)(ResultModel* resultModel);  // オンライン本人確認ライブラリ処理結果応答

@interface initManager : NSObject

/**
 SDK初期化
 
 @param config 呼出元アプリ入力パラメータ
 @param currentController 呼出元アプリのController
 @param callBack オンライン本人確認ライブラリ処理結果応答
 @return Finplex初期化
 */
+ (instancetype)startFinplexWithConfig:(Config *)config
                            Controller:(UIViewController *)currentController
                              callback:(FinplexResultBlock)callBack;

@end

NS_ASSUME_NONNULL_END
