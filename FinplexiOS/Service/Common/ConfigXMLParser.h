//
//  ConfigXMLParser.h
//  demoApp
//
//  Created by agilet-ryu on 2019/7/17.
//  Copyright © 2019 fujitsu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ConfigXMLParser : NSObject<NSXMLParserDelegate>


/**
 設定ファイルパラメータ展開
 */
- (void)start;
@end

NS_ASSUME_NONNULL_END
