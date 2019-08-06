//
//  LibraryEnd.m
//  demoApp
//
//  Created by agilet-ryu on 2019/8/2.
//  Copyright © 2019 fujitsu. All rights reserved.
//

#import "LibraryEnd.h"
#import "InfoDatabase.h"
#import "ResultModel.h"

@implementation LibraryEnd

static InfoDatabase *db = nil;
static LibraryEnd *manager = nil;

+ (instancetype)initService{
    db = [InfoDatabase shareInfoDatabase];
    manager = [[LibraryEnd alloc] init];
    return manager;
}

- (void)setResultModel{
    ResultModel *result = [ResultModel shareResultModel];
    IDENTIFICATION_DATA *data = db.identificationData;
    if ([data.SDK_RESULT isEqualToString:@"異常"] || [data.SDK_RESULT isEqualToString:@"中断"]) {
        
        // 共通領域.本人確認内容データ.オンライン本人確認結果が「中断」または「異常」の場合
        // 処理結果応答内の「オンライン本人確認結果」「エラーコード」に共通領域に保存済みの値を設定する。
        result.SDK_RESULT = db.identificationData.SDK_RESULT;
        result.ERROR_CODE = db.identificationData.ERROR_CODE;
    }else{
        
        // 共通領域.本人確認内容データ.オンライン本人確認結果が「正常」の場合
        if ([data.RESULT isEqualToString:@"1"]) {
            
            // 共通領域.本人確認内容データ.顔照合結果が「1:成功」の場合
            // 処理結果応答内の各項目に共通領域に保存済みの値を設定する。
            result.SDK_RESULT = data.SDK_RESULT;  // "オンライン本人確認結果認証処理結果"
            result.RESULT = data.RESULT;  // 顔照合結果
            result.SCORE = data.SCORE;  // 照合スコア
            result.FAR = data.FAR;  //  他人受入率（FAR）
            result.FRR = data.FRR;  // 本人拒否入率（FRR）
            result.IDENTIFICATION_DOCUMENT = [NSString stringWithFormat:@"%d", data.DOC_TYPE];  // 本人確認書類区分
            result.READ_METHOD = [NSString stringWithFormat:@"%d", data.GAIN_TYPE];  // 照合画像取得方法
#warning TODO 是否进行图像格式转换
//            result.PHOTO_IMG = data.SDK_RESULT;  // 照合画像１
//            result.CAMERA_IMG = data.SDK_RESULT;  // 照合画像２
//            result.OBVERSE_IMG = data.SDK_RESULT;  // 本人確認書類画像１
//            result.REVERSE_IMG = data.SDK_RESULT;  // 本人確認書類画像２
            result.NAME = data.NAME;  // 氏名
            result.KANA = data.KANA;  // 氏名（カナ）
            result.ADDRESS = data.ADDRESS;  // 住所
            result.BIRTH = data.BIRTH;  // 生年月日
            result.NUMBER = data.NUMBER;  // 運転免許証番号
            result.PERMANENT_ADDRESS = data.PERMANENT_ADDRESS;  // 本籍地
            result.TYPE = data.TYPE;  // 運転免許種類
            result.BAND_COLOR = data.BAND_COLOR;  // 有効期限帯色
            result.GENDER = data.GENDER;  // 性別
            result.EXPIRATION = data.EXPIRATION;  // 有効期限
            result.ISSUANCE_DATE = data.ISSUANCE_DATE;  // 交付日
            result.TYPE_NUM = data.TYPE_NUM;  // 免許種類の枠数
            result.CONDITION_1 = data.CONDITION_1;  // 免許の条件等1
            result.CONDITION_2 = data.CONDITION_2;  // 免許の条件等2
            result.CONDITION_3 = data.CONDITION_3;  // 免許の条件等3
            result.CONDITION_4 = data.CONDITION_4;  // 免許の条件等4
            result.DATE_NIKOGEN = data.DATE_NIKOGEN;  // 取得日（二・小・原）
            result.DATE_OTHER = data.DATE_OTHER;  // 取得日（他）
            result.DATE_SECOND = data.DATE_SECOND;  // 取得日（二種）
            result.COMMISSION = data.COMMISSION;  // 公安委員会
            result.COMMON_NAME = data.COMMON_NAME;  // NFC_運_通称名
            result.UNIFY_NAME = data.UNIFY_NAME;  // NFC_運_統一氏名（カナ）
            result.REFERENCE_NUMBER = data.REFERENCE_NUMBER;  // NFC_運_照会番号
            result.DATE_OGATA = data.DATE_OGATA;  // NFC_運_取得日（大型）
            result.DATE_FUTSU = data.DATE_FUTSU;  // NFC_運_取得日（普通）
            result.DATE_OTOKU = data.DATE_OTOKU;  // NFC_運_取得日（大特）
            result.DATE_DAIJINI = data.DATE_DAIJINI;  // NFC_運_取得日（大自二）
            result.DATE_FUJINI = data.DATE_FUJINI;  // NFC_運_取得日（普自二）
            result.DATE_KOTOKU = data.DATE_KOTOKU;  // NFC_運_取得日（小特）
            result.DATE_GEN = data.DATE_GEN;  // NFC_運_取得日（原付）
            result.DATE_KEIN = data.DATE_KEIN;  // NFC_運_取得日（け引）
            result.DATE_DAINI = data.DATE_DAINI;  // NFC_運_取得日（大二）
            result.DATE_FUNI = data.DATE_FUNI;  // NFC_運_取得日（普二）
            result.DATE_DAITOKUNI = data.DATE_DAITOKUNI;  // NFC_運_取得日（大特二）
            result.DATE_KEINNI = data.DATE_KEINNI;  // NFC_運_取得日（け引二）
            result.DATE_CHUGATA = data.DATE_CHUGATA;  // NFC_運_取得日（中型）
            result.DATE_CHUNI = data.DATE_CHUNI;  // NFC_運_取得日（中二）
            result.DATE_JUNCHUGATA = data.DATE_JUNCHUGATA;  // NFC_運_取得日（準中型）
            result.JIS_X_0208_NUM = data.JIS_X_0208_NUM;  // NFC_運_JIS X 0208 制定年番号
            result.NEW_COMMISSION_1 = data.NEW_COMMISSION_1;  // NFC_運_新公安委員会1
            result.NEW_COMMISSION_2 = data.NEW_COMMISSION_2;  // NFC_運_新公安委員会2
            result.NEW_COMMISSION_3 = data.NEW_COMMISSION_3;  // NFC_運_新公安委員会3
            result.NEW_COMMISSION_4 = data.NEW_COMMISSION_4;  // NFC_運_新公安委員会4
            result.NEW_COMMISSION_5 = data.NEW_COMMISSION_5;  // NFC_運_新公安委員会5
            result.NEW_COMMISSION_6 = data.NEW_COMMISSION_6;  // NFC_運_新公安委員会6
            result.NEW_COMMISSION_7 = data.NEW_COMMISSION_7;  // NFC_運_新公安委員会7
            result.NEW_COMMISSION_8 = data.NEW_COMMISSION_8;  // NFC_運_新公安委員会8
            result.NEW_COMMISSION_9 = data.NEW_COMMISSION_9;  // NFC_運_新公安委員会9
            result.NEW_COMMISSION_10 = data.NEW_COMMISSION_10;  // NFC_運_新公安委員会10
            result.NEW_COMMISSION_11 = data.NEW_COMMISSION_11;  // NFC_運_新公安委員会11
            result.NEW_COMMISSION_12 = data.NEW_COMMISSION_12;  // NFC_運_新公安委員会12
            result.NEW_COMMISSION_13 = data.NEW_COMMISSION_13;  // NFC_運_新公安委員会13
            result.NEW_COMMISSION_14 = data.NEW_COMMISSION_14;  // NFC_運_新公安委員会14
            result.NEW_COMMISSION_15 = data.NEW_COMMISSION_15;  // NFC_運_新公安委員会15
            result.NEW_NAME_1 = data.NEW_NAME_1;  // NFC_運_新氏名1
            result.NEW_NAME_2 = data.NEW_NAME_2;  // NFC_運_新氏名2
            result.NEW_NAME_3 = data.NEW_NAME_3;  // NFC_運_新氏名3
            result.NEW_NAME_4 = data.NEW_NAME_4;  // NFC_運_新氏名4
            result.NEW_NAME_5 = data.NEW_NAME_5;  // NFC_運_新氏名5
            result.NEW_NAME_6 = data.NEW_NAME_6;  // NFC_運_新氏名6
            result.NEW_NAME_7 = data.NEW_NAME_7;  // NFC_運_新氏名7
            result.NEW_NAME_8 = data.NEW_NAME_8;  // NFC_運_新氏名8
            result.NEW_KANA_1 = data.NEW_KANA_1;  // NFC_運_新氏名（カナ）1
            result.NEW_KANA_2 = data.NEW_KANA_2;  // NFC_運_新氏名（カナ）2
            result.NEW_KANA_3 = data.NEW_KANA_3;  // NFC_運_新氏名（カナ）3
            result.NEW_KANA_4 = data.NEW_KANA_4;  // NFC_運_新氏名（カナ）4
            result.NEW_KANA_5 = data.NEW_KANA_5;  // NFC_運_新氏名（カナ）5
            result.NEW_KANA_6 = data.NEW_KANA_6;  // NFC_運_新氏名（カナ）6
            result.NEW_KANA_7 = data.NEW_KANA_7;  // NFC_運_新氏名（カナ）7
            result.NEW_KANA_8 = data.NEW_KANA_8;  // NFC_運_新氏名（カナ）8
            result.NEW_ADDRESS_1 = data.NEW_ADDRESS_1;  // NFC_運_新住所1
            result.NEW_ADDRESS_2 = data.NEW_ADDRESS_2;  // NFC_運_新住所2
            result.NEW_ADDRESS_3 = data.NEW_ADDRESS_3;  // NFC_運_新住所3
            result.NEW_ADDRESS_4 = data.NEW_ADDRESS_4;  // NFC_運_新住所4
            result.NEW_ADDRESS_5 = data.NEW_ADDRESS_5;  // NFC_運_新住所5
            result.NEW_ADDRESS_6 = data.NEW_ADDRESS_6;  // NFC_運_新住所6
            result.NEW_ADDRESS_7 = data.NEW_ADDRESS_7;  // NFC_運_新住所7
            result.NEW_ADDRESS_8 = data.NEW_ADDRESS_8;  // NFC_運_新住所8
            result.NEW_CONDITION_1 = data.NEW_CONDITION_1;  // NFC_運_新条件1
            result.NEW_CONDITION_2 = data.NEW_CONDITION_2;  // NFC_運_新条件2
            result.NEW_CONDITION_3 = data.NEW_CONDITION_3;  // NFC_運_新条件3
            result.NEW_CONDITION_4 = data.NEW_CONDITION_4;  // NFC_運_新条件4
            result.NEW_CONDITION_5 = data.NEW_CONDITION_5;  // NFC_運_新条件5
            result.NEW_CONDITION_6 = data.NEW_CONDITION_6;  // NFC_運_新条件6
            result.NEW_CONDITION_7 = data.NEW_CONDITION_7;  // NFC_運_新条件7
            result.NEW_CONDITION_8 = data.NEW_CONDITION_8;  // NFC_運_新条件8
            result.CONDITION_CANCEL_1 = data.CONDITION_CANCEL_1;  // NFC_運_条件解除1
            result.CONDITION_CANCEL_2 = data.CONDITION_CANCEL_2;  // NFC_運_条件解除2
            result.CONDITION_CANCEL_3 = data.CONDITION_CANCEL_3;  // NFC_運_条件解除3
            result.CONDITION_CANCEL_4 = data.CONDITION_CANCEL_4;  // NFC_運_条件解除4
            result.CONDITION_CANCEL_5 = data.CONDITION_CANCEL_5;  // NFC_運_条件解除5
            result.CONDITION_CANCEL_6 = data.CONDITION_CANCEL_6;  // NFC_運_条件解除6
            result.CONDITION_CANCEL_7 = data.CONDITION_CANCEL_7;  // NFC_運_条件解除7
            result.CONDITION_CANCEL_8 = data.CONDITION_CANCEL_8;  // NFC_運_条件解除8
            result.REMARKS_1 = data.REMARKS_1;  // NFC_運_備考1
            result.REMARKS_2 = data.REMARKS_2;  // NFC_運_備考2
            result.REMARKS_3 = data.REMARKS_3;  // NFC_運_備考3
            result.REMARKS_4 = data.REMARKS_4;  // NFC_運_備考4
            result.REMARKS_5 = data.REMARKS_5;  // NFC_運_備考5
            result.REMARKS_6 = data.REMARKS_6;  // NFC_運_備考6
            result.REMARKS_7 = data.REMARKS_7;  // NFC_運_備考7
            result.REMARKS_8 = data.REMARKS_8;  // NFC_運_備考8
            result.RESERVE_1 = data.RESERVE_1;  // NFC_運_予備1
            result.RESERVE_2 = data.RESERVE_2;  // NFC_運_予備2
            result.RESERVE_3 = data.RESERVE_3;  // NFC_運_予備3
            result.RESERVE_4 = data.RESERVE_4;  // NFC_運_予備4
            result.RESERVE_5 = data.RESERVE_5;  // NFC_運_予備5
            result.RESERVE_6 = data.RESERVE_6;  // NFC_運_予備6
            result.RESERVE_7 = data.RESERVE_7;  // NFC_運_予備7
            result.RESERVE_8 = data.RESERVE_8;  // NFC_運_予備8
            result.NEW_PERMANENT_ADDRESS_1 = data.NEW_PERMANENT_ADDRESS_1;  // NFC_運_新本籍1
            result.NEW_PERMANENT_ADDRESS_2 = data.NEW_PERMANENT_ADDRESS_2;  // NFC_運_新本籍2
            result.NEW_PERMANENT_ADDRESS_3 = data.NEW_PERMANENT_ADDRESS_3;  // NFC_運_新本籍3
            result.NEW_PERMANENT_ADDRESS_4 = data.NEW_PERMANENT_ADDRESS_4;  // NFC_運_新本籍4
            result.NEW_PERMANENT_ADDRESS_5 = data.NEW_PERMANENT_ADDRESS_5;  // NFC_運_新本籍5
            result.SERIAL_NUM = data.SERIAL_NUM;  // NFC_運_シリアル番号
            result.ISSUER = data.ISSUER;  // NFC_運_発行者名
            result.MAIN_PERSON = data.MAIN_PERSON;  // NFC_運_主体者名
            result.MAIN_PERSON_ID = data.MAIN_PERSON_ID;  // NFC_運_主体者鍵識別子
            result.LATITUDE = data.LATITUDE;  // 位置情報（緯度）
            result.LONGITUDE = data.LONGITUDE;  // 位置情報（経度）
        }else{
            
            // 共通領域.本人確認内容データ.顔照合結果が「9:失敗」の場合
            // 処理結果応答内の「オンライン本人確認結果」「顔照合結果」「照合スコア」「他人受入率（FAR）」「照合画像取得方法」「本人確認書類区分」に共通領域に保存済みの値を設定する。
            result.SDK_RESULT = data.SDK_RESULT;
            result.RESULT = data.RESULT;
            result.SCORE = data.SCORE;
            result.FAR = data.FAR;
            result.READ_METHOD = [NSString stringWithFormat:@"%d", data.GAIN_TYPE];
            result.IDENTIFICATION_DOCUMENT = [NSString stringWithFormat:@"%d", data.DOC_TYPE];
        }
    }
    
    // ライブラリ処理結果応答を呼び出し元アプリに返却し、ライブラリを終了する。
    NSDictionary *dict = @{@"key":result};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LibraryEndNotification" object:nil userInfo:dict];
}

@end
