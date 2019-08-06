//
//  CompareFaceViewController.m
//  FinplexiOS
//
//  Created by agilet-ryu on 2019/8/4.
//  Copyright © 2019 Fujitsu. All rights reserved.
//

#import "CompareFaceViewController.h"
#import <WebKit/WebKit.h>
#import "AppComServerComm.h"

@interface CompareFaceViewController ()<ErrorManagerDelegate, AppComServerCommDelegate>

@end

@implementation CompareFaceViewController
static InfoDatabase *db = nil;

- (void)viewDidLoad {
    [super viewDidLoad];
    db = [InfoDatabase shareInfoDatabase];
    self.viewID = @"G0120-01";
    [self initView];
    [self sendVerifyRequest];
}

- (void)initView{
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0,200,[UIScreen mainScreen].bounds.size.width,250)];
    [self.view addSubview:webView];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"verify" ofType:@"gif"];
    NSURL *url = [NSURL fileURLWithPath:path];
    [webView loadFileURL:url allowingReadAccessToURL:url];
    self.automaticallyAdjustsScrollViewInsets=NO;
    webView.userInteractionEnabled = NO;
}

// 顔照合（自然人検知）要求(App-Verify)の送信
- (void)sendVerifyRequest{
    
    // 操作ログ編集
    [AppComLog writeEventLog:@"顔照合（自然人検知）要求(App-Verify)" viewID:@"G0120-01" LogLevel:LOGLEVELInformation withCallback:^(NSString * _Nonnull resultCode) {
        
    } atController:self];
    
    FormData *data = [FormData initWithFileData:db.identificationData.CAMERA_IMG
                                       fileName:@"meglive_data"
                                           name:@"meglive_data"
                                       mimeType:@"text/html"];
    AppComServerComm *commm = [AppComServerComm initService];
    commm.urlPath = kURLGetFaceIDToken;
    commm.delegate = self;
    commm.param = @{@"sign" : db.identificationData.FACEID_SIGNATURE,
                    @"sign_version" : @"hmac_sha1",
                    @"biz_token" : db.identificationData.BIZ_TOKEN,
                    };
    commm.contentType = contentTypeMultipart;
    commm.formDataArray = @[data];
    [commm sendRequest];
}

#pragma mark - AppComServerCommDelegate

- (void)appComServerCommSuccessWithResponseObject:(id)responseObject{
    ErrorManager *manager = [ErrorManager shareErrorManager];
    manager.delegate = self;
    
    if (responseObject[@"error"]) {
        
        // API処理異常時、ポップアップにて「メッセージコード：SF-014-01E」を表示する。
        [manager showWithErrorCode:@"SF-014-01E" atCurrentController:self managerType:errorManagerTypeCustom buttonTitle:@"はい" andTag:2000];
    }else{
        
        // API処理正常時
        // 顔照合（自然人検知）応答(App-Verify)内容を共通領域.本人確認内容データに編集
        [self dealWithResponseDic:responseObject];
        if (db.configFileData.SHOOT_THICKNESS_ENABLE == 1) {
            
            // 厚み撮影有効時
            if ([db.identificationData.RESULT isEqualToString:@"1"]) {
                
                // 照合結果OKの場合
                if (db.identificationData.GAIN_TYPE == 1) {
                    
                    // 読取方法が「1:カメラ撮影」の場合、「G0130-01：厚み撮影開始前画面」へ遷移する。
#warning TODO 厚み撮影開始前画面
                }else{
                    
                    // 読取方法が「2:NFC読取」の場合
                    if (db.configFileData.SAVE_IMAGE_FLG == 1) {
                        
                        // 管理コンソール利用、「SF-016:取得情報サーバ送信」を呼び出す。
                        
                    }else{
                        
                        // 管理コンソール未利用、「SF-102：操作ログサーバ送信」および「SF-017：処理終了」を呼び出す。
                    }
                }
            }else{
                
                // 照合結果NGの場合、ポップアップにて「メッセージコード：SF-014-01E」を表示する
                [manager showWithErrorCode:@"SF-014-01E" atCurrentController:self managerType:errorManagerTypeCustom buttonTitle:@"はい" andTag:2000];
            }
        }else{
            
            // 厚み撮影無効時
            if (db.configFileData.MANGEMENT_CONSOL_USE == 1) {
                
                // 管理コンソール利用
                // 「SF-016:取得情報サーバ送信」を呼び出す。
                
            }else{
                
                // 管理コンソール未利用
                // 「SF-102：操作ログサーバ送信」および「SF-017：処理終了」を呼び出す
                
            }
        }
    }
}

- (void)appComServerCommFailure:(id)errorObject{
    ErrorManager *manager = [ErrorManager shareErrorManager];
    manager.delegate = self;
    // 通信エラー場合、ポップアップにて「メッセージコード：CM-001-02E」を表示する。
    [manager showWithErrorCode:@"CM-001-02E" atCurrentController:self managerType:errorManagerTypeCustom buttonTitle:@"再試行" andTag:1000];
}

/**
 顔照合（自然人検知）応答(App-Verify)内容を共通領域.本人確認内容データに編集
 
 @param responseDic 取得するレスポンス
 */
- (void)dealWithResponseDic:(NSDictionary *)responseDic{
    db.identificationData.REQUEST_ID = responseDic[@"request_id"];
    db.identificationData.SCORE = responseDic[@"verification"][@"idcard"][@"confidence"];
    NSDictionary *thresholds = responseDic[@"verification"][@"idcard"][@"thresholds"];
    float score = [db.identificationData.SCORE floatValue];
    if(db.startParam.THREHOLDS_LEVEL == FARTypeLevelOne){db.identificationData.FAR = thresholds[@"1e-3"];}
    if(db.startParam.THREHOLDS_LEVEL == FARTypeLevelTwo){db.identificationData.FAR = thresholds[@"1e-4"];}
    if(db.startParam.THREHOLDS_LEVEL == FARTypeLevelThree){db.identificationData.FAR = thresholds[@"1e-5"];}
    if(db.startParam.THREHOLDS_LEVEL == FARTypeLevelFour){db.identificationData.FAR = thresholds[@"1e-6"];}
    float level = [db.identificationData.FAR floatValue];
    if (score > level) {
        db.identificationData.RESULT = @"1";
    }else{
        db.identificationData.RESULT = @"9";
    }
    db.identificationData.FRR = db.identificationData.FAR;
}

#pragma mark - ErrorManagerDelegate
- (void)buttonDidClickedWithTag:(NSInteger)tag{
    if (tag == 1000) {
        
        //「再試行ボタン」を押す、顔照合（自然人検知）要求(App-Verify)の再送信
        [self sendVerifyRequest];
    }
    if (tag == 2000) {
        
        // 「はい」ボタンタップにより、「SF-013：自然人検知」を呼び出す。
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#warning TODO 人脸比对接口返回error补全
- (void)dealWithError:(NSString *)error{
    NSString *code = [NSString string];
    NSString *msg = [NSString string];
    if ([error containsString:@"MAGE_ERROR_UNSUPPORTED_FORMAT"]) {
        code = @"";
        msg = @"";
    }else if ([error containsString:@"MISSING_ARGUMENTS"]){
        code = @"";
        msg = @"";
    }else if ([error containsString:@"BAD_ARGUMENTS"]){
        code = @"";
        msg = @"";
    }else if ([error containsString:@"NO_FACE_FOUND"]){
        code = @"";
        msg = @"";
    }else if ([error containsString:@"INVALID_IMAGE_SIZE"]){
        code = @"";
        msg = @"";
    }else if ([error containsString:@"MEGLIVE_DATA_ERROR"]){
        code = @"";
        msg = @"";
    }else if ([error containsString:@"MEGLIVE_DATA_BIZ_TOKEN_NOT_MATCH"]){
        code = @"";
        msg = @"";
    }else if ([error containsString:@"AUTHORIZATION_ERROR"]){
        code = @"";
        msg = @"";
    }else if ([error containsString:@"CONCURRENCY_LIMIT_EXCEEDED"]){
        code = @"";
        msg = @"";
    }else if ([error containsString:@"API_NOT_FOUND"]){
        code = @"";
        msg = @"";
    }else if ([error containsString:@"Request Entity Too Large"]){
        code = @"";
        msg = @"";
    }else if ([error containsString:@"INTERNAL_ERROR"]){
        code = @"";
        msg = @"";
    }else if ([error containsString:@"PASS_LIVING_NOT_THE_SAME"]){
        code = @"";
        msg = @"";
    }else if ([error containsString:@"FAIL_LIVING_FACE_ATTACK"]){
        code = @"";
        msg = @"";
    }else if ([error containsString:@"VIDEO_LACK_FRAMES"]){
        code = @"";
        msg = @"";
    }else if ([error containsString:@"FAIL_EYES_CLOSE_DETECTION"]){
        code = @"";
        msg = @"";
    }else if ([error containsString:@"BIZ_TOKEN_DENIED"]){
        code = @"";
        msg = @"";
    }else if ([error containsString:@"AUTHENTICATION_FAIL"]){
        code = @"";
        msg = @"";
    }else if ([error containsString:@"MOBILE_PHONE_NOT_SUPPORT"]){
        code = @"";
        msg = @"";
    }else if ([error containsString:@"SDK_TOO_OLD SDK"]){
        code = @"";
        msg = @"";
    }else if ([error containsString:@"MOBILE_PHONE_NO_AUTHORITY"]){
        code = @"";
        msg = @"";
    }else if ([error containsString:@"USER_CANCELLATION"]){
        code = @"";
        msg = @"";
    }else if ([error containsString:@"USER_TIMEOUT Liveness"]){
        code = @"";
        msg = @"";
    }else if ([error containsString:@"VERIFICATION_FAILURE"]){
        code = @"";
        msg = @"";
    }else if ([error containsString:@"UNDETECTED_FACE"]){
        code = @"";
        msg = @"";
    }else if ([error containsString:@"ACTION_ERROR"]){
        code = @"";
        msg = @"";
    }
    if (code.length) {
        [[ErrorManager shareErrorManager] dealWithErrorCode:code msg:msg andController:self];
    }else{
        [[ErrorManager shareErrorManager] showWithErrorCode:msg atCurrentController:self managerType:errorManagerTypeAlertClose addFirstMsg:@"" addSecondMsg:@""];
    }
}
@end
