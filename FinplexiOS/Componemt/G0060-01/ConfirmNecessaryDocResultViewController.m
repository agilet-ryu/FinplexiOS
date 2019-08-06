//
//  ConfirmNecessaryDocResultViewController.m
//  FinplexiOS
//
//  Created by agilet-ryu on 2019/8/4.
//  Copyright © 2019 Fujitsu. All rights reserved.
//

#import "ConfirmNecessaryDocResultViewController.h"
#import "AppComReadOCR.h"
#import "AppComFaceIDgetToken.h"
#import "StartDetectFaceViewController.h"
#import "CameraScanManager.h"
#import "OCRReadResultViewController.h"
#import "DrawFaceImage.h"

@interface ConfirmNecessaryDocResultViewController ()<cameraScanManagerDelegate>
@property (nonatomic, assign) BOOL isFront;
@property (nonatomic, strong) CameraScanManager *cameraScanManager;
@property (nonatomic, strong) UILabel *backTitle;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIImageView *img1;
@property (nonatomic, strong) UIImageView *img2;
@property (nonatomic, strong) UIButton *checkbox1;
@property (nonatomic, strong) UIButton *checkbox2;
@property (nonatomic, strong) UIButton *camera1;
@property (nonatomic, strong) UIButton *camera2;
@end

@implementation ConfirmNecessaryDocResultViewController
static InfoDatabase *db = nil;

- (CameraScanManager *)cameraScanManager{
    if (!_cameraScanManager) {
        
        // 操作ログ編集
        [AppComLog writeEventLog:@"カメラスキャンの初期化処理" viewID:@"G0060-01" LogLevel:LOGLEVELInformation withCallback:^(NSString * _Nonnull resultCode) {
            
        } atController:self];
        _cameraScanManager = [CameraScanManager sharedCameraScanManager];
        _cameraScanManager.delegate = self;
    }
    return _cameraScanManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    db = [InfoDatabase shareInfoDatabase];
    [self initView];
    [self initScrollView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.img1 setImage:[InfoDatabase shareInfoDatabase].identificationData.OBVERSE_IMG];
}

- (void)initView {
    // 本人確認書類切り出し状態が「0:切り出し済み」の場合、非活性状態とする、「2:未切り出し」の場合、非表示状態とする。
    
    if ([self.currentModel.kbnModel.STM1 isEqualToString:@"2"]) {
        self.buttonHidden = db.identificationData.IMG_CROPPING1 && db.identificationData.IMG_CROPPING2;
    }else{
        self.buttonHidden = db.identificationData.IMG_CROPPING1;
    }
}

- (void)initScrollView{
    IDENTIFICATION_DATA *iData = db.identificationData;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kNavAndStatusHight, SCREEN_WIDTH, SCREEN_HEIGHT - kFooterHeight)];
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    // 本人確認書類切り出し状態を判断し、撮影結果書類の確認案内メッセージを表示する
    if ([self.currentModel.kbnModel.STM1 isEqualToString:@"2"]) {
        self.detailString = (iData.IMG_CROPPING1 && iData.IMG_CROPPING2) ? self.currentViewModel.viewSecondDetail : self.currentViewModel.viewFirstDetail;
    }else{
        self.detailString = iData.IMG_CROPPING1 ? self.currentViewModel.viewSecondDetail : self.currentViewModel.viewFirstDetail;
    }
    self.detailLabel = self.headerLabel;
    [self.detailLabel setFrame:CGRectMake(kPaddingwidthMedium, 0, SCREEN_WIDTH - (kPaddingwidthMedium * 2), 100)];
    [scrollView addSubview:self.detailLabel];
    [self.headerLabel removeFromSuperview];
    
    UILabel *frontTitle = [[UILabel alloc] initWithFrame:CGRectMake(kPaddingwidthMedium, self.positionY, (SCREEN_WIDTH - kPaddingwidthMedium * 2), 25)];
    frontTitle.textAlignment = NSTextAlignmentCenter;
    frontTitle.text = [NSString stringWithFormat:@"表面"];
    frontTitle.font = kFontSizeMedium;
    [scrollView addSubview:frontTitle];
    
    UIImageView *img1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pic3"]];
    
    // 共通領域.本人確認内容データ.本人確認書類画像1を表示する。
    [img1 setImage:iData.OBVERSE_IMG];
    [img1 setFrame:CGRectMake(40, 145, [UIScreen mainScreen].bounds.size.width - 80, 200)];
    [scrollView addSubview:img1];
    self.img1 = img1;
    
    UIButton *check1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [check1 setFrame:CGRectMake(40, 425, [UIScreen mainScreen].bounds.size.width - 80, 30)];
    [check1 addTarget:self action:@selector(didCheck1:) forControlEvents:UIControlEventTouchUpInside];
    [check1 setImage:[UIImage imageNamed:@"pic5"] forState:UIControlStateNormal];
    [check1 setImage:[UIImage imageNamed:@"pic6"] forState:UIControlStateSelected];
    [check1 setTitleColor:kBodyTextColor forState:UIControlStateNormal];
    [check1 setTitle:@"確認しました。" forState:UIControlStateNormal];
    check1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [scrollView addSubview:check1];
    
    // 本人確認書類切り出し状態が「2:未切り出し」の場合、非表示状態とする
    check1.hidden = !iData.IMG_CROPPING1;
    self.checkbox1 = check1;
    
    UIButton *BT1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [BT1 setFrame:CGRectMake(40, 365, SCREEN_WIDTH - 80, kButtonHeightMedium)];
    BT1.backgroundColor = [UIColor whiteColor];
    [BT1 setTitle:@"再撮影" forState:UIControlStateNormal];
    [BT1 addTarget:self action:@selector(didBT1Click) forControlEvents:UIControlEventTouchUpInside];
    [BT1 setTitleColor:kBaseColor forState:UIControlStateNormal];
    BT1.layer.borderWidth = kLineWidth;
    BT1.layer.cornerRadius = kButtonRadiusMedium;
    BT1.layer.borderColor = kBaseColor.CGColor;
    BT1.layer.masksToBounds = YES;
    BT1.userInteractionEnabled = !check1.isSelected;
    [scrollView addSubview:BT1];
    self.camera1 = BT1;
    
    if ([self.currentModel.kbnModel.STM1 isEqualToString:@"2"]) {
        
        // 共通領域.本人確認内容データ.本人確認書類区分より、システム内コード定義.ID_DOC_KBN.コードと合致する、システム内コード定義.ID_DOC_KBN.補足情報1が 2 の場合、初期値で表示状態とする。
        UILabel *backTitle = [[UILabel alloc] initWithFrame:CGRectMake(kPaddingwidthMedium, 485, SCREEN_WIDTH - (kPaddingwidthMedium * 2), 25)];
        backTitle.textAlignment = NSTextAlignmentCenter;
        backTitle.text = [NSString stringWithFormat:@"裏面"];
        backTitle.font = kFontSizeMedium;
        [scrollView addSubview:backTitle];
        self.backTitle = backTitle;
        
        UIImageView *img2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pic4"]];
        [img2 setImage:iData.REVERSE_IMG];
        [img2 setFrame:CGRectMake(40, 530, SCREEN_WIDTH - 80, 200)];
        [scrollView addSubview:img2];
        self.img2 = img2;
        
        UIButton *check = [UIButton buttonWithType:UIButtonTypeCustom];
        [check setFrame:CGRectMake(40, 810, SCREEN_WIDTH - 80, 30)];
        [check addTarget:self action:@selector(didCheck2:) forControlEvents:UIControlEventTouchUpInside];
        [check setImage:[UIImage imageNamed:@"pic5"] forState:UIControlStateNormal];
        [check setImage:[UIImage imageNamed:@"pic6"] forState:UIControlStateSelected];
        [check setTitleColor:kBodyTextColor forState:UIControlStateNormal];
        [check setTitle:@"確認しました。" forState:UIControlStateNormal];
        check.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [scrollView addSubview:check];
        check.hidden = !iData.IMG_CROPPING2;
        self.checkbox2 = check;
        
        UIButton *BT2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [BT2 setFrame:CGRectMake(40, 750, SCREEN_WIDTH - 80, kButtonHeightMedium)];
        [BT2 setTitle:@"再撮影" forState:UIControlStateNormal];
        [BT2 addTarget:self action:@selector(didBT2Click) forControlEvents:UIControlEventTouchUpInside];
        
        BT2.backgroundColor = [UIColor whiteColor];
        [BT2 setTitleColor:kBaseColor forState:UIControlStateNormal];
        BT2.layer.borderWidth = kLineWidth;
        BT2.layer.cornerRadius = kButtonRadiusMedium;
        BT2.layer.borderColor = kBaseColor.CGColor;
        BT2.layer.masksToBounds = YES;
        
        BT2.userInteractionEnabled = !check.isSelected;
        [scrollView addSubview:BT2];
        self.camera2 = BT2;
    }
    [scrollView setContentSize:CGSizeMake(SCREEN_WIDTH, 850)];
}

#pragma mark - 再撮影を押す
- (void)didBT1Click{

    // 操作ログ編集
    [AppComLog writeEventLog:@"再撮影ボタン" viewID:@"G0060-01" LogLevel:LOGLEVELInformation withCallback:^(NSString * _Nonnull resultCode) {
        
    } atController:self];
    
    // 再撮影ボタンタップ、カメラスキャンの関数_setConfigメソッドを呼び出し、カメラスキャンの設定を更新する。
    self.cameraScanManager.delegate = self;
    self.isFront = YES;
}

- (void)didBT2Click{
    
    // 操作ログ編集
    [AppComLog writeEventLog:@"再撮影ボタン" viewID:@"G0060-01" LogLevel:LOGLEVELInformation withCallback:^(NSString * _Nonnull resultCode) {
        
    } atController:self];
    
    // 再撮影ボタンタップ、カメラスキャンの関数_setConfigメソッドを呼び出し、カメラスキャンの設定を更新する。
    self.cameraScanManager.delegate = self;
    self.isFront = NO;
}

#pragma mark - cameraScanDelegate

// カメラスキャン初期化（リソース）結果_正常時
- (void)cameraScanPrepareSuccess{
    [self startCamera];
}

// カメラスキャン起動
- (void)startCamera{
    [self.cameraScanManager start];
    for (UIView *v in self.view.subviews) {
        v.hidden = YES;
    }
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.view.backgroundColor = [UIColor blackColor];
}

// 書類の認識成功時に呼び出されます。
- (void)cameraScanSuccessWithImage:(UIImage *)image andCropResult:(NSInteger)cropResult{
    
    // 操作ログ編集
    [AppComLog writeEventLog:@"カメラスキャン終了処理" viewID:@"G0050-01" LogLevel:LOGLEVELInformation withCallback:^(NSString * _Nonnull resultCode) {
        
    } atController:self];
    
    // カメラスキャンの関数_deinitResourceメソッドを呼び出す。
    [self.cameraScanManager deinitResource];
    
    if (self.isFront) {
        
        // 撮影回数＜指定回数分の場合
        // カメラスキャンより返却された撮影結果画像を共通領域へ設定する
        db.identificationData.OBVERSE_IMG = image;
        db.identificationData.IMG_CROPPING1 = cropResult == 0;
        self.checkbox1.hidden = !db.identificationData.IMG_CROPPING1;
        
        // 書類撮影結果（表面）画像を再撮影画像に差し替える。
        [self.img1 setImage:image];
    } else{
        
        // 撮影回数＝指定回数分の場合
        // カメラスキャンより返却された撮影結果画像を共通領域へ設定する
        db.identificationData.REVERSE_IMG = image;
        db.identificationData.IMG_CROPPING2 = cropResult == 0;
        self.checkbox2.hidden = !db.identificationData.IMG_CROPPING2;
        
        // 書類撮影結果（裏面）画像を再撮影画像に差し替える。
        [self.img2 setImage:image];
    }
    
    // 共通領域.本人確認内容データ.本人確認書類切り出し状態を判断し、撮影結果書類の確認案内メッセージを表示する
    // 共通領域.本人確認内容データ.本人確認書類切り出し状態が「2:未切り出し」の場合、非表示状態とする
    if ([self.currentModel.kbnModel.STM1 isEqualToString:@"2"]) {
        self.buttonHidden = db.identificationData.IMG_CROPPING1 && db.identificationData.IMG_CROPPING2;
        self.detailLabel.text = (db.identificationData.IMG_CROPPING1 && db.identificationData.IMG_CROPPING2) ? self.currentViewModel.viewSecondDetail : self.currentViewModel.viewFirstDetail;
    }else{
        self.buttonHidden = db.identificationData.IMG_CROPPING1;
        self.detailLabel.text = db.identificationData.IMG_CROPPING1 ? self.currentViewModel.viewSecondDetail : self.currentViewModel.viewFirstDetail;
    }
}

// プレビュー／認識中に何らかのエラーが発生した場合に呼び出されます。
- (void)cameraScanFailure:(NSInteger)errorCode{
    
    // 操作ログ編集
    [AppComLog writeEventLog:@"カメラスキャン終了処理" viewID:@"G0050-01" LogLevel:LOGLEVELInformation withCallback:^(NSString * _Nonnull resultCode) {
        
    } atController:self];
    
    // カメラスキャン初期化またはカメラスキャン起動にてエラーが返却された場合、ポップアップでエラー内容に応じたメッセージを表示する。
    // ポップアップには「はい」ボタンのみ表示し、ライブラリにてエラー発生処理のリトライ等は実施しない。
    if (errorCode == 9100) {
        
        // エラーコード9100、ポップアップにて「メッセージコード：CM-001-04E」を表示する。
        [[ErrorManager shareErrorManager] showWithErrorCode:@"CM-001-04E" atCurrentController:self managerType:errorManagerTypeAlertClose addFirstMsg:@"" addSecondMsg:@""];
    } else {
        
        // エラーコード：9100以外、ポップアップにて「メッセージコード：CM-001-03E（%1：カメラ起動）」を表示する。
        [[ErrorManager shareErrorManager] showWithErrorCode:@"CM-001-03E" atCurrentController:self managerType:errorManagerTypeAlertClose addFirstMsg:@"カメラ起動" addSecondMsg:@""];
    }
}

// キャンセルボタンを押す時に呼び出されます。
- (void)cameraScanCancel{
    
    // 操作ログ編集
    [AppComLog writeEventLog:@"キャンセル" viewID:@"G0050-01" LogLevel:LOGLEVELInformation withCallback:^(NSString * _Nonnull resultCode) {
        
    } atController:self];
    
    // カメラスキャンの関数_deinitResourceメソッドを呼び出す。
    [self.cameraScanManager deinitResource];
}

// カメラスキャン起動成功時に呼び出されます。
- (void)cameraScanStart{
    
    // 操作ログ編集
    [AppComLog writeEventLog:@"カメラスキャン起動" viewID:@"G0050-01" LogLevel:LOGLEVELInformation withCallback:^(NSString * _Nonnull resultCode) {
        
    } atController:self];
    
    for (UIView *v in self.view.subviews) {
        v.hidden = NO;
    }
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - 次処理へ遷移
- (void)didFooterButtonClicked{
    [super didFooterButtonClicked];
    
    IDENTIFICATION_DATA *iData = db.identificationData;
    CONFIG_FILE_DATA *configData = db.configFileData;
    int enable = [Utils getSystemCode].enable_KBN.ENFORCE.code;
    if (configData.OCR_ENABLE == enable) {
        
        // 共通領域.設定ファイルデータ.OCR機能有効化フラグ＝ 1:有効の場合
        if (iData.OCR_REQUEST >= configData.OCR_LIMIT) {
            
            // 共通領域.本人確認内容データ.OCRリクエスト回数＝共通領域.設定ファイルデータ.サーバOCRre-Try回数の場合、ポップアップにて「メッセージコード：CM-001-05E」を表示する。
            [[ErrorManager shareErrorManager] dealWithErrorCode:@"EC06-001" msg:@"CM-001-05E" andController:self];
        } else {
            
            // 操作ログ編集
            [AppComLog writeEventLog:@"SF-010サーバOCR" viewID:@"G0060-01" LogLevel:LOGLEVELInformation withCallback:^(NSString * _Nonnull resultCode) {
                
            } atController:self];
            
            // 共通領域.本人確認内容データ.OCRリクエスト回数＜共通領域.設定ファイルデータ.サーバOCRre-Try回数の場合、「SF-010：サーバOCR」を呼び出す。
            __weak typeof(self) weakSelf = self;
            [AppComReadOCR readOCRWithController:self andCallback:^(NSString * _Nonnull result, NSString * _Nonnull errorCode) {
                if ([result isEqualToString:@"1"] && errorCode.length) {
                    
                    // エラーの場合
                    if ([errorCode isEqualToString:@"networkError"]) {
                        
                        // 通信エラーの場合
                        // ポップアップにて「メッセージコード：CM-001-05E」を表示する。
                        [[ErrorManager shareErrorManager] showWithErrorCode:@"CM-001-05E" atCurrentController:weakSelf managerType:errorManagerTypeAlertClose addFirstMsg:@"" addSecondMsg:@""];
                    }else if ([errorCode isEqualToString:@"EC10-002"]){
                        
                        // 「エラーコード」が「EC10-002」有効期限切れの場合
                        // ポップアップにて「メッセージコード：SF-008-5E」を表示する。
                        [[ErrorManager shareErrorManager] dealWithErrorCode:@"EC10-002" msg:@"SF-008-5E" andController:weakSelf];
                    }else{
                        
                        // 共通領域.本人確認内容データ.OCRリクエスト回数を1カウントアップする。
                        db.identificationData.OCR_REQUEST++;
                        
                        if (db.identificationData.OCR_REQUEST < configData.OCR_LIMIT) {
                            
                            // 共通領域.本人確認内容データ.OCRリクエスト回数＜共通領域.設定ファイルデータ.サーバOCRre-Try回数の場合
                            // ポップアップにて「メッセージコード：SF-006-01E」を表示する。
                            [[ErrorManager shareErrorManager] showWithErrorCode:@"SF-006-01E" atCurrentController:weakSelf managerType:errorManagerTypeAlertClose addFirstMsg:@"" addSecondMsg:@""];
                        }else{
                            
                            // 共通領域.本人確認内容データ.OCRリクエスト回数>＝共通領域.設定ファイルデータ.サーバOCRre-Try回数の場合
                            // ポップアップにて「メッセージコード：CM-001-05E」を表示する。
                            [[ErrorManager shareErrorManager] dealWithErrorCode:errorCode msg:@"CM-001-05E" andController:weakSelf];
                        }
                    }
                }else{
                    // 共通領域.本人確認内容データ.OCRリクエスト回数を1カウントアップする。
                    db.identificationData.OCR_REQUEST++;
                    
                    // 「SF-011：顔画像トリミング」を呼び出す
                    [DrawFaceImage getFaceImageWithOCRImage:db.identificationData.OBVERSE_IMG];
                    
                    // 「G0160-01：OCR結果表示画面」へ遷移する。
                    OCRReadResultViewController *ocr = [[OCRReadResultViewController alloc] init];
                    ocr.currentModel = self.currentModel;
                    ocr.jsStr = [Utils getHtmlParam];
                    [self.navigationController pushViewController:ocr animated:YES];
                }
            }];
        }
    } else{
        
        // 共通領域.設定ファイルデータ.OCR機能有効化フラグ＝ 0:無効の場合、
        
        // 操作ログ編集
        [AppComLog writeEventLog:@"SF-011顔画像トリミング" viewID:@"G0060-01" LogLevel:LOGLEVELInformation withCallback:^(NSString * _Nonnull resultCode) {
            
        } atController:self];
        
        // 「SF-011：顔画像トリミング」を呼び出す。
        [DrawFaceImage getFaceImageWithCameraScanImage:iData.OBVERSE_IMG];
        
        // 操作ログ編集
        [AppComLog writeEventLog:@"SF-104FaceIDトークン取得" viewID:@"G0060-01" LogLevel:LOGLEVELInformation withCallback:^(NSString * _Nonnull resultCode) {
            
        } atController:self];
        
        // 「SF-104：FaceIDトークン取得」を呼び出す。
        [AppComFaceIDgetToken sendGetFaceIDTokenRequestWithController:self andCallback:^(NSString * _Nonnull result) {
            if ([result isEqualToString:@"1"]) {
                
                // 「G0100-01：自然人検知開始前画面」へ遷移する。
                StartDetectFaceViewController *f = [[StartDetectFaceViewController   alloc] init];
                [self.navigationController pushViewController:f animated:YES];
            }
        }];
    }
}

#pragma mark - checkbox点击时
- (void)didCheck1:(UIButton *)button{
    [self checkNextButton:button andCameraButton:self.camera1];
}
- (void)didCheck2:(UIButton *)button{
    [self checkNextButton:button andCameraButton:self.camera2];
}
- (void)checkNextButton:(UIButton *)button andCameraButton:(UIButton *)cameraButton{
    button.selected = !button.isSelected;
    
    cameraButton.backgroundColor = button.isSelected ? kBaseColorUnEnabled : [UIColor whiteColor];
    cameraButton.layer.borderColor = button.isSelected ? [UIColor clearColor].CGColor : kBaseColor.CGColor;
    cameraButton.userInteractionEnabled = !button.isSelected;
    button.isSelected ? [cameraButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal] : [cameraButton setTitleColor:kBaseColor forState:UIControlStateNormal];
    
    self.buttonInteractionEnabled = self.checkbox1.isSelected && self.checkbox2.isSelected;
}


@end
