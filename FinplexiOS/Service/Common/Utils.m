//
//  Utils.m
//  demoApp
//
//  Created by agilet-ryu on 2019/7/22.
//  Copyright © 2019 fujitsu. All rights reserved.
//

#import "Utils.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

static NSString *const PSW_AES_KEY = @"AKIA2ZRBYSWXMQVF";
static NSString *const AES_IV_PARAMETER = @"e6db271db12d4d47";

@implementation Utils

/**
 西暦から和暦への変換
 
 @param jpDate 和暦文字列
 @return 西暦文字列
 */
+ (NSString *)getGregorianDateFromJapaneseDate:(NSString *)jpDate{
    NSString *gregorianDateStr = [NSString string];
    if ([jpDate containsString:@"令和"]) {
        if (jpDate.length == 11) {
            if (![jpDate containsString:@"?"]) {
                NSString *year = [jpDate containsString:@"元年"] ? @"01" : [jpDate substringWithRange:NSMakeRange(2, 2)];
                NSString *month = [jpDate containsString:@"元年"] ? [jpDate substringWithRange:NSMakeRange(4, 2)] : [jpDate substringWithRange:NSMakeRange(5, 2)];
                NSString *day = [jpDate containsString:@"元年"] ? [jpDate substringWithRange:NSMakeRange(7, 2)] : [jpDate substringWithRange:NSMakeRange(8, 2)];
                int y = 2018 + [year intValue];
                gregorianDateStr = [NSString stringWithFormat:@"%d-%@-%@", y, month, day];
            }
        }
    }else{
        // 書式設定を使用して、和暦の年月日をDate型に変換
        NSDateFormatter *jpFormatter = [[NSDateFormatter alloc] init];
        [jpFormatter setCalendar:[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierJapanese]];
        [jpFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
        [jpFormatter setDateFormat:@"GGyy年MM月dd日"];
        NSDate *workDate = [jpFormatter dateFromString:jpDate];
        
        NSDateFormatter *commonFormatter = [[NSDateFormatter alloc] init];
        [commonFormatter setCalendar:[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian]];
        // 書式「yyyyMMdd」の文字列を返す
        [commonFormatter setDateFormat:@"yyyy-MM-dd"];
        gregorianDateStr = [commonFormatter stringFromDate:workDate];
    }
    return gregorianDateStr;
}

+ (BOOL)isExpiratedDocDate:(NSString*)docDate withCurrentDate:(NSString*)currentDate{
    NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
    [dateformater setDateFormat:@"yyyy-MM-dd"];
    NSComparisonResult result = [[dateformater dateFromString:docDate] compare:[dateformater dateFromString:currentDate]];
    return result == NSOrderedAscending;
}
/**
 システム内コードを取得する
 
 @return システム内コード
 */
+ (SystemCode *)getSystemCode{
    return [SystemCode new];
}

/**
 現在の時刻を取得する
 
 @return 時間の文字列
 */
+ (NSString *)getCurrentTime{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss:SSS"];
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    return currentTimeString;
}

/**
 NSDictionaryはNSStringになります。

 @param dictionary パラメーター
 @return 戻り値
 */
+ (NSString *)convertToJsonData:(NSDictionary *)dictionary{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}

/**
 NSStringはNSDictionaryになります。

 @param jsonString パラメーター
 @return 戻り値
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        return nil;
    }
    return dic;
}

/**
 文字列をAES暗号化する
 
 @param string パラメーター
 @return 暗号化する文字列
 */
+ (NSString *)aes_encryptWithString:(NSString *)string{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSData *AESData = [self AES128operation:kCCEncrypt
                                       data:data
                                        key:PSW_AES_KEY
                                         iv:AES_IV_PARAMETER];
    NSString *baseStr = [AESData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSString *temp = [baseStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return temp;
}

/**
 AES復号する
 
 @param base64String パラメーター
 @return 復号する文字列
 */
+ (NSString *)aes_decryptWithBase64String:(NSString *)base64String {
    NSLog(@"Base64String =  =  %@", base64String);
    NSData *baseData = [[NSData alloc] initWithBase64EncodedString:base64String options:0];
    NSData *AESData = [self AES128operation:kCCDecrypt
                                       data:baseData
                                        key:PSW_AES_KEY
                                         iv:AES_IV_PARAMETER];
    NSString *decStr = [[NSString alloc] initWithData:AESData encoding:NSUTF8StringEncoding];
    NSLog(@"aes_decryptWithBase64String =  =  %@", decStr);
    return decStr;
}

/**
 画像をAES暗号化する
 
 @param image パラメーター
 @return 暗号化するデータ
 */
+ (NSData *)aes_encryptWithImage:(UIImage *)image{
    NSData *baseData = UIImageJPEGRepresentation(image, 1.0f);
    NSData *AESData = [self AES128operation:kCCEncrypt
                                       data:baseData
                                        key:PSW_AES_KEY
                                         iv:AES_IV_PARAMETER];
    return AESData;
}

// AES暗号化、復号
+ (NSData *)AES128operation:(CCOperation)operation data:(NSData *)data key:(NSString *)key iv:(NSString *)iv {
    char keyPtr[kCCKeySizeAES128 + 1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    char ivPtr[kCCBlockSizeAES128 + 1];
    bzero(ivPtr, sizeof(ivPtr));
    [iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    size_t bufferSize = [data length] + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptorStatus = CCCrypt(operation, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                                            keyPtr, kCCKeySizeAES128,
                                            ivPtr,
                                            [data bytes], [data length],
                                            buffer, bufferSize,
                                            &numBytesEncrypted);
    
    if(cryptorStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    } else {
        NSLog(@"Error");
    }
    free(buffer);
    return nil;
}

/**
 画像はbase64文字列になります。
 
 @param image 画像
 @return base64文字列
 */
+ (NSString *)base64StringWithImage:(UIImage *)image{
    NSData *data = UIImageJPEGRepresentation(image, 1.0f);
    NSString *baseStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSString *temp = [baseStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return temp;
}

+ (NSString *)getHtmlParam{
    NSDictionary *dic = [NSDictionary new];
    IDENTIFICATION_DATA *iData = [InfoDatabase shareInfoDatabase].identificationData;
    ID_DOC_KBN *docKBN = [self getSystemCode].id_doc_KBN;
    
    int doc = iData.DOC_TYPE;
    
    if (doc == docKBN.CARD_DRIVER.code) {
        dic = @{@"dl-name" : iData.NAME,
                @"dl-birth" : iData.BIRTH,
                @"dl-addr" : iData.ADDRESS,
                @"dl-issue" : iData.ISSUANCE_DATE,   // 交付時間
            //  @"dl-ref" : @"00005",     // 交付番号
                @"dl-expire" : iData.EXPIRATION,  // 有効期限
            //  @"dl-is-expired" : @"０００",   //
                @"dl-number" : iData.NUMBER,  // 番号
                @"dl-color-class" : iData.BAND_COLOR,
                @"dl-sc" : iData.COMMISSION,      // 公安委員会
                @"dl-condition1" : iData.CONDITION_1,   // 免許条件１
                @"dl-condition2" : iData.CONDITION_2,   // 免許条件２
                @"dl-condition3" : iData.CONDITION_3,   // 免許条件３
                @"dl-condition4" : iData.CONDITION_4,   // 免許条件４
                @"dl-photo" : iData.PHOTO_IMG,
                @"dl-categories" : @[
                      @{@"name" : @"二･小･原", @"licensed" : @true, @"tag" : @"0x22", @"date" : iData.DATE_NIKOGEN},
                      @{@"name" : @"他", @"licensed" : @true, @"tag" : @"0x23", @"date" : iData.DATE_OTHER},
                      @{@"name" : @"二種", @"licensed" : @true, @"tag" : @"0x24", @"date" : iData.DATE_SECOND},
                      ],
                @"dl-remarks" : @""  // 備考
          };
    }
    
    if (doc == docKBN.CARD_MYNUMBER.code) {
        dic = @{@"cardinfo-name": iData.NAME,
                @"cardinfo-birth": iData.BIRTH,
                @"cardinfo-addr": iData.ADDRESS,
                @"cardinfo-sex": iData.GENDER,
                @"cardinfo-mynumber": iData.NUMBER,
                @"cardinfo-cert-expire": @"20200601235959",
                @"cardinfo-expire": @"20250601",
                @"cardinfo-photo" : iData.PHOTO_IMG
                };
    }
    
    if (doc == docKBN.CARD_PASSPORT.code) {
        dic = @{@"ep-type": @"P<",
                @"ep-issuing-country": @"JPN",
                @"ep-passport-number": @"TRXXXXXXX",
                @"ep-surname": @"NIHON",
                @"ep-given-name": @"HANAKO",
                @"ep-nationality": @"JPN",
                @"ep-date-of-birth": @"750601",
                @"ep-sex": @"F",
                @"ep-date-of-expiry": @"170601",
                @"ep-mrz": @"P<JPNNIHON<<HANAKO<<<<<<<<<<<<<<<<<<<<<<<<<<TRXXXXXXXXJPN750601XF170601X<<<<<<<<<<<<<<XX",
                @"ep-bac-result": @true,
                @"ep-aa-result": @true,
                @"ep-pa-result": @true,
                @"ep-photo" : iData.PHOTO_IMG
                };
    }
    
    NSString *str = [NSString stringWithFormat:@"%@", [self convertToJsonData:dic]];
    NSString *jsStr = [NSString stringWithFormat:@"render('%@')", str];
    return jsStr;
}
@end
