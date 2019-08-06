//
//  StartShootingNecessaryDocView.m
//  FinplexiOS
//
//  Created by agilet-ryu on 2019/8/4.
//  Copyright © 2019 Fujitsu. All rights reserved.
//

#import "StartShootingNecessaryDocView.h"
#import "Utils.h"
#import "AppComLog.h"
#import "UITool.h"
#import "CameraScanManager.h"
#import "ConfirmNecessaryDocResultViewController.h"

@interface StartShootingNecessaryDocView ()<cameraScanManagerDelegate>
@property (strong, nonatomic) DocModel *currentModel;
@property (nonatomic, assign) BOOL isFront;
@property (nonatomic, strong) UIViewController *currentController;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *nextBTN;
@property (nonatomic, strong) UIButton *backBTN;
@property (nonatomic, strong) CameraScanManager *cameraScanManager;

@end

@implementation StartShootingNecessaryDocView

// カメラスキャン初期化
- (CameraScanManager *)cameraScanManager{
    if (!_cameraScanManager) {
        
        // 操作ログ編集
        [AppComLog writeEventLog:@"カメラスキャンの初期化処理" viewID:@"G0040-01" LogLevel:LOGLEVELInformation withCallback:^(NSString * _Nonnull resultCode) {
            
        } atController:self.currentController];
        _cameraScanManager = [CameraScanManager sharedCameraScanManager];
    }
    return _cameraScanManager;
}

- (instancetype)initWithModel:(DocModel *)currentModel andController:(UIViewController *)controller{
    self = [super init];
    if (self) {
        self.currentController = controller;
        [self setFrame:[UIScreen mainScreen].bounds];
        self.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.7f];
        self.currentModel = currentModel;
        self.isFront = YES;
        [controller.view addSubview:self];
        self.cameraScanManager.delegate = self;
    }
    return self;
}

// 画面を表示する
- (void)show{
    KBNModel *model = self.currentModel.kbnModel;
    float x = SCREEN_WIDTH * 0.1;
    float w = SCREEN_WIDTH * 0.8;
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(x, 190, w, SCREEN_HEIGHT - 370)];
    backView.backgroundColor = [UIColor whiteColor];
    //    backView.layer.borderColor = [UIColor colorWithHexString:[UITool shareUITool].lineColorHexString alpha:1.0f].CGColor;
    backView.layer.borderColor = kLineColor.CGColor;
    backView.layer.borderWidth = kLineWidth;
    backView.layer.masksToBounds = YES;
    [self addSubview:backView];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(kPaddingwidthMedium, 0, w - (kPaddingwidthMedium * 2), 90)];
    title.textAlignment = NSTextAlignmentCenter;
    title.font = kFontSizeMedium;
    title.textColor = kBodyTextColor;
    
    // 選択済み撮影書類の「撮影書類確認メッセージ」を設定する
    NSString *tint = self.isFront ? @"（表面）" : @"（裏面）";
    title.text = [NSString stringWithFormat:@"%@%@を撮影します。\nよろしいですか？", model.name, tint];
    title.numberOfLines = 0;
    [backView addSubview:title];
    self.titleLabel = title;
    
    // 選択済み撮影書類の「撮影書類イメージ画像」を設定する
    float backViewW = backView.frame.size.width;
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(55, 90, backViewW - 110, 120)];
    self.isFront ? [image setImage:[UIImage imageNamed:model.STM2]] : [image setImage:[UIImage imageNamed:model.STM3]];
    [backView addSubview:image];
    self.imageView = image;
    
    float buttonW = (backView.frame.size.width - kPaddingwidthMedium * 4) * 0.5;
    UIButton *backBT = [UIButton buttonWithType:UIButtonTypeCustom];
    backBT.backgroundColor = [UIColor whiteColor];
    
    [backBT addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [backBT setFrame:CGRectMake(kPaddingwidthMedium, 230, buttonW, kButtonHeightMedium)];
    [backBT setTitle:@"いいえ" forState:UIControlStateNormal];
    [backBT setTitleColor:kBaseColorUnEnabled forState:UIControlStateNormal];
    backBT.layer.borderWidth = kLineWidth;
    backBT.layer.borderColor = kBaseColorUnEnabled.CGColor;
    backBT.layer.cornerRadius = kButtonRadiusMedium;
    //        backBT.layer.shadowOpacity = 0.15f;
    //        backBT.layer.shadowOffset = CGSizeMake(4, 4);
    backBT.layer.masksToBounds = NO;
    backBT.userInteractionEnabled = NO;
    [backView addSubview:backBT];
    self.backBTN = backBT;
    
    UIButton *nextBT = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBT addTarget:self action:@selector(startCameraScan) forControlEvents:UIControlEventTouchUpInside];
    [nextBT setTitle:@"はい" forState:UIControlStateNormal];
    nextBT.backgroundColor = kBaseColorUnEnabled;
    //        nextBT.layer.shadowOpacity = 0.15f;
    //        nextBT.layer.shadowOffset = CGSizeMake(4, 4);
    nextBT.layer.cornerRadius = kButtonRadiusMedium;
    nextBT.layer.masksToBounds = NO;
    [nextBT setFrame:CGRectMake(buttonW + (kPaddingwidthMedium * 3), 230, buttonW, kButtonHeightMedium)];
    [backView addSubview:nextBT];
    nextBT.userInteractionEnabled = NO;
    self.nextBTN = nextBT;
}

/**
 カメラスキャン起動
 */
- (void)startCameraScan{
    
    // 操作ログ編集
    [AppComLog writeEventLog:@"はいボタン" viewID:@"G0040-01" LogLevel:LOGLEVELInformation withCallback:^(NSString * _Nonnull resultCode) {
        
    } atController:self.currentController];
    
    [self.cameraScanManager start];
    [self hideController:YES];
}

// 「G0040-01：本人確認書類撮影開始画面」画面を再表示する。
- (void)setIsFront:(BOOL)isFront{
    _isFront = isFront;
    KBNModel *model = self.currentModel.kbnModel;
    
    // 選択済み撮影書類の「撮影書類確認メッセージ」を設定する
    NSString *tint = isFront ? @"（表面）" : @"（裏面）";
    self.titleLabel.text = [NSString stringWithFormat:@"%@%@を撮影します。\nよろしいですか？", model.name, tint];
    
    // 選択済み撮影書類の「撮影書類イメージ画像」を設定する
    isFront ? [self.imageView setImage:[UIImage imageNamed:model.STM2]] : [self.imageView setImage:[UIImage imageNamed:model.STM3]];
}

#pragma mark - cameraScanManagerDelegate

// カメラスキャン初期化（リソース）結果_正常時
- (void)cameraScanPrepareSuccess{
    
    // いいえボタン活性状態で表示する
    [self enableBackBTN];
    
    // はいボタン活性状態で表示する
    [self enableNextBTN];
}

// 書類の認識成功時に呼び出されます。
- (void)cameraScanSuccessWithImage:(UIImage *)image andCropResult:(NSInteger)cropResult{
    
    // 操作ログ編集
    [AppComLog writeEventLog:@"カメラスキャン終了処理" viewID:@"G0050-01" LogLevel:LOGLEVELInformation withCallback:^(NSString * _Nonnull resultCode) {
        
    } atController:self.currentController];
    
    // 共通領域初期化
    InfoDatabase *db = [InfoDatabase shareInfoDatabase];
    
    if ([self.currentModel.kbnModel.STM1 isEqualToString:@"2"]) {
        if (self.isFront) {
            // 撮影回数＜指定回数分の場合
            // カメラスキャンより返却された撮影結果画像を共通領域へ設定する
            db.identificationData.OBVERSE_IMG = image;
            db.identificationData.IMG_CROPPING1 = cropResult == 0;
            
            // 「G0040-01：本人確認書類撮影開始画面」画面を再表示する。
            self.isFront = NO;
        } else {
            // 撮影回数＝指定回数分の場合
            // カメラスキャンより返却された撮影結果画像を共通領域へ設定する
            db.identificationData.REVERSE_IMG = image;
            db.identificationData.IMG_CROPPING2 = cropResult == 0;
            
            // カメラスキャンの関数_deinitResourceメソッドを呼び出し
            [self.cameraScanManager deinitResource];
            
            // 「G0060-01：本人確認書類撮影結果画面」に遷移する。
            ConfirmNecessaryDocResultViewController *vc = [[ConfirmNecessaryDocResultViewController alloc] init];
            vc.currentModel = self.currentModel;
            [self.currentController.navigationController pushViewController:vc animated:YES];
            [self hide];
        }
    } else {
        // 撮影回数＝指定回数分の場合
        // カメラスキャンより返却された撮影結果画像を共通領域へ設定する
        db.identificationData.OBVERSE_IMG = image;
        db.identificationData.IMG_CROPPING1 = cropResult == 0;
        
        // カメラスキャンの関数_deinitResourceメソッドを呼び出し
        [self.cameraScanManager deinitResource];
        
        // 「G0060-01：本人確認書類撮影結果画面」に遷移する。
        ConfirmNecessaryDocResultViewController *vc = [[ConfirmNecessaryDocResultViewController alloc] init];
        vc.currentModel = self.currentModel;
        [self.currentController.navigationController pushViewController:vc animated:YES];
        [self hide];
    }
}

// プレビュー／認識中に何らかのエラーが発生した場合に呼び出されます。
- (void)cameraScanFailure:(NSInteger)errorCode{
    
    // 操作ログ編集
    [AppComLog writeEventLog:@"カメラスキャン終了処理" viewID:@"G0050-01" LogLevel:LOGLEVELInformation withCallback:^(NSString * _Nonnull resultCode) {
        
    } atController:self.currentController];
    
    // カメラスキャン初期化またはカメラスキャン起動にてエラーが返却された場合、ポップアップでエラー内容に応じたメッセージを表示する。
    // ポップアップには「はい」ボタンのみ表示し、ライブラリにてエラー発生処理のリトライ等は実施しない。
    if (errorCode == 9100) {
        
        // エラーコード9100、ポップアップにて「メッセージコード：CM-001-04E」を表示する。
        [[ErrorManager shareErrorManager] showWithErrorCode:@"CM-001-04E" atCurrentController:self.currentController managerType:errorManagerTypeAlertClose addFirstMsg:@"" addSecondMsg:@""];
    } else {
        
        // エラーコード：9100以外、ポップアップにて「メッセージコード：CM-001-03E（%1：カメラ起動）」を表示する。
        [[ErrorManager shareErrorManager] showWithErrorCode:@"CM-001-03E" atCurrentController:self.currentController managerType:errorManagerTypeAlertClose addFirstMsg:@"カメラ起動" addSecondMsg:@""];
    }
    
    [self hideController:NO];
    
    // いいえボタン活性状態で表示する
    [self enableBackBTN];
}

// キャンセルボタンを押す時に呼び出されます。
- (void)cameraScanCancel{
    
    // 操作ログ編集
    [AppComLog writeEventLog:@"キャンセル" viewID:@"G0050-01" LogLevel:LOGLEVELInformation withCallback:^(NSString * _Nonnull resultCode) {
        
    } atController:self.currentController];
    [self hideController:NO];
}

// カメラスキャン起動成功時に呼び出されます。
- (void)cameraScanStart{
    
    // 操作ログ編集
    [AppComLog writeEventLog:@"カメラスキャン起動" viewID:@"G0050-01" LogLevel:LOGLEVELInformation withCallback:^(NSString * _Nonnull resultCode) {
        
    } atController:self.currentController];
    [self hideController:NO];
}

// ボタンタップ時
- (void)hide{
    
    // カメラスキャンの関数_deinitResourceメソッドを呼び出す。
    [self.cameraScanManager deinitResource];
    
    // 本画面を閉じる。
    [self removeFromSuperview];
}

// いいえボタン活性状態で表示する
- (void)enableBackBTN {
    self.backBTN.userInteractionEnabled = YES;
    [self.backBTN setTitleColor:kBaseColor forState:UIControlStateNormal];
    self.backBTN.layer.borderColor = kBaseColor.CGColor;
}

// はいボタン活性状態で表示する
- (void)enableNextBTN {
    self.nextBTN.userInteractionEnabled = YES;
    self.nextBTN.backgroundColor = kBaseColor;
}

- (void)hideController:(BOOL)isHidden{
    for (UIView *v in self.currentController.view.subviews) {
        v.hidden = isHidden;
    }
    [self.currentController.navigationController setNavigationBarHidden:isHidden animated:NO];
    self.currentController.view.backgroundColor = isHidden ? [UIColor blackColor] : [UIColor whiteColor];
}

@end
