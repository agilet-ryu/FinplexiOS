//
//  Copyright PFU Limited 2018
//

#import <Foundation/Foundation.h>

/*!
 @brief     カメラスキャンのプレビュー画面の向きを表す列挙体
 @note
 */
typedef NS_ENUM(NSInteger, PDLScanPreviewDirection) {
    
    // 端末の向きにあわせてプレビュー画面の向きが変更されます。
    // 端末の回転がロックされている場合でもプレビュー画面の向きは変更されます
    PDLScanPreviewDirectionSensor = 0,
    
    // 端末の向きにあわせてプレビュー画面の向きが変更されます。
    // 末の回転がロックされている場合、プレビュー画面の向きはロックされた画面の向きに固定されます。
    PDLScanPreviewDirectionUser = 1,
    
    // Landscape Left に固定されます。
    PDLScanPreviewDirectionLandscape = 2,
    
    // Portrait に固定されます。
    PDLScanPreviewDirectionPortrait = 3,
    
    // Landscape Right に固定されます。
    PDLScanPreviewDirectionLandscape180 = 4,
    
    // Upside Down に固定されます。
    PDLScanPreviewDirectionPortrait180 = 5,
};
