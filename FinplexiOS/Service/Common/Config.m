//
//  Config.m
//  demoApp
//
//  Created by agilet-ryu on 2019/7/17.
//  Copyright © 2019 fujitsu. All rights reserved.
//

#import "Config.h"

@implementation Config

// 運転免許証からOCRした氏名情報を照合履歴として保持するか否かを指定
- (saveType)NAME_FLG{
    if (!_NAME_FLG) {
        _NAME_FLG = saveTypeSaveInDB;
    }
    return _NAME_FLG;
}

// 運転免許証からOCRした氏名カナ情報を照合履歴として保持するか否かを指定
- (saveType)KANA_FLG{
    if (!_KANA_FLG) {
        _KANA_FLG = saveTypeSaveInDB;
    }
    return _KANA_FLG;
}

// 運転免許証からOCRした生年月日情報を照合履歴として保持するか否かを指定
- (saveType)BIRTH_FLG{
    if (!_BIRTH_FLG) {
        _BIRTH_FLG = saveTypeSaveInDB;
    }
    return _BIRTH_FLG;
}

// 運転免許証からOCRした本籍地情報を照合履歴として保持するか否かを指定
- (saveType)PERMANENT_ADDRESS_FLG{
    if (!_PERMANENT_ADDRESS_FLG) {
        _PERMANENT_ADDRESS_FLG = saveTypeSaveInDB;
    }
    return _PERMANENT_ADDRESS_FLG;
}

// 運転免許証からOCRした住所情報を照合履歴として保持するか否かを指定
- (saveType)ADDRESS_FLG{
    if (!_ADDRESS_FLG) {
        _ADDRESS_FLG = saveTypeSaveInDB;
    }
    return _ADDRESS_FLG;
}

// 運転免許証からOCRした交付日情報を照合履歴として保持するか否かを指定
- (saveType)ISSUANCE_DATE_FLG{
    if (!_ISSUANCE_DATE_FLG) {
        _ISSUANCE_DATE_FLG = saveTypeSaveInDB;
    }
    return _ISSUANCE_DATE_FLG;
}

// 運転免許証からOCRした有効期限帯色を照合履歴として保持するか否かを指定
- (saveType)BAND_COLOR_FLG{
    if (!_BAND_COLOR_FLG) {
        _BAND_COLOR_FLG = saveTypeSaveInDB;
    }
    return _BAND_COLOR_FLG;
}

// 運転免許証からOCRした運転免許証番号を照合履歴として保持するか否かを指定
- (saveType)NUMBER_FLG{
    if (!_NUMBER_FLG) {
        _NUMBER_FLG = saveTypeSaveInDB;
    }
    return _NUMBER_FLG;
}

// 運転免許証からOCRした有効期限を照合履歴として保持するか否かを指定
- (saveType)EXPIRATION_FLG{
    if (!_EXPIRATION_FLG) {
        _EXPIRATION_FLG = saveTypeSaveInDB;
    }
    return _EXPIRATION_FLG;
}

// 運転免許証からOCRした運転免許種類を照合履歴として保持するか否かを指定
- (saveType)TYPE_FLG{
    if (!_TYPE_FLG) {
        _TYPE_FLG = saveTypeSaveInDB;
    }
    return _TYPE_FLG;
}

// 運転免許証からOCRした公安委員会を照合履歴として保持するか否かを指定
- (saveType)COMMISSION_FLG{
    if (!_COMMISSION_FLG) {
        _COMMISSION_FLG = saveTypeSaveInDB;
    }
    return _COMMISSION_FLG;
}

// 運転免許証からOCRした免許の条件等を照合履歴として保持するか否かを指定
- (saveType)CONDITION_FLG{
    if (!_CONDITION_FLG) {
        _CONDITION_FLG = saveTypeSaveInDB;
    }
    return _CONDITION_FLG;
}

// 運転免許証からOCRした取得日（二・小・原）を照合履歴として保持するか否かを指定
- (saveType)DATE_NIKOGEN_FLG{
    if (!_DATE_NIKOGEN_FLG) {
        _DATE_NIKOGEN_FLG = saveTypeSaveInDB;
    }
    return _DATE_NIKOGEN_FLG;
}

// 運転免許証からOCRした取得日（他）を照合履歴として保持するか否かを指定
- (saveType)DATE_OTHER_FLG{
    if (!_DATE_OTHER_FLG) {
        _DATE_OTHER_FLG = saveTypeSaveInDB;
    }
    return _DATE_OTHER_FLG;
}

// 運転免許証からOCRした取得日（二種）を照合履歴として保持するか否かを指定
- (saveType)DATE_SECOND_FLG{
    if (!_DATE_SECOND_FLG) {
        _DATE_SECOND_FLG = saveTypeSaveInDB;
    }
    return _DATE_SECOND_FLG;
}

// 運転免許証からOCRした取得日（二種）を照合履歴として保持するか否かを指定
- (saveType)SEX_FLG{
    if (!_SEX_FLG) {
        _SEX_FLG = saveTypeSaveInDB;
    }
    return _SEX_FLG;
}

// 端末のGPSから取得した位置情報を照合履歴として保持するか否かを指定
- (saveType)GEOLOCATION_FLG{
    if (!_GEOLOCATION_FLG) {
        _GEOLOCATION_FLG = saveTypeNOTSaveInDB;
    }
    return _GEOLOCATION_FLG;
}

// 上記以外の本人確認書類から取得した情報を照合履歴として保持するか否かを指定
- (saveType)OTHER_FLG{
    if (!_OTHER_FLG) {
        _OTHER_FLG = saveTypeSaveInDB;
    }
    return _OTHER_FLG;
}
@end
