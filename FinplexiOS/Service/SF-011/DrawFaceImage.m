//
//  DrawFaceImage.m
//  FinplexiOS
//
//  Created by agilet-ryu on 2019/8/5.
//  Copyright © 2019 Fujitsu. All rights reserved.
//

#import "DrawFaceImage.h"
#import "InfoDatabase.h"
#import "SystemCode.h"

@implementation DrawFaceImage
#pragma mark - SF-011_顔画像トリミング

// OCRトリミング
+ (NSString *)getFaceImageWithOCRImage:(UIImage *)image{
    InfoDatabase *db = [InfoDatabase shareInfoDatabase];
    int px1 = [db.identificationData.POSITION_IMAGE_X1 intValue];
    int px2 = [db.identificationData.POSITION_IMAGE_X2 intValue];
    int py1 = [db.identificationData.POSITION_IMAGE_Y1 intValue];
    int py2 = [db.identificationData.POSITION_IMAGE_Y2 intValue];
    
    int width = px2 - px1;
    int height = py2 - py1;
    CGRect trimArea = CGRectMake(px1, py1, width, height);
    CGImageRef srcImageRef = [image CGImage];
    CGImageRef trimmedImageRef = CGImageCreateWithImageInRect(srcImageRef, trimArea);
    UIImage *trimmedImage = [UIImage imageWithCGImage:trimmedImageRef];
    NSData *imgDataFace = [[NSData alloc] initWithData:UIImageJPEGRepresentation(trimmedImage, 1.0f)];
    NSString *base64StrFace = [NSString stringWithFormat:@"%s %@","data:image/jpeg;base64,",[imgDataFace base64EncodedStringWithOptions:NSDataBase64Encoding76CharacterLineLength]];
    db.identificationData.PHOTO_IMG = trimmedImage;
    return base64StrFace;
}

// CameraScanトリミング
+ (NSString *)getFaceImageWithCameraScanImage:(UIImage *)image{
    CGRect trimArea;
    InfoDatabase *db = [InfoDatabase shareInfoDatabase];
    ID_DOC_KBN *idKBN = [SystemCode new].id_doc_KBN;
    int doc = db.identificationData.DOC_TYPE;
    
    if (doc == idKBN.CARD_DRIVER.code) {
        trimArea = CGRectMake(image.size.width * 0.674, image.size.height * 0.279,
                              image.size.width * 0.296, image.size.height * 0.560);
    }
    if (doc == idKBN.CARD_MYNUMBER.code) {
        trimArea = CGRectMake(image.size.width * 0.046, image.size.height * 0.317,
                              image.size.width * 0.251, image.size.height * 0.549);
    }
    if (doc == idKBN.CARD_RESIDENCE.code) {
        trimArea = CGRectMake(image.size.width * 0.70, image.size.height * 0.29,
                              image.size.width * 0.271, image.size.height * 0.544);
    }
    CGImageRef srcImageRef = [image CGImage];
    CGImageRef trimmedImageRef = CGImageCreateWithImageInRect(srcImageRef, trimArea);
    UIImage *trimmedImage = [UIImage imageWithCGImage:trimmedImageRef];
    NSData *imgDataFace = [[NSData alloc] initWithData:UIImageJPEGRepresentation(trimmedImage, 1.0f)];
    NSString *base64StrFace = [NSString stringWithFormat:@"%s %@","data:image/jpeg;base64,",[imgDataFace base64EncodedStringWithOptions:NSDataBase64Encoding76CharacterLineLength]];
    db.identificationData.PHOTO_IMG = trimmedImage;
    return base64StrFace;
}
@end
