//
//  Copyright PFU Limited 2018
//

// Frameworks
#import <Foundation/Foundation.h>

// Public
#import "PDLScanGuideParam.h"
#import "PDLScanCroppingRegionParam.h"
#import "PDLCameraScanParam.h"
#import "PDLScanPreviewParam.h"
#import "PDLScanWarningParam.h"
#import "PDLScanParam.h"

/*!
 @brief カメラScan全体の設定を格納するクラス
 */
@interface PDLScanConfig : NSObject

// カメラスキャンのカメラに関する設定パラメータを取得および設定します。
@property (nonatomic, strong) PDLCameraScanParam * __nonnull cameraParam;

// カメラスキャンのプレビュー画面に関する設定情報を取得および設定します。
@property (nonatomic, strong) PDLScanPreviewParam * __nonnull previewParam;

// カメラスキャンの書類検出領域に関する設定情報を取得および設定します。
@property (nonatomic, strong) PDLScanCroppingRegionParam * __nonnull croppingRegionParam;

// カメラスキャンの警告メッセージに関する設定情報を取得および設定します。
@property (nonatomic, strong) PDLScanWarningParam * __nonnull warningParam;

// カメラスキャンの撮影ガイドに関する設定情報を取得及び設定します。
@property (nonatomic, strong) PDLScanGuideParam * __nonnull guideParam;

// カメラスキャンの隠し機能の設定パラメータを取得および設定する
@property (nonatomic, strong) PDLScanParam * __nonnull scanParam ;
@end
