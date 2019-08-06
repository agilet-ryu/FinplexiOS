//
//  Copyright PFU Limited 2018
//

// Frameworks
#import <Foundation/Foundation.h>

/*!
 @brief Scanの設定を格納するクラス
 */
@interface PDLScanParam : NSObject

// ボケ判定処理のスコア閾値を取得および設定する。
// 既定値は30.0
// 0未満のとき、setConfig時にエラー(CamScanInvalidArgument、
// PDLCameraScanErrorCodeCamScanInvalidArgument)
@property(nonatomic) double    blurScoreThreshold;

// ボケ判定処理のスコア閾値の最低値を取得および設定する。
// 既定値は12.5
// 0未満のとき、setConfig時にエラー(CamScanInvalidArgument、
// PDLCameraScanErrorCodeCamScanInvalidArgument)
@property(nonatomic) double    blurIniSlic;

// ボケ判定処理の判定成功時の閾値値増加率を取得および設定する。
// 規定値は10.0
// 0未満のとき、setConfig時にエラー(CamScanInvalidArgument、
// PDLCameraScanErrorCodeCamScanInvalidArgument)
@property(nonatomic) double    blurIncRate;

// ボケ判定処理の判定失敗時の閾値減少率を取得および設定する。
// 規定値は10.0
// 0未満のとき、setConfig時にエラー(CamScanInvalidArgument、
// PDLCameraScanErrorCodeCamScanInvalidArgument)
@property(nonatomic) double    blurLowRate;

// 移動量判定のしきい値を取得および設定する。
// 値を大きくするとシャッターが切れやすくなるがボケた画像が撮られやすくなる。
// 既定値は10
// 10～200の範囲で指定可能。
// それ以外のとき、SetConfig時にエラー(CamScanInvalidArgument、
// PDLCameraScanErrorCodeCamScanInvalidArgument)
@property(nonatomic) NSInteger checkShiftLengthThreshold;

@end
