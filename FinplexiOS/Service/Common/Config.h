//
//  Config.h
//  demoApp
//
//  Created by agilet-ryu on 2019/7/17.
//  Copyright © 2019 fujitsu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 顔照合の結果をOKとする他人受入率（FAR）の閾値を1～4で指定
 
 - FARTypeLevelOne: 1：1/1,000
 - FARTypeLevelTwo: 2：1/10,000
 - FARTypeLevelThree: 3：1/100,000
 - FARTypeLevelFour: 4：1/1,000,000
 */
typedef NS_ENUM(NSUInteger, FARType) {
    FARTypeLevelOne = 1,
    FARTypeLevelTwo = 2,
    FARTypeLevelThree = 3,
    FARTypeLevelFour = 4
};

/**
 ライブラリの実行結果として受け取る画像の形式を1～4で指定
 
 - ImageTypeJPEG: 1：JPEG（バイナリデータ）
 - ImageTypeJPEGBase64: 2：JPEG（Base64文字列）
 */
typedef NS_ENUM(NSUInteger, ImageType) {
    ImageTypeJPEG = 1,
    ImageTypeJPEGBase64 = 2,
};

/**
 情報を照合履歴として保持するか否かを指定、1の場合のみ、管理画面で情報の参照が可能
 
 - saveTypeNOTSaveInDB: 0：保持しない
 - saveTypeSaveInDB: 1：保持する
 */
typedef NS_ENUM(NSUInteger, saveType) {
    saveTypeNOTSaveInDB = 0,
    saveTypeSaveInDB = 1
};

@interface Config : NSObject
@property (nonatomic, strong) NSString *API_SECRET;  // 管理コンソールで発行のAPIキーを指定
@property (nonatomic, assign) FARType THREHOLDS_LEVEL;  // 顔照合の結果をOKとする他人受入率（FAR）の閾値を1～4で指定
@property (nonatomic, strong) NSString *UUID;  // 端末上で動作するアプリケーションを一意に識別する文字列を指定
@property (nonatomic, assign) ImageType IMAGE_TYPE;  // ライブラリの実行結果として受け取る画像の形式を1～2で指定
//@property (nonatomic, assign) saveType VERIFY_IMAGE_FLAG;  // 照合画像を照合履歴として保持するか否かを指定
//@property (nonatomic, assign) saveType SAVE_IMAGE_FLG;  // 本人確認書類の撮影画像を照合履歴として保持するか否かを指定
//@property (nonatomic, assign) saveType THICKNESS_VIDEO_FLG;  // 本人確認書類の厚み撮影動画を照合履歴として保持するか否かを指定
@property (nonatomic, assign) saveType NAME_FLG;  // 運転免許証からOCRした氏名情報を照合履歴として保持するか否かを指定
@property (nonatomic, assign) saveType KANA_FLG;  // 運転免許証からOCRした氏名カナ情報を照合履歴として保持するか否かを指定
@property (nonatomic, assign) saveType BIRTH_FLG;  // 運転免許証からOCRした生年月日情報を照合履歴として保持するか否かを指定
@property (nonatomic, assign) saveType PERMANENT_ADDRESS_FLG;  // 運転免許証からOCRした本籍地情報を照合履歴として保持するか否かを指定
@property (nonatomic, assign) saveType ADDRESS_FLG;  // 運転免許証からOCRした住所情報を照合履歴として保持するか否かを指定
@property (nonatomic, assign) saveType ISSUANCE_DATE_FLG;  // 運転免許証からOCRした交付日情報を照合履歴として保持するか否かを指定
@property (nonatomic, assign) saveType BAND_COLOR_FLG;  // 運転免許証からOCRした有効期限帯色を照合履歴として保持するか否かを指定
@property (nonatomic, assign) saveType NUMBER_FLG;  // 運転免許証からOCRした運転免許証番号を照合履歴として保持するか否かを指定
@property (nonatomic, assign) saveType EXPIRATION_FLG;  // 運転免許証からOCRした有効期限を照合履歴として保持するか否かを指定
@property (nonatomic, assign) saveType TYPE_FLG;  // 運転免許証からOCRした運転免許種類を照合履歴として保持するか否かを指定
@property (nonatomic, assign) saveType COMMISSION_FLG;  // 運転免許証からOCRした公安委員会を照合履歴として保持するか否かを指定
@property (nonatomic, assign) saveType CONDITION_FLG;  // 運転免許証からOCRした免許の条件等を照合履歴として保持するか否かを指定
@property (nonatomic, assign) saveType DATE_NIKOGEN_FLG;  // 運転免許証からOCRした取得日（二・小・原）を照合履歴として保持するか否かを指定
@property (nonatomic, assign) saveType DATE_OTHER_FLG;  // 運転免許証からOCRした取得日（他）を照合履歴として保持するか否かを指定
@property (nonatomic, assign) saveType DATE_SECOND_FLG;  // 運転免許証からOCRした取得日（二種）を照合履歴として保持するか否かを指定
@property (nonatomic, assign) saveType SEX_FLG;  // 運転免許証からOCRした性別を照合履歴として保持するか否かを指定
@property (nonatomic, assign) saveType GEOLOCATION_FLG;  // 端末のGPSから取得した位置情報を照合履歴として保持するか否かを指定
@property (nonatomic, assign) saveType OTHER_FLG;  // 上記以外の本人確認書類から取得した情報を照合履歴として保持するか否かを指定
@property (nonatomic, strong) NSString *BIZ_NO;  // 呼出元アプリから自由に設定項目。管理画面に登録する場合、設定
@end

NS_ASSUME_NONNULL_END
