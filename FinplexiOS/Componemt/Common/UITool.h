//
//  UITool.h
//  demoApp
//
//  Created by agilet on 2019/06/18.
//  Copyright © 2019 fujitsu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIColor+hexString.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define kNavAndStatusHight  self.navigationController.navigationBar.frame.size.height+[[UIApplication sharedApplication] statusBarFrame].size.height

#define AUTOx(x) (x * [UIScreen mainScreen].bounds.size.width / 750.0f)
#define AUTOy(y) (y * [UIScreen mainScreen].bounds.size.height / 1334.0f)

#define kLineWidth 2.0f
#define kButtonHeightLarge 60.0f
#define kButtonHeightMedium 50.0f
#define kButtonHeightSmall 30.0f
#define kButtonRadiusLarge 6.0f
#define kButtonRadiusMedium 6.0f
#define kFooterHeight 96.0f

#define kPaddingHeightSmall 4.0f
#define kPaddingHeightMedium 18.0f
#define kPaddingHeightLarge 30.0f
#define kPaddingwidthLarge 40.0f
#define kPaddingwidthMedium 16.0f

#define kFontSizeLarge [UIFont systemFontOfSize:[UITool shareUITool].textSizeLarge]
#define kFontSizeMedium [UIFont systemFontOfSize:[UITool shareUITool].textSizeMedium]
#define kFontSizeSmall [UIFont systemFontOfSize:[UITool shareUITool].textSizeSmall]

#define kBaseColor [UIColor colorWithHexString:[UITool shareUITool].baseColorHexString alpha:1.0f]
#define kBaseColorUnEnabled [UIColor colorWithHexString:[UITool shareUITool].baseColorHexString alpha:0.3f]
#define kBodyTextColor [UIColor colorWithHexString:[UITool shareUITool].bodyTextColorHexString alpha:1.0f]
#define kLineColor [UIColor colorWithHexString:[UITool shareUITool].lineColorHexString alpha:1.0f]
#define kBodyColor [UIColor colorWithHexString:[UITool shareUITool].bodyColorHexString alpha:1.0f]

NS_ASSUME_NONNULL_BEGIN

@interface UITool : NSObject

+ (instancetype)shareUITool;

@property (nonatomic, copy) NSString *baseColorHexString;
@property (nonatomic, copy) NSString *baseTextColorHexString;
@property (nonatomic, copy) NSString *headerColorHexString;
@property (nonatomic, copy) NSString *bodyColorHexString;
@property (nonatomic, copy) NSString *headerTextColorHexString;
@property (nonatomic, copy, readonly) NSString *lineColorHexString;
@property (nonatomic, copy, readonly) NSString *bodyTextColorHexString;
@property (nonatomic, copy, readonly) NSString *inputTextColorHexString;
@property (nonatomic, assign, readonly) CGFloat textSizeLarge;
@property (nonatomic, assign, readonly) CGFloat textSizeMedium;
@property (nonatomic, assign, readonly) CGFloat textSizeSmall;
@property (nonatomic, assign, readonly) CGFloat textSizeMicro;
@property (nonatomic, assign, readonly) CGFloat lineWidth;

-(CGFloat)heightWithWidth:(CGFloat)width font:(CGFloat)font str:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
