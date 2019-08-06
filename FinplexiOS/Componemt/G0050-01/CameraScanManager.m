//
//  CameraScanManager.m
//  demoApp
//
//  Created by agilet on 2019/06/20.
//  Copyright © 2019 fujitsu. All rights reserved.
//

#import "CameraScanManager.h"
#import <PDLCameraScan/PDLCameraScan.h>

@interface CameraScanManager()<PDLCameraScanDelegate>
@property (strong, nonatomic) PDLCameraScan *scan;
@end

@implementation CameraScanManager

static CameraScanManager *manager;

// カメラスキャン初期化
+ (instancetype)sharedCameraScanManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    manager = [[CameraScanManager alloc] initWithPDLCameraScan];
    });
    return manager;
}

// カメラスキャンの初期化処理（関数_setConfig／prepareResource）を呼び出し、カメラ撮影が実施できる状態とする。
- (instancetype)initWithPDLCameraScan {
    self = [super init];
    if (self) {
        PDLCameraScan *scan = [PDLCameraScan sharedInstance];
        scan.delegate = self;

#warning TODO　※ 設定値の詳細は、「システム機能仕様 6) 特別要件」参照
        // ライブラリの設定の更新
        PDLScanConfig *config = [scan getConfig];
        config.previewParam.previewDirection = PDLScanPreviewDirectionLandscape;
        config.guideParam.visible = YES;
        config.cameraParam.detectedDocSizeThreshold = 0.8;
        PDLCameraScanError *scanError1 = [scan setConfig:config];
        
        if (scanError1.code != PDLCameraScanErrorCodeOK){
            
            // カメラスキャン初期化（設定）結果_異常時
            if ([self.delegate respondsToSelector:@selector(cameraScanFailure:)]) {
                [self.delegate cameraScanFailure:scanError1.code];
            }
        } else {
            
            // カメラスキャン初期化（設定）結果_正常時
            // カメラスキャンの関数_prepareResourceを呼び出し、カメラスキャンの初期化処理を行う。
            PDLCameraScanError *scanError = [scan prepareResource];
            if (scanError.code != PDLCameraScanErrorCodeOK) {
                
                // カメラスキャン初期化（設定）結果_異常時
                if ([self.delegate respondsToSelector:@selector(cameraScanFailure:)]) {
                    [self.delegate cameraScanFailure:scanError.code];
                }
            } else{
                
                // カメラスキャン初期化（リソース）結果_正常時
                if ([self.delegate respondsToSelector:@selector(cameraScanPrepareSuccess)]) {
                    [self.delegate cameraScanPrepareSuccess];
                }
            }
        }
        self.scan = scan;
    }
    return self;
}

// カメラスキャン起動
- (void)start{
    UIViewController *RootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = RootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    
    // カメラスキャンの起動処理（関数_captureOnce）を呼び出し、「G0050-01：本人確認書類撮影画面」に遷移する。
    PDLCameraScanError *scanError = [self.scan captureOnce:topVC];
    if (scanError.code != PDLCameraScanErrorCodeOK) {
        
        // カメラスキャン起動結果_異常時
        if ([self.delegate respondsToSelector:@selector(cameraScanFailure:)]) {
            [self.delegate cameraScanFailure:scanError.code];
        }
    } else {
        
        // カメラスキャン起動結果_正常時
        if ([self.delegate respondsToSelector:@selector(cameraScanStart)]) {
            [self.delegate cameraScanStart];
        }
    }
}

// Scanに必要なリソースを解放します
- (void)deinitResource{
    [self.scan deinitResource];
}

#pragma mark - delegate
// 書類の認識成功時に呼び出されます。
- (void)didScanSuccess:(PDLDocInfo *)cardInfo {
    UIImage *image = cardInfo.image;
    NSInteger result = cardInfo.cropResult;
    if ([self.delegate respondsToSelector:@selector(cameraScanSuccessWithImage:andCropResult:)]) {
        [self.delegate cameraScanSuccessWithImage:image andCropResult:result];
    }
}

// プレビュー／認識中に何らかのエラーが発生した場合に呼び出されます。
- (void)didScanFailure:(PDLCameraScanError *)error {
    if ([self.delegate respondsToSelector:@selector(cameraScanFailure:)]) {
        [self.delegate cameraScanFailure:error.code];
    }
}

// キャンセルボタンを押す時に呼び出されます。
- (void)didScanCancel {
    if ([self.delegate respondsToSelector:@selector(cameraScanCancel)]) {
        [self.delegate cameraScanCancel];
    }
}
@end
