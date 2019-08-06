//
//  AppComLogSend.m
//  demoApp
//
//  Created by agilet-ryu on 2019/8/2.
//  Copyright © 2019 fujitsu. All rights reserved.
//

#import "AppComLogSend.h"
#import "InfoDatabase.h"
#import "AppComServerComm.h"
#import "urlConfig.h"

@interface AppComLogSend ()<AppComServerCommDelegate>
@property (nonatomic, assign) int sendLogLimit;
@property (nonatomic, copy) logSendCallback result;
@end

@implementation AppComLogSend

static AppComLogSend *logManager = nil;
static InfoDatabase *db = nil;

+ (instancetype)initService{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        logManager = [[AppComLogSend alloc] init];
        logManager.sendLogLimit = 0;
        db = [InfoDatabase shareInfoDatabase];
    });
    return logManager;
}

+ (instancetype)sendLogWithResult:(logSendCallback)result{
    logManager = [AppComLogSend initService];
    logManager.result = result;
    return logManager;
}

// ログ送信
- (void)logSend{
    if (db.eventLogs.count) {
        // 「操作ログデータ」が1件以上存在する場合は、ログ送信処理（SF-102-03）を呼び出す
        // 「SF-103：サーバ通信」機能初期化
        AppComServerComm *server = [AppComServerComm initService];
        server.delegate = self;
        server.contentType = contentTypeJson;
#warning TODO url 参数名称，是否加密，传参方式
        server.urlPath = kURLSendLog;
        server.param = @{
                         @"callid" : db.identificationData.CALL_ID,
                         @"uuid" : db.startParam.UUID,
                         @"requestid" : db.identificationData.REQUEST_ID,
                         @"log" : db.eventLogs
                         };
        self.sendLogLimit++;
        [server sendRequest];
    }else{
        
        // 「操作ログデータ」が0件の場合は、出力パラメータの「処理結果コード値：1」を返却し、処理を終了する。
        self.result(@"1", @"");
    }
}

#pragma mark - AppComServerCommDelegate

// 通信成功時
- (void)appComServerCommSuccessWithResponseObject:(id)responseObject{

#warning TODO  返回参数需要确认
    if ([responseObject[@"resultCode"] isEqualToString:@"1"]) {
        
        // 「処理結果コード値」が「1」の場合
        // 出力パラメータの「処理結果コード値：1」を返却し、処理を終了する。
        self.result(@"1", @"");
    }else{
        
        // 出力パラメータの「処理結果コード値：0」「エラーコード：ES00-202」を返却し、処理を終了する。
        self.result(@"0", @"ES00-202");
    }
}

// 通信失敗時
- (void)appComServerCommFailure:(id)errorObject{
    
    // ログ送信に失敗した場合は、最大3回まで再送を試みる。
    if (self.sendLogLimit < 3) {
        
        // ログ送信
        [self logSend];
    }else{
        
        // 出力パラメータの「処理結果コード値：0」「エラーコード：ES00-202」を返却し、処理を終了する。
        self.result(@"0", @"ES00-202");
    }
}

@end
