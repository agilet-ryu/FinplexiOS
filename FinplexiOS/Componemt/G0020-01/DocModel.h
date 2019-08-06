//
//  DocModel.h
//  FinplexiOS
//
//  Created by agilet-ryu on 2019/8/4.
//  Copyright © 2019 Fujitsu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Utils.h"

NS_ASSUME_NONNULL_BEGIN

@interface DocModel : NSObject
@property (nonatomic, strong) KBNModel *kbnModel;
@property (assign, nonatomic) BOOL isSelected;
- (DocModel *)initWithKBNModel:(KBNModel *)KBNModel;

@end

NS_ASSUME_NONNULL_END
