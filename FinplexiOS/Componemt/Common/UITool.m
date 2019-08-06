//
//  UITool.m
//  demoApp
//
//  Created by agilet on 2019/06/18.
//  Copyright © 2019 fujitsu. All rights reserved.
//

#import "UITool.h"
#import <UIKit/UIKit.h>

@implementation UITool

static UITool *tool;
+ (instancetype)shareUITool{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[UITool alloc] initWithBaseColor:nil baseTextColor:nil headerColor:nil bodyColor:nil headerTextColor:nil];
    });
    return tool;
}

- (instancetype)initWithBaseColor:(NSString *)baseColorHexString baseTextColor:(NSString *)baseTextColorHexString headerColor:(NSString *)headerColorHexString bodyColor:(NSString *)bodyColorHexString headerTextColor:(NSString *)headerTextColorHexString{
    self = [super init];
    if (self) {
        self.baseColorHexString = baseColorHexString;
        self.baseTextColorHexString = baseTextColorHexString;
        self.headerColorHexString = headerColorHexString;
        self.headerTextColorHexString = headerTextColorHexString;
        self.bodyColorHexString = bodyColorHexString;
        _lineColorHexString = @"eeeeee";
        _bodyTextColorHexString = @"565759";
        _inputTextColorHexString = @"706f67";
        _textSizeLarge = 22.0f;
        _textSizeMedium = 18.0f;
        _textSizeSmall = 16.0f;
        _textSizeMicro = 12.0f;
        _lineWidth = 2.0f;
    }
    return self;
}

- (void)setBaseTextColorHexString:(NSString *)baseTextColorHexString{
    _baseTextColorHexString = baseTextColorHexString.length ? baseTextColorHexString : @"ffffff";
}

- (void)setBaseColorHexString:(NSString *)baseColorHexString{
    _baseColorHexString = baseColorHexString.length ? baseColorHexString : @"a30b1a";
}

- (void)setHeaderColorHexString:(NSString *)headerColorHexString{
    _headerColorHexString = headerColorHexString.length ? headerColorHexString : @"ffffff";
}

- (void)setHeaderTextColorHexString:(NSString *)headerTextColorHexString{
    _headerTextColorHexString = headerTextColorHexString.length ? headerTextColorHexString : @"3c3c35";
}

- (void)setBodyColorHexString:(NSString *)bodyColorHexString{
    _bodyColorHexString = bodyColorHexString.length ? bodyColorHexString : @"ffffff";
}

-(CGFloat)heightWithWidth:(CGFloat)width font:(CGFloat)font str:(NSString *)string{
    UIFont * fonts = [UIFont systemFontOfSize:font];
    CGSize size =CGSizeMake(width, 1000000000000.0);
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:fonts,NSFontAttributeName ,nil];
    size = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return size.height;
}

@end
