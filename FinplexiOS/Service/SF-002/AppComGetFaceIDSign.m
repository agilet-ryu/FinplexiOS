//
//  AppComGetFaceIDSign.m
//  FinplexiOS
//
//  Created by agilet-ryu on 2019/8/4.
//  Copyright © 2019 Fujitsu. All rights reserved.
//

#import "AppComGetFaceIDSign.h"
#import "AppComServerComm.h"
#import "InfoDatabase.h"

@interface AppComGetFaceIDSign ()<AppComServerCommDelegate>
@property (nonatomic, copy) getFaceIDSignResult result;
@property (nonatomic, strong) UIViewController *currentController;
@end

@implementation AppComGetFaceIDSign

static AppComGetFaceIDSign *manager = nil;
static InfoDatabase *db = nil;


/**
 SF-002認証機能初期化

 @return SF-002認証機能
 */
+ (instancetype)getFaceIDSignWithController:(UIViewController *)controller andCallback:(getFaceIDSignResult)result {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AppComGetFaceIDSign alloc] init];
        db = [InfoDatabase shareInfoDatabase];
    });
    manager.currentController = controller;
    manager.result = result;
    [manager sendRequest];
    return manager;
}

// リクエストを送信する
- (void)sendRequest{
    
    // パラメーターを取得する
    NSString *apiSecret = db.startParam.API_SECRET;
    NSString *businessID = db.configFileData.MAIN_ACCOUNT;
    NSDictionary *param = @{@"business_id" : apiSecret,
                            @"api_secret" : businessID};
    
    // パラメーターはJSON文字列になります。
    NSString *paramStr = [Utils convertToJsonData:param];
    
    // 文字列をAES暗号化する
    NSString *aesParamStr = [Utils aes_encryptWithString:paramStr];
    
    // URLを作成する
    NSString *url = [NSString stringWithFormat:@"%@%@", kNetworkHostFaceIDSign,aesParamStr];
    
    // 「SF-103：サーバ通信」機能初期化
    AppComServerComm *server = [AppComServerComm initService];
    server.delegate = self;
    server.contentType = contentTypeJson;
    server.urlPath = url;
    [server sendRequest];
}

#pragma mark - AppComServerCommDelegate

// 通信成功時
- (void)appComServerCommSuccessWithResponseObject:(id)responseObject{
    int status = [responseObject[@"status"] intValue];
    if (status == 0) {
        self.result(@"0");
        
        // FaceID電子署名取得成功時
        // 応答内のFaceID電子署名、有効期限判定用日付、設定値情報、CallIDを共通領域へ設定する。
        [self dealWithResponse:responseObject];
        
    } else{
        self.result(@"1");
        
        // FaceID電子署名取得でエラーが返却された場合
        // エラーコードを共通領域の「本人確認内容データ.エラーコード」へ設定する
        // 共通領域の「本人確認内容データ.認証処理結果」へ「異常」を設定する
        // ポップアップでエラーメッセージ「SF-001-01E」を表示する。
        [[ErrorManager shareErrorManager] dealWithErrorCode:responseObject[@"error_code"] msg:@"SF-001-01E" andController:self.currentController];
    }
}

// 通信失敗時
- (void)appComServerCommFailure:(id)errorObject{
    self.result(@"1");
    
    // エラーコードを共通領域の「本人確認内容データ.エラーコード」へ設定する
    // 共通領域の「本人確認内容データ.認証処理結果」へ「異常」を設定する
    // ポップアップでエラーメッセージ「SF-001-01E」を表示する。
//    [[ErrorManager shareErrorManager] dealWithErrorCode:@"ES02-2001" msg:@"SF-001-01E" andController:self.currentController];
}

// FaceID電子署名、有効期限判定用日付、設定値情報、CallIDを共通領域へ設定する。
- (void)dealWithResponse:(id)responseObject {
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseObject];
    
    // 設定ファイルデータを設定する
    db.configFileData.NFC_ENABLE = 0;  // NFC機能有効化フラグ
    db.configFileData.SHOOT_THICKNESS_ENABLE = [dic[@"shoot_thickness_enable"] intValue];  // 厚み撮影機能有効化フラグ
    db.configFileData.CAMERA_ENABLE = [dic[@"camera_enable"] intValue];  // カメラ撮影有効化フラグ
    db.configFileData.OCR_ENABLE = [dic[@"ocr_enable"] intValue];  // OCR機能有効化フラグ
    db.configFileData.SAVE_IMAGE_FLG = [dic[@"save_image_flg"] intValue];  // 画像保存フラグ
    // 本人確認内容データを設定する
    db.identificationData.FACEID_SIGNATURE = dic[@"faceid_signature"];
    db.identificationData.CALL_ID = dic[@"call_id"];
    db.identificationData.EXPIRATION_DATE = dic[@"expiration_date"];
    
//    configFileData.IDENTIFICATION_DOCUMENT_DRIVERS_LICENCE = [dic[@"identification_document_drivers_licence"] intValue];  // 本人確認書類（運転免許証）フラグ
//    configFileData.IDENTIFICATION_DOCUMENT_MYNUMBER = [dic[@"identification_document_mynumber"] intValue];  // 本人確認書類（マイナンバーカード）フラグ
//    configFileData.IDENTIFICATION_DOCUMENT_PASSPORT = [dic[@"identification_document_passport"] intValue];  // 本人確認書類（パスポート）フラグ
//    configFileData.IDENTIFICATION_DOCUMENT_RESIDENCE = [dic[@"identification_document_residence"] intValue];  // 本人確認書類（在留カード）フラグ
//    configFileData.IDENTIFICATION_DOCUMENT_SPECIAL_PERMANENT_RESIDENT_CERTIFICATE = [dic[@"identification_document_special_permanent_resident_certificate"] intValue];  // 本人確認書類（特別永住者証明書）フラグ
//    configFileData.CHECK_OCR_STATUS_1 = [dic[@"check_ocr_status_1"] intValue];  // 氏名の妥当性確認
//    configFileData.CHECK_OCR_STATUS_2 = [dic[@"check_ocr_status_2"] intValue];  // 氏名（カナ）の妥当性確認
//    configFileData.CHECK_OCR_STATUS_3 = [dic[@"check_ocr_status_3"] intValue];  // 住所の妥当性確認
//    configFileData.CHECK_OCR_STATUS_4 = [dic[@"check_ocr_status_4"] intValue];  // 生年月日の妥当性確認
//    configFileData.CHECK_OCR_STATUS_5 = [dic[@"check_ocr_status_5"] intValue];  // 本籍地の妥当性確認
//    configFileData.CHECK_OCR_STATUS_6 = [dic[@"check_ocr_status_6"] intValue];  // 運転免許種類の妥当性確認
//    configFileData.CHECK_OCR_STATUS_7 = [dic[@"check_ocr_status_7"] intValue];  // 有効期限帯色の妥当性確認
//    configFileData.CHECK_OCR_STATUS_8 = [dic[@"check_ocr_status_8"] intValue];  // 性別の妥当性確認
//    configFileData.CHECK_OCR_STATUS_9 = [dic[@"check_ocr_status_9"] intValue];  // 交付日の妥当性確認
//    configFileData.CHECK_OCR_STATUS_10 = [dic[@"check_ocr_status_10"] intValue];  // 免許種類の枠数の妥当性確認
//    configFileData.CHECK_OCR_STATUS_11 = [dic[@"check_ocr_status_11"] intValue];  // 免許の条件等1の妥当性確認
//    configFileData.CHECK_OCR_STATUS_12 = [dic[@"check_ocr_status_12"] intValue];  // 免許の条件等2の妥当性確認
//    configFileData.CHECK_OCR_STATUS_13 = [dic[@"check_ocr_status_13"] intValue];  // 免許の条件等3の妥当性確認
//    configFileData.CHECK_OCR_STATUS_14 = [dic[@"check_ocr_status_14"] intValue];  // 免許の条件等4の妥当性確認
//    configFileData.CHECK_OCR_STATUS_15 = [dic[@"check_ocr_status_15"] intValue];  // 取得日（二・小・原）の妥当性確認
//    configFileData.CHECK_OCR_STATUS_16 = [dic[@"check_ocr_status_16"] intValue];  // 取得日（他）の妥当性確認
//    configFileData.CHECK_OCR_STATUS_17 = [dic[@"check_ocr_status_17"] intValue];  // 取得日（二種）の妥当性確認
//    configFileData.CHECK_OCR_STATUS_18 = [dic[@"check_ocr_status_18"] intValue];  // 公安委員会の妥当性確認
//    configFileData.CHECK_OCR_STATUS_19 = [dic[@"check_ocr_status_19"] intValue];  // 運転免許証番号の妥当性確認
//    configFileData.MANGEMENT_CONSOL_USE = [dic[@"mangement_consol_use"] intValue];  // 管理コンソール利用フラグ
    //    configFileData.LIVENESS_ACTION_LIMIT = [dic[@"liveness_action_limit"] intValue];  // 顔モーションre-Try回数
//    configFileData.SHOOT_THICKNESS_LIMIT = [dic[@"shoot_thickness_limit"] intValue];  // 厚み撮影re-Try回数
//    configFileData.OCR_LIMIT = [dic[@"ocr_limit"] intValue];  // サーバOCRre-Try回数
//    configFileData.LIVENESS_TYPE = dic[@"liveness_type"];  // モーションタイプ
//    configFileData.LIVENESS_TIMEOUT = dic[@"liveness_timeout"];  // タイムアウト設定時間
//    configFileData.LIVENESS_ACTION_COUNT = dic[@"liveness_action_count"];  // モーションパターン回数
//    configFileData.LOG_OUTPUT_LIMIT = [dic[@"log_output_limit"] intValue];  // 操作ログ書出回数上限
//    configFileData.IMG_MASK = [dic[@"img_mask"] intValue];  // 本人確認書類画像マスクフラグ
}
@end
