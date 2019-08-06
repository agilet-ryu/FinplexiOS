//
//  AppComServerComm.h
//  demoApp
//
//  Created by agilet-ryu on 2019/8/1.
//  Copyright © 2019 fujitsu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "urlConfig.h"
#import "Utils.h"

NS_ASSUME_NONNULL_BEGIN

@interface FormData : NSObject
@property (nonatomic, strong) NSData *fileData;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *fileName;
@property (nonatomic, strong) NSString *mimeType;

+ (instancetype) initWithFileData:(NSData *)fileData fileName:(NSString *)fileName name:(NSString *)name mimeType:(NSString *)mimeType;
@end

@protocol AppComServerCommDelegate <NSObject>

// 通信成功時
- (void)appComServerCommSuccessWithResponseObject:(id)responseObject;

// 通信失敗時
- (void)appComServerCommFailure:(id)errorObject;

@end

/**
 送信データ種別

 - contentTypeJson: 1：JSON（Content-Type:application/json）
 - contentTypeMultipart: 2：フォームデータ（Content-Type:multipart/form-data）
 */
typedef NS_ENUM(NSInteger, ContentType) {
    contentTypeJson = 1,
    contentTypeMultipart = 2
};

@interface AppComServerComm : NSObject
@property (nonatomic, strong) NSString *urlPath;  // サーバ接続先URL
@property (nonatomic, assign) ContentType contentType;  // 送信データ種別
@property (nonatomic, assign) int timeOut;  // サーバ通信タイムアウト値(ms)
@property (nonatomic, strong) NSDictionary *param;  // 送信データ
@property (nonatomic, strong) NSString *gatewayAPIKey;  // API Gateway APIキー
@property (nonatomic, strong) NSArray<FormData*> *formDataArray;
@property (nonatomic, assign) id<AppComServerCommDelegate>delegate;

// 機能初期化
+ (instancetype)initService;

// リクエスト送信
- (void)sendRequest;
@end

NS_ASSUME_NONNULL_END
