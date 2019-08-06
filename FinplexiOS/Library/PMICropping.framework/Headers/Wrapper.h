//
//  Wrapper.h
//  PMICropping
//
//  Copyright PFU Limited 2016-2018
//

#ifndef PMICroppingWrapper_h
#define PMICroppingWrapper_h

#import <UIKit/UIKit.h>
#import <PMIImageUtility/PMIImageUtility.h>
#import <Foundation/Foundation.h>
/*!
 @brief      クロップ処理の動作モード
 */
//typedef NS_ENUM(int32_t, PMICroppingMode) {
//    PMICroppingModeNormal   		= 0x00000000,
//    PMICroppingModeWhiteDL  		= 0x00000001,
//	// REVIEW: パラメータ追加 (DS4)
//    PMICroppingModeNoOutSideCorner 	= 0x00000002,    
////    PMICroppingModeHybrid   		= 0x00000003,
//
//	// 20161004_確認用モード
//	PMICroppingModeNormalMin10		= 0x00000100,
//	PMICroppingModeNormalMinAuto	= 0x00000101,
//};

@interface PMICropping : NSObject
/*!
 @brief      四辺形のコーナー4点座標を検出する
 @param[in]  image      入力画像
 @param[in]  mode       動作モード
                        [0:3]   baseMode    0:normal, 1:whiteDL
                        [4]     outsideFlag 0:success, 1:failer
                        [5:7]   sliceMode   0:BW0, 1:BW1, 2:PIC0, 3:PIC1, 4:MB0, 7:NONE
 @param[out] status     エラー状態のフラグ
 @return     コーナー4点座標 (TopLeft.x, TopLeft.y, TopRight.x, TopRight.y, BottomRight.x, BottomRight.y, BottomLeft.x, BottomLeft.y)
 */
+ (NSArray*)detectCornersFromUIImage:(UIImage*)image mode:(int)mode status:(PMIStatus*)status;

/*!
 @brief      四辺形のコーナー4点座標を検出する
 @param[in]	 points     コーナー４点座標 (TopLeft.x, TopLeft.y, TopRight.x, TopRight.y, BottomRight.x, BottomRight.y, BottomLeft.x, BottomLeft.y)
 @param[in]  mag        座標空間の倍率 [gain]
 @param[in]  offsetX    X軸オフセット [pix]
 @param[in]  offsetY    Y軸オフセット [pix]
 @param[in]  width      出力座標空間の横幅 [pix]
 @param[in]  height     出力座標空間の高さ [pix]
 @param[out] status     エラー状態のフラグ
 @return     コーナー4点座標 (TopLeft.x, TopLeft.y, TopRight.x, TopRight.y, BottomRight.x, BottomRight.y, BottomLeft.x, BottomLeft.y)
 */
+ (NSArray*)getViewPoints: (NSArray*)points magnification:(CGFloat) mag offsetX:(CGFloat)offsetX  offsetY:(CGFloat)offsetY width:(CGFloat)width height:(CGFloat)height status:(PMIStatus*)status;

/*!
 @brief      検出座標の移動量を判定する
 @param[in]  prePointsArray     前回検出座標
 @param[in]  latestPointsArray  検出座標
 @param[in]  threshold          許容移動量
 @param[out] status             エラー状態のフラグ
 @return     判定結果             0:success, -1:failure
 */
+ (int)checkShiftLength:(NSArray*)prePointsArray latestPointsArray:(NSArray*)latestPointsArray threshold:(uint)threshold status:(PMIStatus*)status;
@end
#endif
