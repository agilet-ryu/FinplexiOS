//
//  ResultModel.h
//  demoApp
//
//  Created by agilet-ryu on 2019/7/17.
//  Copyright © 2019 fujitsu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ResultModel : NSObject
@property (nonatomic, strong) NSString *SDK_RESULT;  // "オンライン本人確認結果認証処理結果"
@property (nonatomic, strong) NSString *RESULT;  // 顔照合結果
@property (nonatomic, strong) NSString *SCORE;  // 照合スコア
@property (nonatomic, strong) NSString *FAR;  //  他人受入率（FAR）
@property (nonatomic, strong) NSString *FRR;  // 本人拒否入率（FRR）
@property (nonatomic, strong) NSString *IDENTIFICATION_DOCUMENT;  // 本人確認書類区分
@property (nonatomic, strong) NSString *READ_METHOD;  // 照合画像取得方法
@property (nonatomic, strong) NSString *PHOTO_IMG;  // 照合画像１
@property (nonatomic, strong) NSString *CAMERA_IMG;  // 照合画像２
@property (nonatomic, strong) NSString *OBVERSE_IMG;  // 本人確認書類画像１
@property (nonatomic, strong) NSString *REVERSE_IMG;  // 本人確認書類画像２
@property (nonatomic, strong) NSString *NAME;  // 氏名
@property (nonatomic, strong) NSString *KANA;  // 氏名（カナ）
@property (nonatomic, strong) NSString *ADDRESS;  // 住所
@property (nonatomic, strong) NSString *BIRTH;  // 生年月日
@property (nonatomic, strong) NSString *NUMBER;  // 運転免許証番号
@property (nonatomic, strong) NSString *PERMANENT_ADDRESS;  // 本籍地
@property (nonatomic, strong) NSString *TYPE;  // 運転免許種類
@property (nonatomic, strong) NSString *BAND_COLOR;  // 有効期限帯色
@property (nonatomic, strong) NSString *GENDER;  // 性別
@property (nonatomic, strong) NSString *EXPIRATION;  // 有効期限
@property (nonatomic, strong) NSString *ISSUANCE_DATE;  // 交付日
@property (nonatomic, strong) NSString *TYPE_NUM;  // 免許種類の枠数
@property (nonatomic, strong) NSString *CONDITION_1;  // 免許の条件等1
@property (nonatomic, strong) NSString *CONDITION_2;  // 免許の条件等2
@property (nonatomic, strong) NSString *CONDITION_3;  // 免許の条件等3
@property (nonatomic, strong) NSString *CONDITION_4;  // 免許の条件等4
@property (nonatomic, strong) NSString *DATE_NIKOGEN;  // 取得日（二・小・原）
@property (nonatomic, strong) NSString *DATE_OTHER;  // 取得日（他）
@property (nonatomic, strong) NSString *DATE_SECOND;  // 取得日（二種）
@property (nonatomic, strong) NSString *COMMISSION;  // 公安委員会
@property (nonatomic, strong) NSString *COMMON_NAME;  // NFC_運_通称名
@property (nonatomic, strong) NSString *UNIFY_NAME;  // NFC_運_統一氏名（カナ）
@property (nonatomic, strong) NSString *REFERENCE_NUMBER;  // NFC_運_照会番号
@property (nonatomic, strong) NSString *DATE_OGATA;  // NFC_運_取得日（大型）
@property (nonatomic, strong) NSString *DATE_FUTSU;  // NFC_運_取得日（普通）
@property (nonatomic, strong) NSString *DATE_OTOKU;  // NFC_運_取得日（大特）
@property (nonatomic, strong) NSString *DATE_DAIJINI;  // NFC_運_取得日（大自二）
@property (nonatomic, strong) NSString *DATE_FUJINI;  // NFC_運_取得日（普自二）
@property (nonatomic, strong) NSString *DATE_KOTOKU;  // NFC_運_取得日（小特）
@property (nonatomic, strong) NSString *DATE_GEN;  // NFC_運_取得日（原付）
@property (nonatomic, strong) NSString *DATE_KEIN;  // NFC_運_取得日（け引）
@property (nonatomic, strong) NSString *DATE_DAINI;  // NFC_運_取得日（大二）
@property (nonatomic, strong) NSString *DATE_FUNI;  // NFC_運_取得日（普二）
@property (nonatomic, strong) NSString *DATE_DAITOKUNI;  // NFC_運_取得日（大特二）
@property (nonatomic, strong) NSString *DATE_KEINNI;  // NFC_運_取得日（け引二）
@property (nonatomic, strong) NSString *DATE_CHUGATA;  // NFC_運_取得日（中型）
@property (nonatomic, strong) NSString *DATE_CHUNI;  // NFC_運_取得日（中二）
@property (nonatomic, strong) NSString *DATE_JUNCHUGATA;  // NFC_運_取得日（準中型）
@property (nonatomic, strong) NSString *JIS_X_0208_NUM;  // NFC_運_JIS X 0208 制定年番号
@property (nonatomic, strong) NSString *NEW_COMMISSION_1;  // NFC_運_新公安委員会1
@property (nonatomic, strong) NSString *NEW_COMMISSION_2;  // NFC_運_新公安委員会2
@property (nonatomic, strong) NSString *NEW_COMMISSION_3;  // NFC_運_新公安委員会3
@property (nonatomic, strong) NSString *NEW_COMMISSION_4;  // NFC_運_新公安委員会4
@property (nonatomic, strong) NSString *NEW_COMMISSION_5;  // NFC_運_新公安委員会5
@property (nonatomic, strong) NSString *NEW_COMMISSION_6;  // NFC_運_新公安委員会6
@property (nonatomic, strong) NSString *NEW_COMMISSION_7;  // NFC_運_新公安委員会7
@property (nonatomic, strong) NSString *NEW_COMMISSION_8;  // NFC_運_新公安委員会8
@property (nonatomic, strong) NSString *NEW_COMMISSION_9;  // NFC_運_新公安委員会9
@property (nonatomic, strong) NSString *NEW_COMMISSION_10;  // NFC_運_新公安委員会10
@property (nonatomic, strong) NSString *NEW_COMMISSION_11;  // NFC_運_新公安委員会11
@property (nonatomic, strong) NSString *NEW_COMMISSION_12;  // NFC_運_新公安委員会12
@property (nonatomic, strong) NSString *NEW_COMMISSION_13;  // NFC_運_新公安委員会13
@property (nonatomic, strong) NSString *NEW_COMMISSION_14;  // NFC_運_新公安委員会14
@property (nonatomic, strong) NSString *NEW_COMMISSION_15;  // NFC_運_新公安委員会15
@property (nonatomic, strong) NSString *NEW_NAME_1;  // NFC_運_新氏名1
@property (nonatomic, strong) NSString *NEW_NAME_2;  // NFC_運_新氏名2
@property (nonatomic, strong) NSString *NEW_NAME_3;  // NFC_運_新氏名3
@property (nonatomic, strong) NSString *NEW_NAME_4;  // NFC_運_新氏名4
@property (nonatomic, strong) NSString *NEW_NAME_5;  // NFC_運_新氏名5
@property (nonatomic, strong) NSString *NEW_NAME_6;  // NFC_運_新氏名6
@property (nonatomic, strong) NSString *NEW_NAME_7;  // NFC_運_新氏名7
@property (nonatomic, strong) NSString *NEW_NAME_8;  // NFC_運_新氏名8
@property (nonatomic, strong) NSString *NEW_KANA_1;  // NFC_運_新氏名（カナ）1
@property (nonatomic, strong) NSString *NEW_KANA_2;  // NFC_運_新氏名（カナ）2
@property (nonatomic, strong) NSString *NEW_KANA_3;  // NFC_運_新氏名（カナ）3
@property (nonatomic, strong) NSString *NEW_KANA_4;  // NFC_運_新氏名（カナ）4
@property (nonatomic, strong) NSString *NEW_KANA_5;  // NFC_運_新氏名（カナ）5
@property (nonatomic, strong) NSString *NEW_KANA_6;  // NFC_運_新氏名（カナ）6
@property (nonatomic, strong) NSString *NEW_KANA_7;  // NFC_運_新氏名（カナ）7
@property (nonatomic, strong) NSString *NEW_KANA_8;  // NFC_運_新氏名（カナ）8
@property (nonatomic, strong) NSString *NEW_ADDRESS_1;  // NFC_運_新住所1
@property (nonatomic, strong) NSString *NEW_ADDRESS_2;  // NFC_運_新住所2
@property (nonatomic, strong) NSString *NEW_ADDRESS_3;  // NFC_運_新住所3
@property (nonatomic, strong) NSString *NEW_ADDRESS_4;  // NFC_運_新住所4
@property (nonatomic, strong) NSString *NEW_ADDRESS_5;  // NFC_運_新住所5
@property (nonatomic, strong) NSString *NEW_ADDRESS_6;  // NFC_運_新住所6
@property (nonatomic, strong) NSString *NEW_ADDRESS_7;  // NFC_運_新住所7
@property (nonatomic, strong) NSString *NEW_ADDRESS_8;  // NFC_運_新住所8
@property (nonatomic, strong) NSString *NEW_CONDITION_1;  // NFC_運_新条件1
@property (nonatomic, strong) NSString *NEW_CONDITION_2;  // NFC_運_新条件2
@property (nonatomic, strong) NSString *NEW_CONDITION_3;  // NFC_運_新条件3
@property (nonatomic, strong) NSString *NEW_CONDITION_4;  // NFC_運_新条件4
@property (nonatomic, strong) NSString *NEW_CONDITION_5;  // NFC_運_新条件5
@property (nonatomic, strong) NSString *NEW_CONDITION_6;  // NFC_運_新条件6
@property (nonatomic, strong) NSString *NEW_CONDITION_7;  // NFC_運_新条件7
@property (nonatomic, strong) NSString *NEW_CONDITION_8;  // NFC_運_新条件8
@property (nonatomic, strong) NSString *CONDITION_CANCEL_1;  // NFC_運_条件解除1
@property (nonatomic, strong) NSString *CONDITION_CANCEL_2;  // NFC_運_条件解除2
@property (nonatomic, strong) NSString *CONDITION_CANCEL_3;  // NFC_運_条件解除3
@property (nonatomic, strong) NSString *CONDITION_CANCEL_4;  // NFC_運_条件解除4
@property (nonatomic, strong) NSString *CONDITION_CANCEL_5;  // NFC_運_条件解除5
@property (nonatomic, strong) NSString *CONDITION_CANCEL_6;  // NFC_運_条件解除6
@property (nonatomic, strong) NSString *CONDITION_CANCEL_7;  // NFC_運_条件解除7
@property (nonatomic, strong) NSString *CONDITION_CANCEL_8;  // NFC_運_条件解除8
@property (nonatomic, strong) NSString *REMARKS_1;  // NFC_運_備考1
@property (nonatomic, strong) NSString *REMARKS_2;  // NFC_運_備考2
@property (nonatomic, strong) NSString *REMARKS_3;  // NFC_運_備考3
@property (nonatomic, strong) NSString *REMARKS_4;  // NFC_運_備考4
@property (nonatomic, strong) NSString *REMARKS_5;  // NFC_運_備考5
@property (nonatomic, strong) NSString *REMARKS_6;  // NFC_運_備考6
@property (nonatomic, strong) NSString *REMARKS_7;  // NFC_運_備考7
@property (nonatomic, strong) NSString *REMARKS_8;  // NFC_運_備考8
@property (nonatomic, strong) NSString *RESERVE_1;  // NFC_運_予備1
@property (nonatomic, strong) NSString *RESERVE_2;  // NFC_運_予備2
@property (nonatomic, strong) NSString *RESERVE_3;  // NFC_運_予備3
@property (nonatomic, strong) NSString *RESERVE_4;  // NFC_運_予備4
@property (nonatomic, strong) NSString *RESERVE_5;  // NFC_運_予備5
@property (nonatomic, strong) NSString *RESERVE_6;  // NFC_運_予備6
@property (nonatomic, strong) NSString *RESERVE_7;  // NFC_運_予備7
@property (nonatomic, strong) NSString *RESERVE_8;  // NFC_運_予備8
@property (nonatomic, strong) NSString *NEW_PERMANENT_ADDRESS_1;  // NFC_運_新本籍1
@property (nonatomic, strong) NSString *NEW_PERMANENT_ADDRESS_2;  // NFC_運_新本籍2
@property (nonatomic, strong) NSString *NEW_PERMANENT_ADDRESS_3;  // NFC_運_新本籍3
@property (nonatomic, strong) NSString *NEW_PERMANENT_ADDRESS_4;  // NFC_運_新本籍4
@property (nonatomic, strong) NSString *NEW_PERMANENT_ADDRESS_5;  // NFC_運_新本籍5
@property (nonatomic, strong) NSString *SERIAL_NUM;  // NFC_運_シリアル番号
@property (nonatomic, strong) NSString *ISSUER;  // NFC_運_発行者名
@property (nonatomic, strong) NSString *MAIN_PERSON;  // NFC_運_主体者名
@property (nonatomic, strong) NSString *MAIN_PERSON_ID;  // NFC_運_主体者鍵識別子
@property (nonatomic, strong) NSString *LATITUDE;  // 位置情報（緯度）
@property (nonatomic, strong) NSString *LONGITUDE;  // 位置情報（経度）
@property (nonatomic, strong) NSString *ERROR_CODE;  // エラーコード

+ (instancetype)shareResultModel;
@end

NS_ASSUME_NONNULL_END
