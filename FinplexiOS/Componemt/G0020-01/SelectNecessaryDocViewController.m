//
//  SelectNecessaryDocViewController.m
//  FinplexiOS
//
//  Created by agilet-ryu on 2019/8/4.
//  Copyright © 2019 Fujitsu. All rights reserved.
//

#import "SelectNecessaryDocViewController.h"
#import "SelectNecessaryDocTableViewCell.h"
#import "SelectReadMethodViewController.h"
#import "StartShootingNecessaryDocView.h"
#import "InputPasswordViewController.h"

@interface SelectNecessaryDocViewController ()<UITableViewDelegate, UITableViewDataSource, SelectNecessaryDocTableViewCellDelegate>
@property (strong, nonatomic) NSMutableArray <DocModel *>*modelList; // 書類配列
@property (nonatomic, strong) UITableView *docTable;
@property (strong, nonatomic) DocModel *currentModel; // 選択する書類
@end

@implementation SelectNecessaryDocViewController
static InfoDatabase *db = nil;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 共通領域のデータを取得する
    db = [InfoDatabase shareInfoDatabase];
    [self initData];
    
    // 画面初期化
    self.viewID = @"G0020-01";
    [self initSubView];
}

// 共通領域のデータを取得する
- (void)initData{
    // 共通領域初期化
    CONFIG_FILE_DATA *configDB = db.configFileData;
    SystemCode *sysCode = [Utils getSystemCode];
    
    int enable = sysCode.identification_KBN.IDENTIFICATION_ENABLE.code;
    ID_DOC_KBN * idDoc = sysCode.id_doc_KBN;
    
    // 設定ファイルデータで有効となっている本人確認書類に対し、選択ボタンを表示する。
    self.modelList = [NSMutableArray array];
    if (configDB.IDENTIFICATION_DOCUMENT_DRIVERS_LICENCE == enable) [self.modelList addObject:[[DocModel alloc] initWithKBNModel:idDoc.CARD_DRIVER]];
    
    if (configDB.IDENTIFICATION_DOCUMENT_MYNUMBER == enable) [self.modelList addObject:[[DocModel alloc] initWithKBNModel:idDoc.CARD_MYNUMBER]];
    
    if (configDB.IDENTIFICATION_DOCUMENT_PASSPORT == enable) [self.modelList addObject:[[DocModel alloc] initWithKBNModel:idDoc.CARD_PASSPORT]];
    
    if (configDB.IDENTIFICATION_DOCUMENT_RESIDENCE == enable) [self.modelList addObject:[[DocModel alloc] initWithKBNModel:idDoc.CARD_RESIDENCE]];
    
    if (configDB.IDENTIFICATION_DOCUMENT_SPECIAL_PERMANENT_RESIDENT_CERTIFICATE == enable) [self.modelList addObject:[[DocModel alloc] initWithKBNModel:idDoc.CARD_SPECIALIP]];
    
    [self.docTable reloadData];
}

// 画面初期化
- (void)initSubView{
    [self.navigationItem setHidesBackButton:YES];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.positionY, SCREEN_WIDTH, SCREEN_HEIGHT - self.positionY - kFooterHeight) style:UITableViewStylePlain];
    [tableView registerClass:[SelectNecessaryDocTableViewCell class] forCellReuseIdentifier:@"reuseIdentifier"];
    tableView.bounces = NO;
    tableView.tableFooterView = [[UIView alloc] init];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.docTable = tableView;
}

// 「次へ」ボタンをタップ時、イベント処理を実施する。
- (void)didFooterButtonClicked {
    [super didFooterButtonClicked];
    
    // 共通領域初期化
    SystemCode *sysCode = [Utils getSystemCode];
    KBNModel *camera = sysCode.read_method_KBN.CAMERA;
    KBNModel *nfc = sysCode.read_method_KBN.NFC;
    int unenable = sysCode.enable_KBN.UNENFORCE.code;
    
    // 本人確認内容データへ本人確認書類区分を設定する
    db.identificationData.DOC_TYPE = self.currentModel.kbnModel.code;
    
    // 本人確認内容データへ読取方法を設定する
    if (db.configFileData.NFC_ENABLE == unenable) {
        
        // NFC読込みを実施しないの場合、「1:カメラ撮影」を設定する。
        db.identificationData.GAIN_TYPE = camera.code;
    }
    if (db.configFileData.CAMERA_ENABLE == unenable) {
        
        // カメラ撮影を実施しないの場合、「2:NFC読取」を設定する。
        db.identificationData.GAIN_TYPE = nfc.code;
    }
    
    UIViewController *nextController;
    if (db.identificationData.GAIN_TYPE == camera.code) {
        
        // カメラ撮影の場合、「G0040-01： 本人確認書類撮影開始前画面」へ遷移する。
        StartShootingNecessaryDocView *view = [[StartShootingNecessaryDocView alloc] initWithModel:self.currentModel andController:self];
        [view show];
    } else if (db.identificationData.GAIN_TYPE == nfc.code) {
        
        // NFC読取の場合、「G0070-01：暗証番号入力画面」へ遷移する
        InputPasswordViewController *vc = [[InputPasswordViewController alloc] init];
        vc.currentModel = self.currentModel;
        nextController = vc;
    } else {
        
        // 未設定の場合、「G0030-01：読取方法選択画面」へ遷移する。
        SelectReadMethodView *v = [SelectReadMethodView new];
        UIButton *cameraButton = [v getCameraScanButtonWithKBNModel:camera];
        UIButton *NFCButton = [v getNFCButtonWithKBNModel:nfc];
        
        SelectReadMethodViewController *s = [[SelectReadMethodViewController alloc] init];
        s.currentModel = self.currentModel;
        s.cameraScanButton = cameraButton;
        s.NFCBUtton = NFCButton;
        nextController = s;
    }
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc] init];
    back.title = @"";
    self.navigationItem.backBarButtonItem = back;
    [self.navigationController pushViewController:nextController animated:YES];
    
    int tmpDoc = db.identificationData.DOC_TYPE;
    int tmpRead = db.identificationData.GAIN_TYPE;
    db.identificationData = [IDENTIFICATION_DATA new];
    db.identificationData.DOC_TYPE = tmpDoc;
    db.identificationData.GAIN_TYPE = tmpRead;
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SelectNecessaryDocTableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    if(!cell){
        cell=[[SelectNecessaryDocTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseIdentifier"];
    }
    cell.model = [self.modelList objectAtIndex:indexPath.row];
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (kPaddingHeightSmall * 2) + kButtonHeightMedium;
}

#pragma mark - firstTableViewCellDelegate
- (void)didSelectItem:(DocModel *)model{
    self.currentModel = model;
    
    // 「次へ」ボタンを活性化させる。
    self.buttonInteractionEnabled = YES;
    [self.docTable reloadData];
}

@end
