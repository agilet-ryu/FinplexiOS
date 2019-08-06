//
//  initManager.m
//  demoApp
//
//  Created by tourituyou on 2019/7/8.
//  Copyright © 2019 fujitsu. All rights reserved.
//

#import "initManager.h"
#import "SplashViewController.h"

@interface initManager ()

@property (nonatomic, copy) FinplexResultBlock resultBlock;

@end

@implementation initManager

static initManager *manager = nil;

/**
 SDK初期化

 @param config 呼出元アプリ入力パラメータ
 @param currentController 呼出元アプリのController
 @param callBack オンライン本人確認ライブラリ処理結果応答
 @return Finplex初期化
 */
+ (instancetype)startFinplexWithConfig:(Config *)config
                            Controller:(UIViewController *)currentController
                              callback:(FinplexResultBlock)callBack {
    manager = [[initManager alloc] init];
    
    // スプラッシュ画面（G0010-01）初期化
    SplashViewController *splashVC = [[SplashViewController alloc] init];
    splashVC.config = config;
    UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:splashVC];
    [currentController presentViewController:naVC animated:YES completion:^{
    }];
    
    manager.resultBlock = callBack;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getSDKRsult:) name:@"LibraryEndNotification" object:nil];
    return manager;
}

+ (void)getSDKRsult:(NSNotification *)notification{
    ResultModel *result = notification.userInfo[@"key"];
    manager.resultBlock(result);
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
