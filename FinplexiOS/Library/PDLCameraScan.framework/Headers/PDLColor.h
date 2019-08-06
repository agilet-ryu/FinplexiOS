//
//  Copyright PFU Limited 2018
//

// Frameworks
#import <Foundation/Foundation.h>

/*!
 @brief RGBA値を格納します。
 */
@interface PDLColor : NSObject

// 赤
// 0～255の範囲で指定できます。
@property(nonatomic) NSInteger red;

// 緑
// 0～255の範囲で指定できます
@property(nonatomic) NSInteger green;

// 青
// 0～255の範囲で指定できます。
@property(nonatomic) NSInteger blue;

// 透明度
// 0～1.0の範囲で指定できます。小数点第2位以下は切り捨てられます。
@property(nonatomic) double alpha;

/*!
 @brief  引数であたえられたPPDLColorのコピーを作成する
 @return PDLColorクラスのインスタンス
 */
+ (PDLColor *__nullable)copy:(PDLColor * __nonnull)from;

@end
