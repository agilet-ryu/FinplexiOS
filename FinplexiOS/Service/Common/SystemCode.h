//
//  SystemCode.h
//  demoApp
//
//  Created by agilet-ryu on 2019/7/24.
//  Copyright © 2019 fujitsu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KBNModel : NSObject
@property (nonatomic, assign) int code;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *STM1;
@property (nonatomic, strong) NSString *STM2;
@property (nonatomic, strong) NSString *STM3;
@property (nonatomic, strong) NSString *STM4;
@end

@interface IDENTIFICATION_KBN : NSObject
@property (nonatomic, strong) KBNModel *IDENTIFICATION_UNENABLE;
@property (nonatomic, strong) KBNModel *IDENTIFICATION_ENABLE;
@end

@interface ENABLE_KBN : NSObject
@property (nonatomic, strong) KBNModel *UNENFORCE;
@property (nonatomic, strong) KBNModel *ENFORCE;
@end

@interface ID_DOC_KBN : NSObject
@property (nonatomic, strong) KBNModel *CARD_SPECIALIP;
@property (nonatomic, strong) KBNModel *CARD_RESIDENCE;
@property (nonatomic, strong) KBNModel *CARD_PASSPORT;
@property (nonatomic, strong) KBNModel *CARD_MYNUMBER;
@property (nonatomic, strong) KBNModel *CARD_DRIVER;
@end

@interface ID_DOC_NFC_KBN : NSObject
@property (nonatomic, strong) KBNModel *CARD_SPECIALIP;
@property (nonatomic, strong) KBNModel *CARD_RESIDENCE;
@property (nonatomic, strong) KBNModel *CARD_PASSPORT;
@property (nonatomic, strong) KBNModel *CARD_MYNUMBER;
@property (nonatomic, strong) KBNModel *CARD_DRIVER;
@end

@interface READ_METHOD_KBN : NSObject
@property (nonatomic, strong) KBNModel *CAMERA;
@property (nonatomic, strong) KBNModel *NFC;
@end

@interface SystemCode : NSObject
@property (nonatomic, strong) IDENTIFICATION_KBN *identification_KBN;
@property (nonatomic, strong) ENABLE_KBN *enable_KBN;
@property (nonatomic, strong) ID_DOC_KBN *id_doc_KBN;
@property (nonatomic, strong) ID_DOC_NFC_KBN *id_doc_nfc_KBN;
@property (nonatomic, strong) READ_METHOD_KBN *read_method_KBN;
@end

NS_ASSUME_NONNULL_END
