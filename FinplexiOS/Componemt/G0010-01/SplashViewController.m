//
//  SplashViewController.m
//  FinplexiOS
//
//  Created by agilet-ryu on 2019/8/4.
//  Copyright © 2019 Fujitsu. All rights reserved.
//

#import "SplashViewController.h"
#import "NSString+checkString.h"
#import "NSArray+checkArray.h"
#import "ConfigXMLParser.h"
#import "AppComGetFaceIDSign.h"
#import "SelectNecessaryDocViewController.h"

@interface SplashViewController ()
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
@end

@implementation SplashViewController
static InfoDatabase *db = nil;

- (void)viewDidLoad {
    [super viewDidLoad];
    db = [InfoDatabase shareInfoDatabase];
    // スプラッシュ画面を初期化する
    self.viewID = @"G0010-01";
    self.buttonHidden = YES;
    [self setIndicator];
    
    // 呼出元アプリ入力パラメータを処理する
    [self dealWithParam];
}

/**
 スプラッシュ画面を初期化する
 */
- (void)setIndicator {
    UIActivityIndicatorView *v = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    v.frame= CGRectMake((SCREEN_WIDTH - 200) * 0.5, (SCREEN_HEIGHT - 200) * 0.5, 200, 200);
    v.color = [UIColor lightGrayColor];
    [self.view addSubview:v];
    [v startAnimating];
    self.indicatorView = v;
}

/**
 呼出元アプリ入力パラメータを処理する
 */
- (void)dealWithParam {
    
    // 呼出元アプリ入力パラメータチェック
    NSMutableArray *errorArray = [NSMutableArray array];
    if ([NSString isBlankString:self.config.API_SECRET]) {
        [errorArray addObject:@"EC01-001"];
    }
    if ([NSString isBlankString:self.config.UUID]) {
        [errorArray addObject:@"EC01-004"];
    }
    if (!self.config.THREHOLDS_LEVEL) {
        [errorArray addObject:@"EC01-002"];
    }
    if (!self.config.IMAGE_TYPE) {
        [errorArray addObject:@"EC01-005"];
    }
    
    if ([NSArray isBlankArray:errorArray]) {
        
        // エラーなし時、呼出元アプリ入力パラメータ展開
        db.startParam = self.config;
        
        // 設定ファイルパラメータ展開
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Config.plist" ofType:nil];
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
        for (NSString *key in dic) {
            id value = dic[key];
            [db.configFileData setValue:value forKeyPath:key];
        }

        // 操作ログ編集
        [AppComLog writeEventLog:@"G0010-01" viewID:@"SF-002認証" LogLevel:LOGLEVELInformation withCallback:^(NSString * _Nonnull resultCode) {
            
        } atController:self];
        
        // 「SF-002：認証」機能を呼び出す。
        __weak typeof(self) weakSelf = self;
        [AppComGetFaceIDSign getFaceIDSignWithController:self andCallback:^(NSString * _Nonnull result) {
            if (result && [result isEqualToString:@"1"]) {
                [weakSelf.indicatorView stopAnimating];
                SelectNecessaryDocViewController *vc = [[SelectNecessaryDocViewController alloc] init];
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
        }];
    } else{
        
        // エラーあり時
        NSString * errorCode = [errorArray firstObject];
        
        // エラーコードを共通領域の「本人確認内容データ.エラーコード」へ設定する
        // 共通領域の「本人確認内容データ.認証処理結果」へ「異常」を設定する
        // ポップアップでエラーメッセージ「SF-001-01E」を表示する。
        [[ErrorManager shareErrorManager] dealWithErrorCode:errorCode msg:@"SF-001-01E" andController:self];
    }
}

@end
