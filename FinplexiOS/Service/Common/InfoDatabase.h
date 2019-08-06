//
//  InfoDatabase.h
//  demoApp
//
//  Created by agilet-ryu on 2019/7/16.
//  Copyright © 2019 fujitsu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Config.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - <#本人確認内容データ#>
/**
 共通領域ID : C-CD-001
 共通領域名 : 本人確認内容データ
 */
@interface IDENTIFICATION_DATA : NSObject
@property (nonatomic, assign) int DOC_TYPE;  // 本人確認書類区分
@property (nonatomic, assign) int GAIN_TYPE;  // 読取方法
@property (nonatomic, strong) NSString *SDK_RESULT;  // "オンライン本人確認結果認証処理結果"
@property (nonatomic, strong) NSString *RESULT;  // 顔照合結果
@property (nonatomic, strong) NSString *SCORE;  // 照合スコア
@property (nonatomic, strong) NSString *FAR;  //  他人受入率（FAR）
@property (nonatomic, strong) NSString *FRR;  // 本人拒否入率（FRR）
@property (nonatomic, strong) UIImage *PHOTO_IMG;  // 照合画像１
@property (nonatomic, strong) NSData *CAMERA_IMG;  // 照合画像２
@property (nonatomic, strong) UIImage *OBVERSE_IMG;  // 本人確認書類画像１
@property (nonatomic, strong) UIImage *REVERSE_IMG;  // 本人確認書類画像２
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
@property (nonatomic, strong) NSString *POSITION_IMAGE_X1;  // 「顔写真位置情報(LT_X)」
@property (nonatomic, strong) NSString *POSITION_IMAGE_Y1;  // 「顔写真位置情報(LT_Y)」
@property (nonatomic, strong) NSString *POSITION_IMAGE_X2;  // 「顔写真位置情報(RB_X)」
@property (nonatomic, strong) NSString *POSITION_IMAGE_Y2;  // 「顔写真位置情報(RB_Y」
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
@property (nonatomic, assign) BOOL IMG_CROPPING1;  // 本人確認書類切り出し状態1
@property (nonatomic, assign) BOOL IMG_CROPPING2;  // 本人確認書類切り出し状態2
@property (nonatomic, strong) NSString *PHOTO_POSITION;  // 顔写真位置情報
@property (nonatomic, strong) NSString *THICKNESS_VIDEO;  // 厚み撮影動画
@property (nonatomic, strong) NSString *FACEID_SIGNATURE;  // FaceID電子署名
@property (nonatomic, strong) NSString *CALL_ID;  // CallID
@property (nonatomic, strong) NSString *EXPIRATION_DATE;  // 有効期限判定用日付
@property (nonatomic, strong) NSString *BIZ_TOKEN;  // "顔照合認証トークンFaceID認証トークン"
@property (nonatomic, strong) NSString *REQUEST_ID;  // リクエストID
@property (nonatomic, assign) int LOG_OUTPUT;  // 操作ログ書出回数
@property (nonatomic, assign) int OCR_REQUEST;  // OCRリクエスト回数
@property (nonatomic, assign) int MOTION_RETRY_COUNT;  // 顔モーションTry済み回数
@property (nonatomic, assign) int VIDEO_OK_RETRY_COUNT;  //厚み撮影Try済み回数(OK)
@property (nonatomic, assign) int VIDEO_NG_RETRY_COUNT;  //厚み撮影Try済み回数(NG)
@property (nonatomic, strong) NSString *JOURNAL_RESULT;  // 照合履歴紐付けテーブル用顔照合結果
@property (nonatomic, strong) NSString *VERIFY_RESULT;  // 照合結果
@end

#pragma mark - <#設定ファイルデータ#>
/**
 共通領域ID : C-CD-002
 共通領域名 : 設定ファイルデータ
 */
@interface CONFIG_FILE_DATA : NSObject
@property (nonatomic, assign) int IDENTIFICATION_DOCUMENT_DRIVERS_LICENCE;  // 本人確認書類（運転免許証）フラグ
@property (nonatomic, assign) int IDENTIFICATION_DOCUMENT_MYNUMBER;  // 本人確認書類（マイナンバーカード）フラグ
@property (nonatomic, assign) int IDENTIFICATION_DOCUMENT_PASSPORT;  // 本人確認書類（パスポート）フラグ
@property (nonatomic, assign) int IDENTIFICATION_DOCUMENT_RESIDENCE;  // 本人確認書類（在留カード）フラグ
@property (nonatomic, assign) int IDENTIFICATION_DOCUMENT_SPECIAL_PERMANENT_RESIDENT_CERTIFICATE;  // 本人確認書類（特別永住者証明書）フラグ
@property (nonatomic, assign) int CAMERA_ENABLE;  // カメラ撮影有効化フラグ
@property (nonatomic, assign) int OCR_ENABLE;  // OCR機能有効化フラグ
@property (nonatomic, assign) int CHECK_OCR_STATUS_1;  // 氏名の妥当性確認
@property (nonatomic, assign) int CHECK_OCR_STATUS_2;  // 氏名（カナ）の妥当性確認
@property (nonatomic, assign) int CHECK_OCR_STATUS_3;  // 住所の妥当性確認
@property (nonatomic, assign) int CHECK_OCR_STATUS_4;  // 生年月日の妥当性確認
@property (nonatomic, assign) int CHECK_OCR_STATUS_5;  // 本籍地の妥当性確認
@property (nonatomic, assign) int CHECK_OCR_STATUS_6;  // 運転免許種類の妥当性確認
@property (nonatomic, assign) int CHECK_OCR_STATUS_7;  // 有効期限帯色の妥当性確認
@property (nonatomic, assign) int CHECK_OCR_STATUS_8;  // 性別の妥当性確認
@property (nonatomic, assign) int CHECK_OCR_STATUS_9;  // 交付日の妥当性確認
@property (nonatomic, assign) int CHECK_OCR_STATUS_10;  // 免許種類の枠数の妥当性確認
@property (nonatomic, assign) int CHECK_OCR_STATUS_11;  // 免許の条件等1の妥当性確認
@property (nonatomic, assign) int CHECK_OCR_STATUS_12;  // 免許の条件等2の妥当性確認
@property (nonatomic, assign) int CHECK_OCR_STATUS_13;  // 免許の条件等3の妥当性確認
@property (nonatomic, assign) int CHECK_OCR_STATUS_14;  // 免許の条件等4の妥当性確認
@property (nonatomic, assign) int CHECK_OCR_STATUS_15;  // 取得日（二・小・原）の妥当性確認
@property (nonatomic, assign) int CHECK_OCR_STATUS_16;  // 取得日（他）の妥当性確認
@property (nonatomic, assign) int CHECK_OCR_STATUS_17;  // 取得日（二種）の妥当性確認
@property (nonatomic, assign) int CHECK_OCR_STATUS_18;  // 公安委員会の妥当性確認
@property (nonatomic, assign) int CHECK_OCR_STATUS_19;  // 運転免許証番号の妥当性確認
@property (nonatomic, assign) int NFC_ENABLE;  // NFC機能有効化フラグ
@property (nonatomic, assign) int SHOOT_THICKNESS_ENABLE;  // 厚み撮影機能有効化フラグ
@property (nonatomic, assign) int MANGEMENT_CONSOL_USE;  // 管理コンソール利用フラグ
@property (nonatomic, assign) int LIVENESS_ACTION_LIMIT;  // 顔モーションre-Try回数
@property (nonatomic, assign) int SHOOT_THICKNESS_LIMIT;  // 厚み撮影re-Try回数
@property (nonatomic, assign) int OCR_LIMIT;  // サーバOCRre-Try回数
@property (nonatomic, assign) NSString *LIVENESS_TYPE;  // モーションタイプ
@property (nonatomic, assign) NSString *LIVENESS_TIMEOUT;  // タイムアウト設定時間
@property (nonatomic, assign) NSString *LIVENESS_ACTION_COUNT;  // モーションパターン回数
@property (nonatomic, assign) NSString *GW_API_KEY;  // API Gateway APIキー
@property (nonatomic, assign) NSString *MAIN_ACCOUNT;  // 事業者ID
@property (nonatomic, assign) int LOG_OUTPUT_LIMIT;  // 操作ログ書出回数上限
@property (nonatomic, assign) int IMG_MASK;  // 本人確認書類画像マスクフラグ
@property (nonatomic, assign) int SAVE_IMAGE_FLG;  // 画像保存フラグ
@end

#pragma mark - <#共通領域のデータ#>
/**
 共通領域のデータ
 */
@interface InfoDatabase : NSObject
@property (nonatomic, strong) IDENTIFICATION_DATA *identificationData;  // 本人確認内容データ
@property (nonatomic, strong) CONFIG_FILE_DATA *configFileData;  // 設定ファイルデータ
@property (nonatomic, strong) Config *startParam;  // 起動パラメータ
@property (nonatomic, strong) NSMutableArray *eventLogs;  // 操作ログ配列

/**
 InfoDatabase初期化
 
 @return InfoDatabase
 */
+ (instancetype)shareInfoDatabase;
@end

NS_ASSUME_NONNULL_END
