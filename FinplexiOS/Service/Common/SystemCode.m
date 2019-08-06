//
//  SystemCode.m
//  demoApp
//
//  Created by agilet-ryu on 2019/7/24.
//  Copyright © 2019 fujitsu. All rights reserved.
//

#import "SystemCode.h"

@implementation KBNModel
@end

@implementation IDENTIFICATION_KBN
@end

@implementation ENABLE_KBN
@end

@implementation ID_DOC_KBN
@end

@implementation ID_DOC_NFC_KBN
@end

@implementation READ_METHOD_KBN
@end

@interface SystemCode ()
@property (nonatomic, strong) NSDictionary *codeList;
@end

@implementation SystemCode

- (NSDictionary *)codeList{
    if (!_codeList) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Code.plist" ofType:nil];
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
        _codeList = [NSDictionary dictionaryWithDictionary:dic[@"systemCode"]];
    }
    return _codeList;
}

- (IDENTIFICATION_KBN *)identification_KBN{
    if (!_identification_KBN) {
        _identification_KBN = [IDENTIFICATION_KBN new];
        _identification_KBN.IDENTIFICATION_UNENABLE = [self getModelWithKBNname:@"IDENTIFICATION_KBN" andModelName:@"IDENTIFICATION_UNENABLE"];
        _identification_KBN.IDENTIFICATION_ENABLE = [self getModelWithKBNname:@"IDENTIFICATION_KBN" andModelName:@"IDENTIFICATION_ENABLE"];
    }
    return _identification_KBN;
}

- (ID_DOC_KBN *)id_doc_KBN{
    if (!_id_doc_KBN) {
        _id_doc_KBN = [ID_DOC_KBN new];
        _id_doc_KBN.CARD_SPECIALIP = [self getModelWithKBNname:@"ID_DOC_KBN" andModelName:@"CARD_SPECIALIP"];
        _id_doc_KBN.CARD_RESIDENCE = [self getModelWithKBNname:@"ID_DOC_KBN" andModelName:@"CARD_RESIDENCE"];
        _id_doc_KBN.CARD_PASSPORT = [self getModelWithKBNname:@"ID_DOC_KBN" andModelName:@"CARD_PASSPORT"];
        _id_doc_KBN.CARD_MYNUMBER = [self getModelWithKBNname:@"ID_DOC_KBN" andModelName:@"CARD_MYNUMBER"];
        _id_doc_KBN.CARD_DRIVER = [self getModelWithKBNname:@"ID_DOC_KBN" andModelName:@"CARD_DRIVER"];
    }
    return _id_doc_KBN;
}

- (ID_DOC_NFC_KBN *)id_doc_nfc_KBN{
    if (!_id_doc_nfc_KBN) {
        _id_doc_nfc_KBN = [ID_DOC_NFC_KBN new];
        _id_doc_nfc_KBN.CARD_SPECIALIP = [self getModelWithKBNname:@"ID_DOC_NFC_KBN" andModelName:@"CARD_SPECIALIP"];
        _id_doc_nfc_KBN.CARD_RESIDENCE = [self getModelWithKBNname:@"ID_DOC_NFC_KBN" andModelName:@"CARD_RESIDENCE"];
        _id_doc_nfc_KBN.CARD_PASSPORT = [self getModelWithKBNname:@"ID_DOC_NFC_KBN" andModelName:@"CARD_PASSPORT"];
        _id_doc_nfc_KBN.CARD_MYNUMBER = [self getModelWithKBNname:@"ID_DOC_NFC_KBN" andModelName:@"CARD_MYNUMBER"];
        _id_doc_nfc_KBN.CARD_DRIVER = [self getModelWithKBNname:@"ID_DOC_NFC_KBN" andModelName:@"CARD_DRIVER"];
    }
    return _id_doc_nfc_KBN;
}

- (ENABLE_KBN *)enable_KBN{
    if (!_enable_KBN) {
        _enable_KBN = [ENABLE_KBN new];
        _enable_KBN.ENFORCE = [self getModelWithKBNname:@"ENABLE_KBN" andModelName:@"ENFORCE"];
        _enable_KBN.UNENFORCE = [self getModelWithKBNname:@"ENABLE_KBN" andModelName:@"UNENFORCE"];
    }
    return _enable_KBN;
}

- (READ_METHOD_KBN *)read_method_KBN{
    if (!_read_method_KBN) {
        _read_method_KBN = [READ_METHOD_KBN new];
        _read_method_KBN.NFC = [self getModelWithKBNname:@"READ_METHOD_KBN" andModelName:@"NFC"];
        _read_method_KBN.CAMERA = [self getModelWithKBNname:@"READ_METHOD_KBN" andModelName:@"CAMERA"];
    }
    return _read_method_KBN;
}

- (KBNModel *)getModelWithKBNname:(NSString *)KBNname andModelName:(NSString *)modelName {
    KBNModel *model = [KBNModel new];
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary:self.codeList[KBNname]];
    if ([dic  objectForKey:modelName]) {
        NSDictionary *di = [NSDictionary dictionaryWithDictionary:dic[modelName]];
        model.code = [di[@"code"] intValue];
        model.name = di[@"name"];
        model.STM1 = di[@"STM1"];
        model.STM2 = di[@"STM2"];
        model.STM3 = di[@"STM3"];
        model.STM4 = di[@"STM4"];
    }
    return model;
}

@end
