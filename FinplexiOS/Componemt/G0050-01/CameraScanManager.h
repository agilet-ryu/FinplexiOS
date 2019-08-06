//
//  CameraScanManager.h
//  demoApp
//
//  Created by agilet on 2019/06/20.
//  Copyright © 2019 fujitsu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol cameraScanManagerDelegate <NSObject>

// カメラスキャン初期化（リソース）結果_正常時
- (void)cameraScanPrepareSuccess;

// 書類の認識成功時に呼び出されます。
- (void)cameraScanSuccessWithImage:(UIImage *)image andCropResult:(NSInteger)cropResult;

// プレビュー／認識中に何らかのエラーが発生した場合に呼び出されます。
- (void)cameraScanFailure:(NSInteger)errorCode;

// キャンセルボタンを押す時に呼び出されます。
- (void)cameraScanCancel;

// カメラスキャン起動成功時に呼び出されます。
- (void)cameraScanStart;

@end

@interface CameraScanManager : NSObject

@property (nonatomic, weak) id<cameraScanManagerDelegate>delegate;

// カメラスキャン初期化
+ (instancetype)sharedCameraScanManager;

// カメラスキャン起動
- (void)start;

// Scanに必要なリソースを解放します
- (void)deinitResource;
@end

NS_ASSUME_NONNULL_END
