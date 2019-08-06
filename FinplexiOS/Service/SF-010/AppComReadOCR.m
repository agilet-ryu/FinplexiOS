//
//  AppComReadOCR.m
//  FinplexiOS
//
//  Created by agilet-ryu on 2019/8/4.
//  Copyright © 2019 Fujitsu. All rights reserved.
//

#import "AppComReadOCR.h"
#import "AppComServerComm.h"
#import "InfoDatabase.h"

@interface AppComReadOCR ()<AppComServerCommDelegate>
@property (nonatomic, copy) readOCRResult result;
@property (nonatomic, strong) UIViewController *currentController;
@end

@implementation AppComReadOCR
static AppComReadOCR *manager = nil;
static InfoDatabase *db = nil;

// SF-010サーバOCR機能初期化
+ (instancetype)readOCRWithController:(UIViewController *)controller andCallback:(readOCRResult)result{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AppComReadOCR alloc] init];
        db = [InfoDatabase shareInfoDatabase];
    });
    [manager sendRequest];
    manager.currentController = controller;
    manager.result = result;
    return manager;
}

// リクエストを送信する
- (void)sendRequest{
    
    // 「本人確認書類画像」はオンライン本人確認ライブラリ内の共通鍵（ライブラリ内で定数管理）を使用して暗号化する
    NSData *AESData = [Utils aes_encryptWithImage:[UIImage imageNamed:@"OCR.jpg"]];
    
    // 「SF-103：サーバ通信」機能初期化
    AppComServerComm *server = [AppComServerComm initService];
    server.delegate = self;
    server.contentType = contentTypeMultipart;
    server.urlPath = kNetworkHostOcrService;
    FormData *data = [FormData initWithFileData:AESData fileName:@"image_ref1" name:@"image_ref1" mimeType:@"image/jpeg"];
    server.formDataArray = @[data];
    
    // リクエストをオンライン本人確認サーバへ送信する。
    [server sendRequest];
}

#pragma mark - AppComServerCommDelegate

// 通信成功時
- (void)appComServerCommSuccessWithResponseObject:(id)responseObject{
    
    NSString *decStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    
    // OCR結果値をオンライン本人確認ライブラリ内の共通鍵（ライブラリ内で定数管理）を使用して復号化する。
    NSString *str = [Utils aes_decryptWithBase64String:decStr];
    NSDictionary *responseDic = [NSDictionary dictionaryWithDictionary:[Utils dictionaryWithJsonString:str]];
    
    NSString *resultCode = [NSString stringWithFormat:@"%@", responseDic[@"RESULT_CODE"]];
    
    if ([resultCode isEqualToString:@"1"]) {
        
        // OCR応答の「処理結果」が「1：成功」の場合
        // OCR読む取り書類を取得する
        int ocrCardCode;
        int cardType = [responseDic[@"CARD_TYPE"] intValue];
        switch (cardType) {
            case -1:
                ocrCardCode = 9;
                break;
            case 1:
                ocrCardCode = 9;
                break;
            case 2:
                ocrCardCode = 2;
                break;
            case 3:
                ocrCardCode = 2;
                break;
            case 4:
                ocrCardCode = 1;
                break;
            case 5:
                ocrCardCode = 4;
                break;
            case 6:
                ocrCardCode = 5;
                break;
            case 7:
                ocrCardCode = 1;
                break;
            default:
                ocrCardCode = 9;
                break;
        }
        if (ocrCardCode == db.identificationData.DOC_TYPE) {
            
            // OCR読む取り書類　== 共通領域.本人確認内容データ.本人確認書類
            if ([responseDic[@"EXPIRATION_CHECK"] isEqualToString:@"0"]) {
                
                // 「有効期限の妥当性」が 「0：妥当な認識処理である」の場合
                // 有効期限確認を実施する
#warning TODO 个人番号卡时，返回的时间格式,这种情况可以只对比个人番号卡
                NSString *expiration = [NSString stringWithFormat:@"%@", responseDic[@"EXPIRATION"]];
                NSString *docDateJP = expiration.length >= 4 ? [expiration substringWithRange:NSMakeRange(0, expiration.length - 4)] : expiration;
                
                // 西暦から和暦への変換
                NSString *docDateCommon = [Utils getGregorianDateFromJapaneseDate:docDateJP];
                
                if([Utils isExpiratedDocDate:docDateCommon withCurrentDate:db.identificationData.EXPIRATION_DATE]){
                    
                    // OCR応答内の「有効期限」の年月日 < 共通領域.本人確認内容データ.有効期限判定用日付の場合
                    // 呼出元機能へOCR応答の「処理結果」と「エラーコード：EC010-002」を返却する。
                    self.result(@"1", @"EC010-002");
                }else{
                    
                    // OCR応答内の「有効期限」の年月日 >= 共通領域.本人確認内容データ.有効期限判定用日付の場合
                    if ([self checkOCRStatus:responseDic]) {
                        
                        // 共通領域.設定ファイルデータ.xxx(各OCR項目名)の妥当性確認で「1：確認する」の項目が存在しない場合
                        // OCR応答の内容を共通領域へ設定する
                        db.identificationData.NAME = responseDic[@"NAME"];
                        db.identificationData.KANA = responseDic[@"KANA"];
                        db.identificationData.ADDRESS = responseDic[@"ADDRESS"];
                        db.identificationData.BIRTH = responseDic[@"BIRTH"];
                        db.identificationData.PERMANENT_ADDRESS = responseDic[@"PERMANENT_ADDRESS"];
                        db.identificationData.TYPE = responseDic[@"TYPE"];
                        db.identificationData.BAND_COLOR = responseDic[@"BAND_COLOR"];
                        db.identificationData.GENDER = responseDic[@"SEX"];
                        db.identificationData.EXPIRATION = responseDic[@"EXPIRATION"];
                        db.identificationData.ISSUANCE_DATE = responseDic[@"ISSUANCE_DATE"];
                        db.identificationData.TYPE_NUM = responseDic[@"TYPE_NUM"];
                        db.identificationData.CONDITION_1 = responseDic[@"CONDITION_1"];
                        db.identificationData.CONDITION_2 = responseDic[@"CONDITION_2"];
                        db.identificationData.CONDITION_3 = responseDic[@"CONDITION_3"];
                        db.identificationData.CONDITION_4 = responseDic[@"CONDITION_4"];
                        db.identificationData.DATE_NIKOGEN = responseDic[@"DATE_NIKOGEN"];
                        db.identificationData.DATE_OTHER = responseDic[@"DATE_OTHER"];
                        db.identificationData.DATE_SECOND = responseDic[@"DATE_SECOND"];
                        db.identificationData.COMMISSION = responseDic[@"COMMISSION"];
                        db.identificationData.NUMBER = responseDic[@"NUMBER"];
                        db.identificationData.POSITION_IMAGE_X1 = responseDic[@"POSITION_IMAGE_X1"];
                        db.identificationData.POSITION_IMAGE_X2 = responseDic[@"POSITION_IMAGE_X2"];
                        db.identificationData.POSITION_IMAGE_Y1 = responseDic[@"POSITION_IMAGE_Y1"];
                        db.identificationData.POSITION_IMAGE_Y2 = responseDic[@"POSITION_IMAGE_Y2"];
                        self.result(@"0", @"");
                    } else{
                        
                        // 「1：確認する」の項目のうち「0：妥当な認識処理である」以外が設定されている項目が存在する場合
                        // 「処理結果」と「エラーコード：EC010-001」を返却する。
                        self.result(@"1", @"EC010-001");
                    }
                }
            } else if ([responseDic[@"EXPIRATION_CHECK"] isEqualToString:@"1"]){
                
                // 「有効期限の妥当性」が 「1：項目が存在しない」の場合
                // 「処理結果」と「エラーコード：EC010-001」を返却する
                self.result(@"1", @"EC010-001");
                
            } else if ([responseDic[@"EXPIRATION_CHECK"] isEqualToString:@"2"]){
                
                // 「有効期限の妥当性」が 「2：妥当な認識結果でない」の場合
                // 有効期限確認を実施する
#warning TODO 个人番号卡时，返回的时间格式
                NSString *expiration = [NSString stringWithFormat:@"%@", responseDic[@"EXPIRATION"]];
                NSString *docDateJP = expiration.length >= 4 ? [expiration substringWithRange:NSMakeRange(0, expiration.length - 4)] : expiration;
                
                // 西暦から和暦への変換
                NSString *docDateCommon = [Utils getGregorianDateFromJapaneseDate:docDateJP];
                
                if (docDateCommon && docDateCommon.length) {
                    
                    // 文字認識可の場合
                    if([Utils isExpiratedDocDate:docDateCommon withCurrentDate:db.identificationData.EXPIRATION_DATE]){
                        
                        // OCR応答内の「有効期限」の年月日 < 共通領域.本人確認内容データ.有効期限判定用日付の場合
                        // 「エラーコード：EC010-002」を返却する。
                        self.result(@"1", @"EC010-002");
                    }else{
                        
                        // OCR応答内の「有効期限」の年月日 >= 共通領域.本人確認内容データ.有効期限判定用日付の場合
                        // 「エラーコード：EC010-001」を返却する。
                        self.result(@"1", @"EC010-001");
                    }
                }else{
                    
                    // 文字認識不可の場合
                    // 「エラーコード：EC010-001」を返却する。
                    self.result(@"1", @"EC010-001");
                }
            }
        }else{
            
            // OCR読む取り書類　!= 共通領域.本人確認内容データ.本人確認書類
            self.result(@"1", @"");
#warning TODO 拍照和所选书类不一致时
        }
    } else {
        
        // OCR応答の「処理結果」が「0：失敗」の場合
        // 「エラーコード」と「エラーコード」を返却する。
        self.result(@"1", responseDic[@"ERROR"]);
    }
}

// 通信失敗時
- (void)appComServerCommFailure:(id)errorObject{
    self.result(@"1", @"networkError");
}

- (BOOL)checkOCRStatus:(NSDictionary *)responseDic{
    CONFIG_FILE_DATA *configDB = db.configFileData;
    if (configDB.CHECK_OCR_STATUS_1 == 1) {
        
        // 氏名の妥当性確認
        if (![responseDic[@"NAME_CHECK"] isEqualToString:@"0"]) {
            return NO;
        }
    }
    if (configDB.CHECK_OCR_STATUS_2 == 1){
        
        // // 氏名（カナ）の妥当性確認
        if (![responseDic[@"NAME_CHECK"] isEqualToString:@"0"]) {
            return NO;
        }
    }
    if (configDB.CHECK_OCR_STATUS_3 == 1){
        
        // 住所の妥当性確認
        if (![responseDic[@"NAME_CHECK"] isEqualToString:@"0"]) {
            return NO;
        }
    }
    if (configDB.CHECK_OCR_STATUS_4 == 1){
        
        // 生年月日の妥当性確認
        if (![responseDic[@"NAME_CHECK"] isEqualToString:@"0"]) {
            return NO;
        }
    }
    if (configDB.CHECK_OCR_STATUS_5 == 1){
        
        // 本籍地の妥当性確認
        if (![responseDic[@"NAME_CHECK"] isEqualToString:@"0"]) {
            return NO;
        }
    }
    if (configDB.CHECK_OCR_STATUS_6 == 1){
        
        // 運転免許種類の妥当性確認
        if (![responseDic[@"NAME_CHECK"] isEqualToString:@"0"]) {
            return NO;
        }
    }
    if (configDB.CHECK_OCR_STATUS_7 == 1){
        
        // 有効期限帯色の妥当性確認
        if (![responseDic[@"NAME_CHECK"] isEqualToString:@"0"]) {
            return NO;
        }
    }
    if (configDB.CHECK_OCR_STATUS_8 == 1){
        
        // 性別の妥当性確認
        if (![responseDic[@"NAME_CHECK"] isEqualToString:@"0"]) {
            return NO;
        }
    }
    if (configDB.CHECK_OCR_STATUS_9 == 1){
        
        // 交付日の妥当性確認
        if (![responseDic[@"NAME_CHECK"] isEqualToString:@"0"]) {
            return NO;
        }
    }
    if (configDB.CHECK_OCR_STATUS_10 == 1){
        
        // 免許種類の枠数の妥当性確認
        if (![responseDic[@"NAME_CHECK"] isEqualToString:@"0"]) {
            return NO;
        }
    }
    if (configDB.CHECK_OCR_STATUS_11 == 1){
        
        // 免許の条件等1の妥当性確認
        if (![responseDic[@"NAME_CHECK"] isEqualToString:@"0"]) {
            return NO;
        }
    }
    if (configDB.CHECK_OCR_STATUS_12 == 1){
        
        // 免許の条件等2の妥当性確認
        if (![responseDic[@"NAME_CHECK"] isEqualToString:@"0"]) {
            return NO;
        }
    }
    if (configDB.CHECK_OCR_STATUS_13 == 1){
        
        // 免許の条件等3の妥当性確認
        if (![responseDic[@"NAME_CHECK"] isEqualToString:@"0"]) {
            return NO;
        }
    }
    if (configDB.CHECK_OCR_STATUS_14 == 1){
        
        // 免許の条件等4の妥当性確認
        if (![responseDic[@"NAME_CHECK"] isEqualToString:@"0"]) {
            return NO;
        }
    }
    if (configDB.CHECK_OCR_STATUS_15 == 1){
        
        // 取得日（二・小・原）の妥当性確認
        if (![responseDic[@"NAME_CHECK"] isEqualToString:@"0"]) {
            return NO;
        }
    }
    if (configDB.CHECK_OCR_STATUS_16 == 1){
        
        // 取得日（他）の妥当性確認
        if (![responseDic[@"NAME_CHECK"] isEqualToString:@"0"]) {
            return NO;
        }
    }
    if (configDB.CHECK_OCR_STATUS_17 == 1){
        
        // 取得日（二種）の妥当性確認
        if (![responseDic[@"NAME_CHECK"] isEqualToString:@"0"]) {
            return NO;
        }
    }
    if (configDB.CHECK_OCR_STATUS_18 == 1){
        
        // 公安委員会の妥当性確認
        if (![responseDic[@"NAME_CHECK"] isEqualToString:@"0"]) {
            return NO;
        }
    }
    if (configDB.CHECK_OCR_STATUS_19 == 1){
        
        // 運転免許証番号の妥当性確認
        if (![responseDic[@"NAME_CHECK"] isEqualToString:@"0"]) {
            return NO;
        }
    }
    return YES;
}
@end
