//
//  StartDetectFaceViewController.m
//  FinplexiOS
//
//  Created by agilet-ryu on 2019/8/4.
//  Copyright © 2019 Fujitsu. All rights reserved.
//

#import "StartDetectFaceViewController.h"
#import <MGFaceIDLiveDetect/MGFaceIDLiveDetect.h>
#import <WebKit/WebKit.h>
#import "urlConfig.h"
#import "CompareFaceViewController.h"

@interface StartDetectFaceViewController ()
@property (nonatomic, assign) BOOL verifyFailure;
@end

@implementation StartDetectFaceViewController
InfoDatabase *db = nil;

- (void)viewDidLoad {
    [super viewDidLoad];
    db = [InfoDatabase shareInfoDatabase];
    self.viewID = @"G0100-01";
    self.verifyFailure = NO;
    [self initView];
}

- (void)initView{
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0,200,SCREEN_WIDTH,250)];
    [self.view addSubview:webView];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"verify" ofType:@"gif"];
    NSURL *url = [NSURL fileURLWithPath:path];
    [webView loadFileURL:url allowingReadAccessToURL:url];
    self.automaticallyAdjustsScrollViewInsets=NO;
    webView.userInteractionEnabled = NO;
}

/**
 「自然人検知SDK」初期化判断
 */
- (void)initFaceIDLiveDetectManager{
    if (db.identificationData.MOTION_RETRY_COUNT < db.configFileData.LIVENESS_ACTION_LIMIT) {
        
        // 操作ログ編集
        [AppComLog writeEventLog:@"自然人検知SDK初期化" viewID:@"G0100-01" LogLevel:LOGLEVELInformation withCallback:^(NSString * _Nonnull resultCode) {
            
        } atController:self];
        
        // 共通領域.本人確認内容データ.顔モーションTry済み回数<共通領域.設定ファイルデータ.自然人検知re-Try回数の場合
        // 「自然人検知SDK」初期化
        MGFaceIDLiveDetectError* error;
        MGFaceIDLiveDetectManager* detectManager = [[MGFaceIDLiveDetectManager alloc] initMGFaceIDLiveDetectManagerWithBizToken:db.identificationData.BIZ_TOKEN
                                                                                                                       language:MGFaceIDLiveDetectLanguageEn
                                                                                                                    networkHost:kMGFaceIDNetworkHost
                                                                                                                      extraData:nil
                                                                                                                          error:&error];
        if (error) {
            
            // 初期化異常時
            if (error.errorType == MGFaceIDLiveDetectErrorNotCameraPermission || error.errorType == MGFaceIDLiveDetectErrorNotCameraSupport) {
                
                // カメラ利用非許可エラー、ポップアップにて「メッセージコード：CM-001-04E」を表示する。
                [[ErrorManager shareErrorManager] showWithErrorCode:@"CM-001-04E" atCurrentController:self managerType:errorManagerTypeAlertClose addFirstMsg:@"" addSecondMsg:@""];
            }else{
                
                // 初期化エラー、ポップアップにて「メッセージコード：CM-001-03E」を表示する。
                [[ErrorManager shareErrorManager] showWithErrorCode:@"CM-001-03E" atCurrentController:self managerType:errorManagerTypeAlertClose addFirstMsg:@"" addSecondMsg:@""];
            }
        }else{
            
            // 操作ログ編集
            [AppComLog writeEventLog:@"自然人検知SDK起動" viewID:@"G0100-01" LogLevel:LOGLEVELInformation withCallback:^(NSString * _Nonnull resultCode) {
                
            } atController:self];
            
            // 初期化正常時、「自然人検知SDK」起動
            [detectManager startMGFaceIDLiveDetectWithCurrentController:self
                                                               callback:^(MGFaceIDLiveDetectError *error, NSData *deltaData, NSString *bizTokenStr, NSDictionary *extraOutDataDict) {
                                                                   if (error.errorType == MGFaceIDLiveDetectErrorNone) {
                                                                       
                                                                       // 「自然人検知SDK」起動正常時
                                                                       //  共通領域.本人確認内容データ.自然人検知re-Try済み回数を1カウントアップする
                                                                       db.identificationData.MOTION_RETRY_COUNT++;
                                                                       
                                                                       // 戻り値「モーション撮影画像」を共通領域.本人確認内容データに編集
                                                                       db.identificationData.CAMERA_IMG = deltaData;
                                                                       
                                                                       // 「SF-014:顔照合」を呼び出す。
                                                                       CompareFaceViewController *f = [[CompareFaceViewController alloc] init];
                                                                       [self.navigationController pushViewController:f animated:YES];
                                                                   } else {
                                                                       
                                                                       // 「自然人検知SDK」起動異常時
                                                                       if (error.errorType == MGFaceIDLiveDetectErrorNetWorkNotConnected) {
                                                                           
                                                                           // 通信エラー時、ポップアップにて「メッセージコード：CM-001-03E」を表示する。
                                                                           [[ErrorManager shareErrorManager] showWithErrorCode:@"CM-001-03E" atCurrentController:self managerType:errorManagerTypeAlertClose addFirstMsg:@"" addSecondMsg:@""];
                                                                       }else if (error.errorType == MGFaceIDLiveDetectErrorNotCameraPermission || error.errorType == MGFaceIDLiveDetectErrorNotCameraSupport){
                                                                           
                                                                           // カメラ設定非許可エラー、ポップアップにて「メッセージコード：CM-001-04E」を表示する。
                                                                           [[ErrorManager shareErrorManager] showWithErrorCode:@"CM-001-04E" atCurrentController:self managerType:errorManagerTypeAlertClose addFirstMsg:@"" addSecondMsg:@""];
                                                                       }else{
                                                                           
                                                                           // その他エラー場合
                                                                           // 共通領域.本人確認内容データ.顔モーションTry済み回数を1カウントアップする。
                                                                           db.identificationData.MOTION_RETRY_COUNT++;
                                                                           
                                                                           if (db.identificationData.MOTION_RETRY_COUNT < db.configFileData.LIVENESS_ACTION_LIMIT){
                                                                               
                                                                               // 共通領域.本人確認内容データ.顔モーションTry済み回数<共通領域.設定ファイルデータ.自然人検知re-Try回数の場合
                                                                               // ポップアップにて「メッセージコード：CM-001-03E」を表示する
                                                                               [[ErrorManager shareErrorManager] showWithErrorCode:@"CM-001-03E" atCurrentController:self managerType:errorManagerTypeAlertClose addFirstMsg:@"" addSecondMsg:@""];
                                                                               
                                                                           }else{
                                                                               
                                                                               // 共通領域.本人確認内容データ.顔モーションTry済み回数＝共通領域.設定ファイルデータ.自然人検知re-Try回数の場合
                                                                               // ポップアップにて「メッセージコード：CM-001-05E」を表示する
#warning TODO mark errorCode定义
                                                                               [[ErrorManager shareErrorManager] showWithErrorCode:@"CM-001-05E" atCurrentController:self managerType:errorManagerTypeAlertClose addFirstMsg:@"" addSecondMsg:@""];
                                                                           }
                                                                       }
                                                                   }
                                                               }];
        }
    }else{
        
        // 共通領域.本人確認内容データ.顔モーションTry済み回数＝共通領域.設定ファイルデータ.自然人検知re-Try回数の場合
        // ポップアップにて「メッセージコード：CM-001-05E」を表示する
#warning TODO mark errorCode定义
        [[ErrorManager shareErrorManager] dealWithErrorCode:@"" msg:@"CM-001-05E" andController:self];
    }
}

@end
