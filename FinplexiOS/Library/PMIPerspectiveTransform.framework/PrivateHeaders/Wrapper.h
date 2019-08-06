//
//  Wrapper.h
//  PMIPerspectiveTransform
//
//  Copyright PFU Limited 2016-2018
//

#ifndef PMIPerspectiveTransformWrapper_h
#define PMIPerspectiveTransformWrapper_h

#import <UIKit/UIKit.h>
#import <PMIImageUtility/PMIImageUtility.h>

@interface PMIPerspectiveTransform: NSObject
/*!
 @brief     透視投影空過上の四辺形を切り出して矩形画像に変換する
 @param[in]	image       入力画像
 @param[in]	corners     コーナー４点座標 (TopLeft.x, TopLeft.y, TopRight.x, TopRight.y, BottomRight.x, BottomRight.y, BottomLeft.x, BottomLeft.y)
 @param[in]	dstWidth    出力矩形画像の横幅 [pix]
 @param[in]	dstHeight   出力矩形画像の高さ [pix]
 @return    UIImage     出力矩形画像
 */
+ (UIImage*)remapUIImage:(UIImage*)image corners:(double*)corners dstWidth:(int32_t)dstWidth dstHeight:(int32_t)dstHeight status:(PMIStatus*)status;
@end

#endif /* Wrapper_h */
