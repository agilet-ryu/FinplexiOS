//
//  Copyright PFU Limited 2018
//

// Frameworks
#import <Foundation/Foundation.h>


/*!
 @brief カメラに関する設定情報を保持するクラス
 */
@interface PDLCameraScanParam : NSObject

// タイマーモードでシャッターを切るまでの時間を秒単位で取得および設定します。
// 1 ～ 99 の範囲でタイマーモードが有効となります。それ以外の値を指定すると、タイマーモードは無効となります。
// また、小数点以下の値は指定しても切り捨てられます。
// デフォルト：0（タイマーモード無効）
@property (nonatomic) NSInteger shutterForceSec;

// プレビュー画面中に映された書類がプレビュー画面の何割以上を占めたとき
// に自動シャッターが切られるかを決めるサイズ判定値を取得および設定します。
// 以下の条件のどちらかがサイズ判定値を上回ったとき自動シャッターが切られます。
// ・プレビュー画面に映った書類の幅／プレビュー画面の幅
// ・プレビュー画面に映った書類の高さ／プレビュー画面の高さ
// 0.6～0.9の範囲で指定できます。それ以外の値を指定すると、デフォルト値が設定されます。
// デフォルト：0.7
@property(nonatomic) double detectedDocSizeThreshold;

// 手動モードでシャッターを切った場合に、背景から書類を切り出すかどうかの設定状態を取得および設定します。
// YES：切り出す　NO：切り出さない
// デフォルト：YES(切り出す)
@property(nonatomic) BOOL isExtractionForManualMode;

@end
