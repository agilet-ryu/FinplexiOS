//
//  Copyright PFU Limited 2018
//

// Frameworks
#import <Foundation/Foundation.h>
#import "PDLColor.h"

/*!
 @brief カメラスキャンの警告メッセージに関する設定情報を取得および設定します。
 */
@interface PDLScanWarningParam : NSObject

// 警告メッセージの可視状態を取得および設定します。
// YES：表示　NO：非表示
// デフォルト：YES(表示)
@property(nonatomic) BOOL visible;

// 警告メッセージの色を取得および設定します。
// RGBA値で色を指定できます。詳細はPDLColorクラスを参照してください。
// デフォルト：
// red = 255
// green = 255
// blue = 0
// alpha = 1.0
@property(nonatomic) PDLColor *warningMsgColor;

// プレビュー画面が横向きのときの警告メッセージの文字サイズを取得および設定します。
// 1～10の範囲で指定できます。1はプレビュー画面の幅に対し警告メッセージの幅が1割、10はプレビュー画面の幅に対し警告メッセージ
// の幅が10割となる文字サイズで警告メッセージが表示されます。
// デフォルト：5
@property(nonatomic) NSInteger warningMsgFontSizeForLandscape;

// プレビュー画面が縦向きのときの警告メッセージの文字サイズを取得および設定します。
// 1～10の範囲で指定できます。1はプレビュー画面の幅に対し警告メッセージの幅が1割、10はプレビュー画面の幅に対し警告メッセージ
// の幅が10割となる文字サイズで警告メッセージが表示されます。
// デフォルト：9
@property(nonatomic) NSInteger warningMsgFontSizeForPortrait;

// 警告メッセージ表示位置を取得および設定します。
// 0～100の範囲で指定できます。0は上部 100は下部に表示されます。
// デフォルト：0
@property(nonatomic) NSInteger warningMsgTop;

@end
