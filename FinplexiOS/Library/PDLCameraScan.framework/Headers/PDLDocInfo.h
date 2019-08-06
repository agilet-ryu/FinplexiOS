//
//  Copyright PFU Limited 2018
//

// Frameworks
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// Public
#import "PDLScanPhotoMode.h"
#import "PDLCropResult.h"


/*!
 @brief カード全体の結果情報を格納するクラス
 */
@interface PDLDocInfo : NSObject

// カード全体の画像
@property (nonatomic, readonly, strong) UIImage * __null_unspecified image;

// 画像を撮影した時のモードを取得する
@property (nonatomic, readonly) PDLScanPhotoMode mode;

// 書類の切り出しが行なわれたかどうか結果を取得する
@property (nonatomic, readonly) enum PDLCropResult cropResult;

@end
