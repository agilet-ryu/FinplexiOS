//
//  Copyright PFU Limited 2018
//

// Frameworks
#import <Foundation/Foundation.h>


/*!
 @brief 撮影ガイドの設定を格納するクラス
 */
@interface PDLScanGuideParam : NSObject

@property (nonatomic) BOOL visible;
@property (nonatomic) double size;

// 撮影する書類の幅[mm]
@property (nonatomic) double docWidth;

// 撮影する書類の高さ[mm]
@property (nonatomic) double docHeight;

@end
