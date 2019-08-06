//
//  Copyright PFU Limited 2018
//

// Frameworks
#import <Foundation/Foundation.h>
#import "PDLScanPreviewDirection.h"

/*!
 @brief カメラスキャンのプレビュー画面に関する設定情報を取得および設定します。
 */
@interface PDLScanPreviewParam : NSObject

// プレビュー画面の向きを取得および設定します。
// 指定できる向きについては列挙体のPDLScanPreviewDirectionを参照してください。
// デフォルト：Sensor（端末の向きに依存）
@property(nonatomic) enum PDLScanPreviewDirection previewDirection;

//// プレビュー画面を旧UI(本人確認カメラOCRのUI)に切り替えるかどうかの設定状態を取得および設定します。
//@property(nonatomic) BOOL switchOldPreviewUI;
@end
