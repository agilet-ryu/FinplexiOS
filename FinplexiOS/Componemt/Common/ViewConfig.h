//
//  ViewConfig.h
//  demoApp
//
//  Created by agilet-ryu on 2019/8/3.
//  Copyright © 2019 fujitsu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ViewModel : NSObject
@property (nonatomic, strong) NSString *viewID;
@property (nonatomic, strong) NSString *viewName;
@property (nonatomic, strong) NSString *viewTitle;
@property (nonatomic, strong) NSString *viewFirstDetail;
@property (nonatomic, strong) NSString *viewSecondDetail;
@property (nonatomic, assign) float viewProgress;

+ (instancetype)initViewModelWithViewID:(NSString *)viewID viewName:(NSString *)viewName viewTitle:(NSString *)viewTitle viewFirstDetail:(NSString *)viewFirstDetail viewSecondDetail:(NSString *)viewSecondDetail viewProgress:(float)viewProgress;
@end

@interface ViewConfig : NSObject
@property (nonatomic, strong) NSDictionary *viewDictionary;
@end

NS_ASSUME_NONNULL_END
