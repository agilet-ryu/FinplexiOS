//
//  SelectReadMethodViewController.h
//  FinplexiOS
//
//  Created by agilet-ryu on 2019/8/4.
//  Copyright © 2019 Fujitsu. All rights reserved.
//

#import "BaseViewController.h"
#import "SelectReadMethodView.h"
#import "DocModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SelectReadMethodViewController : BaseViewController
@property (nonatomic, strong) DocModel *currentModel;
@property (nonatomic, strong) UIButton *cameraScanButton;
@property (nonatomic, strong) UIButton *NFCBUtton;
@end

NS_ASSUME_NONNULL_END
