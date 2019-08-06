//
//  AppComServerComm.m
//  demoApp
//
//  Created by agilet-ryu on 2019/8/1.
//  Copyright © 2019 fujitsu. All rights reserved.
//

#import "AppComServerComm.h"
#import <AFNetworking/AFNetworking.h>
@implementation AppComServerComm

static AFHTTPSessionManager *sessionManager = nil;
static AppComServerComm *server = nil;

// サーバ通信タイムアウト値(ms)デフォルト
- (int)timeOut{
    if (!_timeOut) {
        _timeOut = 6;
    }
    return _timeOut;
}

// 機能初期化
+ (instancetype)initService{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sessionManager = [[AFHTTPSessionManager manager] init];
        server = [[AppComServerComm alloc] init];
    });
    return server;
}

// リクエスト送信
- (void)sendRequest{
    // サーバ通信タイムアウト値
    [sessionManager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    sessionManager.requestSerializer.timeoutInterval = self.timeOut * 0.001;
    [sessionManager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json", @"text/json", @"text/javascript",@"text/html",nil];
    
    if (self.contentType == contentTypeMultipart) {
        [sessionManager.requestSerializer setValue:@"multipart/form-data; charset=utf-8; boundary=__X_PAW_BOUNDARY__" forHTTPHeaderField:@"Content-Type"];
        [self sendRequestMultipart];
    }else{
        [self sendRequestJson];
    }
}

- (void)sendRequestMultipart{
    __weak typeof(self) weakSelf = self;
    [sessionManager POST:self.urlPath parameters:self.param headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        // データをアップロード
        if (weakSelf.formDataArray.count) {
            for (int i = 0; i < weakSelf.formDataArray.count; i++) {
                FormData *data = weakSelf.formDataArray[i];
                [formData appendPartWithFileData:data.fileData name:data.name fileName:data.fileName mimeType:data.mimeType];
            }
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 通信成功時
        if ([weakSelf.delegate respondsToSelector:@selector(appComServerCommSuccessWithResponseObject:)]) {
            [weakSelf.delegate appComServerCommSuccessWithResponseObject:responseObject];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSData *data = error.userInfo[@"com.alamofire.serialization.response.error.data"];
        id errorObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        // 通信失敗時
        if ([weakSelf.delegate respondsToSelector:@selector(appComServerCommFailure:)]) {
            [weakSelf.delegate appComServerCommFailure:errorObject];
        }
    }];
}

- (void)sendRequestJson{
    __weak typeof(self) weakSelf = self;
    [sessionManager POST:self.urlPath parameters:self.param headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 通信成功時
        if ([weakSelf.delegate respondsToSelector:@selector(appComServerCommSuccessWithResponseObject:)]) {
            [weakSelf.delegate appComServerCommSuccessWithResponseObject:responseObject];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSData *data = error.userInfo[@"com.alamofire.serialization.response.error.data"];
        id errorObject = data ? [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil] : error;
        
        // 通信失敗時
        if ([weakSelf.delegate respondsToSelector:@selector(appComServerCommFailure:)]) {
            [weakSelf.delegate appComServerCommFailure:errorObject];
        }
    }];
}
@end

@implementation FormData

+ (instancetype) initWithFileData:(NSData *)fileData fileName:(NSString *)fileName name:(NSString *)name mimeType:(NSString *)mimeType{
    FormData *data = [[FormData alloc] init];
    data.fileData = fileData;
    data.fileName = fileName;
    data.name = name;
    data.mimeType = mimeType;
    return data;
}

@end
