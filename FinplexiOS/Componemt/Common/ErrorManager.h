//
//  ErrorManager.h
//  demoApp
//
//  Created by agilet-ryu on 2019/7/18.
//  Copyright © 2019 fujitsu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "InfoDatabase.h"
#import "UITool.h"

@protocol  ErrorManagerDelegate <NSObject>

- (void)buttonDidClickedWithTag:(NSInteger)tag;

@end

/**
 エラー画面の種類

 - errorManagerTypeClose: 「はい」ボタンのみ、押す時、ライブラリーを終了する
 */
typedef NS_ENUM(NSInteger, errorManagerType) {
    errorManagerTypeSDKClose,
    errorManagerTypeAlertClose,
    errorManagerTypeCustom
};

NS_ASSUME_NONNULL_BEGIN

@interface ErrorManager : NSObject

@property (nonatomic, assign) id<ErrorManagerDelegate>delegate;

/**
 エラー画面初期化

 @return ErrorManager
 */
+ (instancetype)shareErrorManager;

/**
 エラー処理

 @param errorCode エラーコード
 @param msg エラー
 @param controller ポップアップ
 */
- (void)dealWithErrorCode:(NSString *)errorCode msg:(NSString *)msg andController:(UIViewController *)controller;

/**
 エラー画面を表示する

 @param errorCode エラーコード
 @param currentController ポップアップ
 @param type エラー画面の種類
 @param firstMsg エラーメッセージ
 @param secondMsg エラーメッセージ
 */
- (void)showWithErrorCode:(NSString *)errorCode atCurrentController:(UIViewController *)currentController managerType:(errorManagerType)type addFirstMsg:(NSString *)firstMsg addSecondMsg:(NSString *)secondMsg;

/**
 エラー画面を表示する

 @param errorCode エラーコード
 @param currentController ポップアップ
 @param type エラー画面の種類
 @param buttonTitle ボタン
 */
- (void)showWithErrorCode:(NSString *)errorCode atCurrentController:(UIViewController *)currentController managerType:(errorManagerType)type buttonTitle:(NSString *)buttonTitle andTag:(NSInteger)tag;

- (void)showWithErrorCode:(NSString *)errorCode atCurrentController:(UIViewController *)currentController managerType:(errorManagerType)type buttonTitle:(NSString *)buttonTitle addFirstMsg:(NSString *)firstMsg addSecondMsg:(NSString *)secondMsg andTag:(NSInteger)tag;
@end

NS_ASSUME_NONNULL_END
