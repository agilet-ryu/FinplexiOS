//
//  DocModel.m
//  FinplexiOS
//
//  Created by agilet-ryu on 2019/8/4.
//  Copyright © 2019 Fujitsu. All rights reserved.
//

#import "DocModel.h"

@implementation DocModel
- (DocModel *)initWithKBNModel:(KBNModel *)KBNModel{
    self = [super init];
    if (self) {
        self.kbnModel = KBNModel;
        self.isSelected = NO;
    }
    return self;
}

@end
