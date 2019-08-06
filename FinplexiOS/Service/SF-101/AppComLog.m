//
//  AppComLog.m
//  demoApp
//
//  Created by agilet-ryu on 2019/8/1.
//  Copyright © 2019 fujitsu. All rights reserved.
//

#import "AppComLog.h"



@interface AppComLog()
@property (nonatomic, copy) writeLogCallback resultCode;
@end

@implementation AppComLog

static InfoDatabase *db = nil;
static AppComLog *comLog = nil;

+ (instancetype)initService{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        comLog = [[AppComLog alloc] init];
        db = [InfoDatabase shareInfoDatabase];
    });
    return comLog;
}

+ (instancetype)writeEventLog:(NSString *)logString viewID:(NSString *)viewID LogLevel:(LOGLEVEL)logLevel withCallback:(writeLogCallback)callback atController:(UIViewController *)viewController{
    comLog = [AppComLog initService];
    [comLog writeEventLog:logString viewID:viewID LogLevel:logLevel withCallback:callback atController:viewController];
    return comLog;
}

- (void)writeEventLog:(NSString *)logString viewID:(NSString *)viewID LogLevel:(LOGLEVEL)logLevel withCallback:(writeLogCallback)callback atController:(UIViewController *)viewController{
    self.resultCode = callback;
    NSDictionary *dic = @{@"log_output_time" : [Utils getCurrentTime],
                          @"log_type" : @"O",
                          @"log_level" : logLevel == LOGLEVELError ? @"E" : @"I",
                          @"scree_id" : viewID,
                          @"log_text" : logString
                          };
    if (!db.eventLogs) {
        db.eventLogs = [NSMutableArray array];
    }
    [db.eventLogs addObject:dic];
    if (![db.eventLogs containsObject:dic]) {
        
        // 「処理結果コード値」に0を設定し、 呼出し元に返却する。
        self.resultCode(@"0");
        
        // 共通領域.本人確認内容データ.オンライン本人確認結果に「異常」を設定
        // 共通領域.本人確認内容データ.エラーコードに「ES00-102」を設定
        // ポップアップでメッセージ「CM-001-99E」を表示
        [[ErrorManager shareErrorManager] dealWithErrorCode:@"ES00-102" msg:@"CM-001-99E" andController:viewController];
    }else{
        // 共通領域.本人確認内容データ.操作ログ書出回数を１加算
        db.identificationData.LOG_OUTPUT++;
        if (db.identificationData.LOG_OUTPUT > db.configFileData.LOG_OUTPUT_LIMIT) {
            
            // 「処理結果コード値」に2を設定し、 呼出し元に返却する。
            self.resultCode(@"2");
            
            // 共通領域.本人確認内容データ.オンライン本人確認結果に「異常」を設定
            // 共通領域.本人確認内容データ.エラーコードに「ES00-102」を設定
            // ポップアップでメッセージ「CM-001-99E」を表示
            [[ErrorManager shareErrorManager] dealWithErrorCode:@"ES00-101" msg:@"CM-001-06E" andController:viewController];
        }else{
            
            // 共通領域.本人確認内容データ.操作ログ書出回数  ＜=　共通領域.設定ファイルデータ.ログ書出回数上限の場合
            // 「処理結果コード値」に1を設定し、 呼出し元に返却する。
            self.resultCode(@"1");
        }
    }
}

@end
