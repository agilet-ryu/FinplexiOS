//
//  Copyright PFU Limited 2017-2018
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PDLCameraScanError.h"
#import "PDLCameraScanLogInfo.h"
#import "PDLDocInfo.h"
#import "PDLScanConfig.h"
#import "PDLCameraScanLogInfo.h"

@protocol PDLCameraScanDelegate;
@protocol PDLCameraScanResizeDelegate;
@protocol PDLCameraScanConvertOcrImageDelegate;


@interface PDLCameraScan : NSObject

@property (nonatomic, weak, nullable) id<PDLCameraScanDelegate> delegate;       //<! デリゲート
@property (nonatomic, copy, nullable) PDLCameraScanLogCallbackBlock logCallbackBlock; //<! ログ出力用関数
@property (nonatomic, weak) id<PDLCameraScanResizeDelegate> __nullable resizeDelegate;    //<! デリゲート
@property (nonatomic, weak) id<PDLCameraScanConvertOcrImageDelegate> __nullable convertOcrImageDelegate;    //<! デリゲート


/*!
 @brief      PDLCameraScanのインスタンスを取得します。
 @return     PDLCameraScanのインスタンス
 */
+ (nonnull PDLCameraScan *)sharedInstance;

/*!
 @brief      必要なリソースを初期化します
 @return     エラー:PDLCameraScanError
 */
- (nonnull PDLCameraScanError *)prepareResource;

/*!
 @brief      カメラScan処理を開始します
 @return     エラー:PDLCameraScanError
 */
- (nonnull PDLCameraScanError *)captureOnce:(nonnull UIViewController *)viewController;

/*!
 @brief      カメラScan処理を開始します
 @return     エラー:PDLCameraScanError
 */
- (nonnull PDLCameraScanError *)captureOnce2:(nonnull UIViewController *)viewController custom:(nonnull UIView *)custom;

/*!
 @brief      Scan処理を中断します
 @return     エラー:PDLCameraScanError
 */
- (nonnull PDLCameraScanError *)cancelCaptureOnce;

/*!
 @brief      Scanに必要なリソースを解放します
 @return     エラー:PDLCameraScanError
 */
- (nonnull PDLCameraScanError *)deinitResource;

/*!
 @brief      カメラScanの設定情報を取得します
 @return     カメラScanの設定情報クラス：PDLScanConfig
 */
- (PDLScanConfig * __nonnull)getConfig;

/*!
 @brief      カメラScanの設定情報を更新します
 @return     エラー:PDLCameraScanError
 */
- (PDLCameraScanError * __nonnull)setConfig:(PDLScanConfig * __nonnull)config;

/*!
 @brief      プレビュー上部に表示するガイドメッセージを設定する。
 @param[in]  message     ガイドメッセージ内容
 */
- (void)setGuideMessage:(NSString * __nonnull)message;

/*!
 @brief      プレビュー画面を取得します
 @return     プレビュー画面:UIView
 @note       prepareResouce呼び出し前などエラーの場合はnilが返却されます。
 またすでにgetCameraPreviewが呼び出されている場合もnilが返却されます。
 */
- (UIView * __nullable)getCameraPreview:(PDLCameraScanError (* __nonnull (* __nullable)))error;

/*!
 @brief		画像リサイズ
 @note
 @param[in] imageSrc    元画像
 @param[in] toSize      処理後のサイズ
 @return		エラーコード
 */
- (PDLCameraScanError *)resize:(UIImage *)imageSrc tosize:(CGSize)toSize;

/*!
 @brief     撮影した画像を定型帳票サーバーOCRと連携するためのイメージフォーマットに変換する
 @note      撮影した画像に解像度情報を付加し、JPEG形式の画像に変換する
 @param[in] imageSrc        解像度情報を付加する画像
 @param[in] docWidth        書類の実寸幅[mm]
 @param[in] docHeight       書類の実寸高さ[mm]
 @param[in] toResolution    結果画像の解像度
 @param[in] toQuality       結果画像のJPEG圧縮率
 @return        エラーコード
 */
- (PDLCameraScanError *)convertOcrImage:(UIImage *)imageSrc docWidth:(double)docWidth docHeight:(double)docHeight toResolution:(NSInteger)toResolution toQuality:(NSInteger)toQuality;

/*!
 @brief    UI、カメラ方向などの調整を行う
 @return    なし
 */
- (void)setCameraPreviewUIStatus;

/*!
 @brief    警告メッセージ内容を削除
 @return    なし
 */
- (void)clearWarningMessage;
@end


@protocol PDLCameraScanDelegate <NSObject>

/*!
 @brief      スキャンに成功した場合に呼び出されます
 @param[in]  docInfo     認識結果の情報を保持したインスタンス
 */
- (void)didScanSuccess:(nonnull PDLDocInfo *)docInfo;

/*!
 @brief      スキャンに失敗した場合に呼び出されます
 @param[in]  error     エラーの情報を保持したインスタンス
 */
- (void)didScanFailure:(nonnull PDLCameraScanError *)error;

/*!
 @brief      キャンセルボタンを押下された場合に呼び出されます
 */
- (void)didScanCancel;
@end

/*!
 本人確認SCAN APIのresize完了時に呼ばれるDelegateメソッド群
 */
@protocol PDLCameraScanResizeDelegate

/*!
 @brief      りサイズ完了(成功)時
 @param[in]  imageCard     入力画像
 */
- (void)didResizeSuccess:(UIImage *__nonnull) imageDst;

/*!
 @brief      りサイズ完了(失敗)時
 @param[in]  error     エラーの情報を保持したインスタンス
 */
- (void)didResizeFailure:(PDLCameraScanError *__nonnull)error;

@end

/*!
 @brief      解像度情報の付加完了時のデリゲート
 */
@protocol PDLCameraScanConvertOcrImageDelegate

/*!
 @brief      解像度情報の付加完了(成功)時
 @param[in]  imageDst     解像度情報を付加したイメージの情報を保持したインスタンス
 */
- (void)didConvertSuccess:(NSData *__nonnull)imageDst;

/*!
 @brief     解像度情報の付加完了(失敗)時
 @param[in]  error     エラーの情報を保持したインスタンス
 */
- (void)didConvertFailure:(PDLCameraScanError *__nonnull)error;

@end
