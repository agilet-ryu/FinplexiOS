//
//  Utils.h
//  demoApp
//
//  Created by agilet-ryu on 2019/7/22.
//  Copyright © 2019 fujitsu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ErrorManager.h"
#import "SystemCode.h"

NS_ASSUME_NONNULL_BEGIN

@interface Utils : NSObject

/**
 西暦から和暦への変換

 @param jpDate 和暦文字列
 @return 西暦文字列
 */
+ (NSString *)getGregorianDateFromJapaneseDate:(NSString *)jpDate;

+ (BOOL)isExpiratedDocDate:(NSString*)docDate withCurrentDate:(NSString*)currentDate;

/**
 システム内コードを取得する

 @return システム内コード
 */
+ (SystemCode *)getSystemCode;

/**
 現在の時刻を取得する

 @return 時間の文字列
 */
+ (NSString *)getCurrentTime;

/**
 NSDictionaryはNSStringになります。
 
 @param dictionary パラメーター
 @return 戻り値
 */
+ (NSString *)convertToJsonData:(NSDictionary *)dictionary;

/**
 NSStringはNSDictionaryになります。
 
 @param jsonString パラメーター
 @return 戻り値
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

/**
 文字列をAES暗号化する

 @param string パラメーター
 @return 暗号化する文字列
 */
+ (NSString *)aes_encryptWithString:(NSString *)string;

/**
 画像をAES暗号化する

 @param image パラメーター
 @return 暗号化するデータ
 */
+ (NSData *)aes_encryptWithImage:(UIImage *)image;

/**
 AES復号する

 @param base64String パラメーター
 @return 復号復号する文字列
 */
+ (NSString *)aes_decryptWithBase64String:(NSString *)base64String;

/**
 画像はbase64文字列になります。

 @param image 画像
 @return base64文字列
 */
+ (NSString *)base64StringWithImage:(UIImage *)image;

+ (NSString *)getHtmlParam;

@end

NS_ASSUME_NONNULL_END
