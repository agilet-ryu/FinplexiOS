//
//  ConfirmNecessaryDocResultViewController.h
//  FinplexiOS
//
//  Created by agilet-ryu on 2019/8/4.
//  Copyright © 2019 Fujitsu. All rights reserved.
//

#import "BaseViewController.h"
#import "DocModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ConfirmNecessaryDocResultViewController : BaseViewController
@property (nonatomic, strong) DocModel *currentModel;
@end

NS_ASSUME_NONNULL_END
