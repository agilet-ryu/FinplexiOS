//
//  SelectReadMethodViewController.m
//  FinplexiOS
//
//  Created by agilet-ryu on 2019/8/4.
//  Copyright © 2019 Fujitsu. All rights reserved.
//

#import "SelectReadMethodViewController.h"
#import "StartShootingNecessaryDocView.h"
#import "InputPasswordViewController.h"

@interface SelectReadMethodViewController ()
@property (nonatomic, assign) BOOL openCamera;  // ccameraScan又はNFC
@end

@implementation SelectReadMethodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 画面初期化
    [self initView];
    self.viewID = @"G0030-01";
}

- (void)initView{
    [self.cameraScanButton setFrame:CGRectMake(kPaddingwidthMedium, 164, SCREEN_WIDTH - (kPaddingwidthMedium * 2), 150)];
    [self.cameraScanButton addTarget:self action:@selector(didBt1Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.cameraScanButton];
    
    [self.NFCBUtton setFrame:CGRectMake(kPaddingwidthMedium, 360, SCREEN_WIDTH - (kPaddingwidthMedium * 2), 150)];
    [self.NFCBUtton addTarget:self action:@selector(didBt2Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.NFCBUtton];
}

// 次へボタンタップ時
- (void)didFooterButtonClicked {
    [super didFooterButtonClicked];
    
    // 共通領域初期化
    InfoDatabase *db = [InfoDatabase shareInfoDatabase];
    SystemCode *sysCode = [Utils getSystemCode];
    int camera = sysCode.read_method_KBN.CAMERA.code;
    int nfc = sysCode.read_method_KBN.NFC.code;
    
    if (self.openCamera) {
        
        // 本人確認内容データの読取方法「1:カメラ撮影」を設定する。
        db.identificationData.GAIN_TYPE = camera;
        
        // 「カメラ撮影」を選択済の場合、「G0040-01：本人確認書類撮影開始前画面」へ遷移する。
        StartShootingNecessaryDocView *view = [[StartShootingNecessaryDocView alloc] initWithModel:self.currentModel andController:self];
        [view show];
    } else {
        
        // 本人確認内容データの読取方法「2:NFC読取」を設定する。
        db.identificationData.GAIN_TYPE = nfc;
        
        // 「NFC読み取り」を選択済の場合、「G0070-01：暗証番号入力画面」へ遷移する。
        InputPasswordViewController *vc = [[InputPasswordViewController alloc] init];
        vc.currentModel = self.currentModel;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    int tmpDoc = db.identificationData.DOC_TYPE;
    int tmpRead = db.identificationData.GAIN_TYPE;
    db.identificationData = [IDENTIFICATION_DATA new];
    db.identificationData.DOC_TYPE = tmpDoc;
    db.identificationData.GAIN_TYPE = tmpRead;
}

// 「カメラ撮影」ボタンタップ時
- (void)didBt1Clicked:(UIButton *)button{
    [self controlNextButton:YES];
}

// 「NFC読み取り」ボタンタップ時
- (void)didBt2Clicked:(UIButton *)button{
    [self controlNextButton:NO];
}

// ボタンを制御する
- (void)controlNextButton:(BOOL)isOpenCamera{
    self.openCamera = isOpenCamera;
    self.buttonInteractionEnabled = YES;
    self.cameraScanButton.layer.borderColor = isOpenCamera ? kBaseColor.CGColor : kLineColor.CGColor;
    self.NFCBUtton.layer.borderColor = isOpenCamera ? kLineColor.CGColor : kBaseColor.CGColor;
}

@end
