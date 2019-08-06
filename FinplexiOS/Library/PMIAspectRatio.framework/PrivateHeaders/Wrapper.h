//
//  Wrapper.h
//  PMIAspectRatio
//
//  Copyright PFU Limited 2016-2018
//

#ifndef PMIAspectRatioWrapper_h
#define PMIAspectRatioWrapper_h

#import <PMIImageUtility/PMIImageUtility.h>

@interface PMIAspectRatio: NSObject
/*!
 @brief      イニシャライザ
 @note       カメラ固有パラメータを直接与えることで、高い精度でアスペクト比を復元できる
 @warning    幾何学的な変換が施されていない素のカメラ画像にのみ有効
 @param[in]	 imageSize       画像のサイズ [mm]
 @param[in]	 sensorSize      センサーサイズ [mm]
 @param[in]	 forcalLength    焦点距離 [mm]
 @param[in]  zoomRatio       デジタルズーム比
 @return     instance
 */
- (id)initWithImageSize:(CGSize)imageSize sensorSize:(CGSize)sensorSize focalLength:(double)focalLength zoomRatio:(double)zoomRatio;

/*!
 @brief      イニシャライザ（簡易版）
 @note       センササイズを調べるのは現実的に難しいので、焦点距離と画角からカメラ固有パラメータ（イメージ・センサ・サイズ）を推測する
             簡易的に利用できる分、アスペクト比復元の精度には誤差を含む
             一般的なスマートフォンならば焦点距離 4mm, 画角 70度が近似値として利用できる
 @warning    幾何学的な変換が施されていない素のカメラ画像にのみ有効
 @param[in]	 imageSize       画像のサイズ [mm]
 @param[in]	 forcalLength    焦点距離 [mm]
 @param[in]  viewAngle       画角 [degree]
 @return     instance
 */
- (id)initWithImageSize:(CGSize)imageSize focalLength:(double)focalLength viewAngle:(double)viewAngle;

/*!
 @brief      投資投影空間上における矩形原稿のアスペクト比復元
 @param[in]	 corners         コーナー座標点群 (順序: TLX, TLY, TRX, TRY, BRX, BRY, BLX, BLY)
 @param[out] status          エラー状態フラグ
 @return     推測されるアスペクト比
 */
- (double)calculateAspectRatio:(double*)corners status:(PMIStatus*)status;

/*!
 @brief     コーナー4点座標を基に最長辺の長さを求める
 @note      pointsは次の順序で8つの数値を格納していること
 TLX, TLY, TRX, TRY, BRX, BRY, BLX, BLY
 @param[in]	points  矩形原稿のコーナー4点の座標
 @return    double  最長辺の長さ [pix]
 */
+ (double)calculateLongestEdge:(double*)points status:(PMIStatus*)status;
@end

#endif
