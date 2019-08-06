//
//  DrawFaceImage.h
//  FinplexiOS
//
//  Created by agilet-ryu on 2019/8/5.
//  Copyright © 2019 Fujitsu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DrawFaceImage : NSObject
#pragma mark - SF-011_顔画像トリミング
+ (UIImage *)getFaceImageWithOCRImage:(UIImage *)image;
+ (UIImage *)getFaceImageWithCameraScanImage:(UIImage *)image;
@end

NS_ASSUME_NONNULL_END
