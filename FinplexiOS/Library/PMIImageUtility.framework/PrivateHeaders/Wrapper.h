//
//  Wrapper.h
//  PMIImageUtility
//
//  Copyright PFU Limited 2016-2018
//

#ifndef PMIImageUtilityWrapper_h
#define PMIImageUtilityWrapper_h

#import <UIKit/UIKit.h>
#import <stdint.h>
#import "P2IIMG.h"

/*!
 @brief      画像処理のエラー状態フラグ
 */
typedef NS_ENUM(int32_t, PMIStatus) {
    PMIStatusSuccess = 0x00000000,          // 正常
    PMIStatusFailure = 0x00000001,          // 失敗
    PMIStatusArgumentError = 0x00000002,    // 引数エラー
    PMIStatusMemoryError = 0x00000003,      // メモリエラー
    PMIStatusInternalError = 0x00000004,    // 内部処理エラー
    PMIStatusUnknownError = 0x00000005,     // 不明な起こりえないエラー
};

@interface PMIImageUtility : NSObject

/*!
 @brief      UIImageからP2IIMGへの画像形式変換
 @note       BytesPerRowの4byte境界は考慮していない。OpenCVのUIImageToMatの検証が必要。
 @param[in]  image              入力画像
 @param[in]  dpi                出力画像に付加する解像度情報 [dpi]
 @param[out] status             エラー状態フラグ
 @return     P2IIMG形式の画像データ (RGB 24bit, 4byte境界なし)
 */
+ (P2IIMG)convertUIImageToP2IIMG:(UIImage*)image dpi:(int32_t)dpi status:(PMIStatus*)status;

/*!
 @brief      P2IIMGからUIImageへの画像形式変換
 @note       BytesPerRowの4byte境界は考慮していない。OpenCVのMatToUIImageの検証が必要。
 nClrOdrは常に0を返すので取り扱いに注意すること。これはUIImageの多様なBitmapInfoにP2IIMGの定義が不十分なことからあえて0に固定した。
 @param[in]  image              入力画像
 @param[out] status             エラー状態フラグ
 @return     UIImage形式の出力画像
 */
+ (UIImage*)convertP2IIMGToUIImage:(P2IIMG*)image status:(PMIStatus*)status;

/*!
 @brief      4byte境界に揃えられたBytesPerRowを求める
 @param[in]  width              画像の横幅 [pix]
 @param[in]  colorChannels      画像の色数 [channel]
 @param[out] status             エラー状態フラグ
 @return     4byte境界に揃えられたBytesPerRow
 */
+ (int32_t)calcurate4ByteAlignedBytesPerRow:(int32_t)width colorChannels:(int32_t)colorChannels status:(PMIStatus*)status;

/*!
 @brief      画像のサイズを変更する
 @param[in]  image              入力画像
 @param[in]  dstWidth           出力画像の横幅 [pix]
 @param[in]  dstHeight          出力画像の高さ [pix]
 @param[in]  fastMode           リサイズ処理の補完方法, false:cubic, true:linear
 @param[out] status             エラー状態フラグ
 @return     リサイズ後の画像
 */
+ (UIImage*)resize:(UIImage*)image dstWidth:(int32_t)dstWidth dstHeight:(int32_t)dstHeight fastMode:(bool)fastMode status:(PMIStatus*)status;

/*!
 @brief      画像データを回転させる
 @note       imageOrientationではなく、dataを並べ替える
 本メソッドは90度単位の4方向の向き変更
 角度によるrotateではない
 @param[in]	 image          入力画像
 @param[in]  orientation    回転角度（0度, 90度, 180度, 270度にのみ対応）
 @param[out] status         エラー状態フラグ
 @return     UIImage        出力画像
 */
+ (UIImage*)orient:(UIImage*)image orientation:(int32_t)orientation status:(PMIStatus*)status;

/*!
 @brief      P2IIMGの内容をログへ出力する
 @param[in]  image              P2IIMG形式の画像へのポインタ
 @return     なし
 */
+ (void)logP2IIMG:(P2IIMG*)image;

// 追加したいメソッド
// - raw画像読み込み
// - raw画像保存
// - Flip (horizontal, vertical)
// - P2IIMGの4byte境界の追加
// - P2IIMGの4byte境界の削除
// - UIImageのimageOrientationプロパティに合わせてCGImageの画素配列を回転させて揃える

@end

#endif /* PMIImageUtilityWrapper_h */