//
//  SelectReadMethodView.h
//  FinplexiOS
//
//  Created by agilet-ryu on 2019/8/4.
//  Copyright © 2019 Fujitsu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SystemCode.h"

NS_ASSUME_NONNULL_BEGIN

@interface SelectReadMethodView : NSObject
- (UIButton *)getCameraScanButtonWithKBNModel:(KBNModel *)model;
- (UIButton *)getNFCButtonWithKBNModel:(KBNModel *)model;
@end

NS_ASSUME_NONNULL_END
