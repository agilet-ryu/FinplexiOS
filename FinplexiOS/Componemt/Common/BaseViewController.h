//
//  BaseViewController.h
//  demoApp
//
//  Created by agilet-ryu on 2019/8/3.
//  Copyright © 2019 fujitsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewConfig.h"
#import "AppComLog.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController

@property (nonatomic, strong) NSString *viewID;
@property (nonatomic, strong) ViewModel *currentViewModel;
@property (nonatomic, strong) NSString *detailString;
@property (nonatomic, assign) BOOL buttonInteractionEnabled;
@property (nonatomic, assign) BOOL buttonHidden;
@property (nonatomic, assign) float positionY;
@property (nonatomic, strong) UILabel *headerLabel;

- (void)didFooterButtonClicked;
@end


NS_ASSUME_NONNULL_END
