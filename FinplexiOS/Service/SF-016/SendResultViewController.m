//
//  SendResultViewController.m
//  FinplexiOS
//
//  Created by agilet-ryu on 2019/8/4.
//  Copyright © 2019 Fujitsu. All rights reserved.
//

#import "SendResultViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "AppComServerComm.h"

@interface SendResultViewController ()<CLLocationManagerDelegate, AppComServerCommDelegate, ErrorManagerDelegate>

@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
@property (nonatomic, strong) CLLocationManager *locationmanager;
@property (nonatomic, strong) NSString *paramStr;
@end

@implementation SendResultViewController
static InfoDatabase *db = nil;
static ErrorManager *error = nil;
- (void)viewDidLoad {
    [super viewDidLoad];
    db = [InfoDatabase shareInfoDatabase];
    error = [ErrorManager shareErrorManager];
    self.viewID = @"G0050-01";
    [self initView];
}
- (void)initView {
    UIActivityIndicatorView *v = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    v.frame= CGRectMake(([UIScreen mainScreen].bounds.size.width - 200) * 0.5, ([UIScreen mainScreen].bounds.size.height - 200) * 0.5, 200, 200);
    v.color = [UIColor lightGrayColor];
    [self.view addSubview:v];
    [v startAnimating];
    self.indicatorView = v;
    [self performSelector:@selector(delayMethod) withObject:nil afterDelay:5.0];
    
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height * 0.5 + 125, [UIScreen mainScreen].bounds.size.width, 30)];
    l.text = @"処理結果送信中・・・";
    l.textColor = kBodyTextColor;
    l.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:l];
}

- (void)checkFlag{
    if (db.startParam.GEOLOCATION_FLG == saveTypeNOTSaveInDB) {
        
        //共通領域.起動パラメータ.管理要否フラグ（位置情報）が「1：保持する」の場合
        if ([CLLocationManager locationServicesEnabled]) {
            
            // 端末の位置情報を取得
            CLLocationManager *locationmanager = [[CLLocationManager alloc]init];
            locationmanager.delegate = self;
            [locationmanager requestAlwaysAuthorization];
            [locationmanager requestWhenInUseAuthorization];
            locationmanager.desiredAccuracy = kCLLocationAccuracyBest;
            locationmanager.distanceFilter = 5.0;
            [locationmanager startUpdatingLocation];
        }
    }else{
        if (db.configFileData.IMG_MASK == 1) {
            
            // 共通領域.起動パラメータ.本人確認書類画像マスクフラグが「1：本人確認画像の機微情報をマスクする」の場合
#warning TODO マスク処理を行う。
            // マスク処理を行う。
            
        }
        
        // データ格納要求のリクエストを作成する。
        [self getParam];
    }
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    // データ格納要求のリクエストを作成する。
    [self getParam];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    [self.locationmanager stopUpdatingHeading];
    CLLocation *currentLocation = [locations lastObject];
    NSString *latitude = [NSString stringWithFormat:@"%f", currentLocation.coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f", currentLocation.coordinate.longitude];
    
    // 共通領域.本人確認内容データ.位置情報（緯度）、共通領域.本人確認内容データ.位置情報（緯度）へ設定する。
    db.identificationData.LATITUDE = latitude;
    db.identificationData.LONGITUDE = longitude;
    
    // データ格納要求のリクエストを作成する。
    [self getParam];
}

// データ格納要求のリクエストを作成する。
- (void)getParam{
    
    // 共通領域初期化
    IDENTIFICATION_DATA *iData = db.identificationData;
    CONFIG_FILE_DATA *configData = db.configFileData;
    Config *startParam = db.startParam;
    NSDictionary *dic = @{@"callID": iData.CALL_ID,
                          @"process_id": iData.BIZ_TOKEN,
                          @"business_id": configData.MAIN_ACCOUNT,
                          @"identification_document": [NSString stringWithFormat:@"%d", iData.DOC_TYPE],
                          @"read_method": [NSString stringWithFormat:@"%d", iData.GAIN_TYPE],
                          @"result": iData.RESULT,
                          @"score": iData.SCORE,
                          @"far": iData.FAR,
                          @"frr": iData.FRR,
                          @"photo_img": @"1",
                          @"camera_img": @"1",
                          @"obverse_img": @"1",
                          @"reverse_img": @"1",
                          @"name": startParam.NAME_FLG ? iData.NAME : @"",
                          @"kana": startParam.KANA_FLG ? iData.KANA : @"",
                          @"address": startParam.ADDRESS_FLG ? iData.ADDRESS : @"",
                          @"birth": startParam.BIRTH_FLG ? iData.BIRTH : @"",
                          @"number": startParam.NUMBER_FLG ? iData.NUMBER : @"",
                          @"permanent_address": startParam.PERMANENT_ADDRESS_FLG ? iData.PERMANENT_ADDRESS : @"",
                          @"type": startParam.TYPE_FLG ? iData.TYPE : @"",
                          @"band_color": startParam.BAND_COLOR_FLG ? iData.BAND_COLOR : @"",
                          @"gender": startParam.SEX_FLG ? iData.GENDER : @"",
                          @"expiration": startParam.EXPIRATION_FLG ? iData.EXPIRATION : @"",
                          @"issuance_date": startParam.ISSUANCE_DATE_FLG ? iData.ISSUANCE_DATE : @"",
                          @"type_num": startParam.TYPE_FLG ? iData.TYPE_NUM : @"",
                          @"condition_1": startParam.CONDITION_FLG ? iData.CONDITION_1 : @"",
                          @"condition_2": startParam.CONDITION_FLG ? iData.CONDITION_2 : @"",
                          @"condition_3": startParam.CONDITION_FLG ? iData.CONDITION_3 : @"",
                          @"condition_4": startParam.CONDITION_FLG ? iData.CONDITION_4 : @"",
                          @"date_nikogen": startParam.DATE_NIKOGEN_FLG ? iData.DATE_NIKOGEN : @"",
                          @"date_other": startParam.DATE_OTHER_FLG ? iData.DATE_OTHER : @"",
                          @"date_second": startParam.DATE_SECOND_FLG ? iData.DATE_SECOND : @"",
                          @"commission": startParam.COMMISSION_FLG ? iData.COMMISSION : @"",
                          @"common_name": startParam.OTHER_FLG ? iData.COMMON_NAME : @"",
                          @"unify_name": startParam.OTHER_FLG ? iData.UNIFY_NAME : @"",
                          @"reference_number": startParam.OTHER_FLG ? iData.REFERENCE_NUMBER : @"",
                          @"date_ogata": startParam.OTHER_FLG ? iData.DATE_OGATA : @"",
                          @"date_futsu": startParam.OTHER_FLG ? iData.DATE_FUTSU : @"",
                          @"date_otoku": startParam.OTHER_FLG ? iData.DATE_OTOKU : @"",
                          @"date_daijini": startParam.OTHER_FLG ? iData.DATE_DAIJINI : @"",
                          @"date_fujini": startParam.OTHER_FLG ? iData.DATE_FUJINI : @"",
                          @"date_kotoku": startParam.OTHER_FLG ? iData.DATE_KOTOKU : @"",
                          @"date_gen": startParam.OTHER_FLG ? iData.DATE_GEN : @"",
                          @"date_kein": startParam.OTHER_FLG ? iData.DATE_KEIN : @"",
                          @"date_daini": startParam.OTHER_FLG ? iData.DATE_DAINI : @"",
                          @"date_funi": startParam.OTHER_FLG ? iData.DATE_FUNI : @"",
                          @"date_daitokuni": startParam.OTHER_FLG ? iData.DATE_DAITOKUNI : @"",
                          @"date_keinni": startParam.OTHER_FLG ? iData.DATE_KEINNI : @"",
                          @"date_chugata": startParam.OTHER_FLG ? iData.DATE_CHUGATA : @"",
                          @"date_chuni": startParam.OTHER_FLG ? iData.DATE_CHUNI : @"",
                          @"date_junchugata": startParam.OTHER_FLG ? iData.DATE_JUNCHUGATA : @"",
                          @"jis_x_0208_num": startParam.OTHER_FLG ? iData.JIS_X_0208_NUM : @"",
                          @"new_commission_1": startParam.OTHER_FLG ? iData.NEW_COMMISSION_1 : @"",
                          @"new_commission_2": startParam.OTHER_FLG ? iData.NEW_COMMISSION_2 : @"",
                          @"new_commission_3": startParam.OTHER_FLG ? iData.NEW_COMMISSION_3 : @"",
                          @"new_commission_4": startParam.OTHER_FLG ? iData.NEW_COMMISSION_4 : @"",
                          @"new_commission_5": startParam.OTHER_FLG ? iData.NEW_COMMISSION_5 : @"",
                          @"new_commission_6": startParam.OTHER_FLG ? iData.NEW_COMMISSION_6 : @"",
                          @"new_commission_7": startParam.OTHER_FLG ? iData.NEW_COMMISSION_7 : @"",
                          @"new_commission_8": startParam.OTHER_FLG ? iData.NEW_COMMISSION_8 : @"",
                          @"new_commission_9": startParam.OTHER_FLG ? iData.NEW_COMMISSION_9 : @"",
                          @"new_commission_10": startParam.OTHER_FLG ? iData.NEW_COMMISSION_10 : @"",
                          @"new_commission_11": startParam.OTHER_FLG ? iData.NEW_COMMISSION_11 : @"",
                          @"new_commission_12": startParam.OTHER_FLG ? iData.NEW_COMMISSION_12 : @"",
                          @"new_commission_13": startParam.OTHER_FLG ? iData.NEW_COMMISSION_13 : @"",
                          @"new_commission_14": startParam.OTHER_FLG ? iData.NEW_COMMISSION_14 : @"",
                          @"new_commission_15": startParam.OTHER_FLG ? iData.NEW_COMMISSION_15 : @"",
                          @"new_name_1": startParam.OTHER_FLG ? iData.NEW_NAME_1 : @"",
                          @"new_name_2": startParam.OTHER_FLG ? iData.NEW_NAME_2 : @"",
                          @"new_name_3": startParam.OTHER_FLG ? iData.NEW_NAME_3 : @"",
                          @"new_name_4": startParam.OTHER_FLG ? iData.NEW_NAME_4 : @"",
                          @"new_name_5": startParam.OTHER_FLG ? iData.NEW_NAME_5 : @"",
                          @"new_name_6": startParam.OTHER_FLG ? iData.NEW_NAME_6 : @"",
                          @"new_name_7": startParam.OTHER_FLG ? iData.NEW_NAME_7 : @"",
                          @"new_name_8": startParam.OTHER_FLG ? iData.NEW_NAME_8 : @"",
                          @"new_kana_1": startParam.OTHER_FLG ? iData.NEW_KANA_1 : @"",
                          @"new_kana_2": startParam.OTHER_FLG ? iData.NEW_KANA_2 : @"",
                          @"new_kana_3": startParam.OTHER_FLG ? iData.NEW_KANA_3 : @"",
                          @"new_kana_4": startParam.OTHER_FLG ? iData.NEW_KANA_4 : @"",
                          @"new_kana_5": startParam.OTHER_FLG ? iData.NEW_KANA_5 : @"",
                          @"new_kana_6": startParam.OTHER_FLG ? iData.NEW_KANA_6 : @"",
                          @"new_kana_7": startParam.OTHER_FLG ? iData.NEW_KANA_7 : @"",
                          @"new_kana_8": startParam.OTHER_FLG ? iData.NEW_KANA_8 : @"",
                          @"new_address_1": startParam.OTHER_FLG ? iData.NEW_ADDRESS_1 : @"",
                          @"new_address_2": startParam.OTHER_FLG ? iData.NEW_ADDRESS_2 : @"",
                          @"new_address_3": startParam.OTHER_FLG ? iData.NEW_ADDRESS_3 : @"",
                          @"new_address_4": startParam.OTHER_FLG ? iData.NEW_ADDRESS_4 : @"",
                          @"new_address_5": startParam.OTHER_FLG ? iData.NEW_ADDRESS_5 : @"",
                          @"new_address_6": startParam.OTHER_FLG ? iData.NEW_ADDRESS_6 : @"",
                          @"new_address_7": startParam.OTHER_FLG ? iData.NEW_ADDRESS_7 : @"",
                          @"new_address_8": startParam.OTHER_FLG ? iData.NEW_ADDRESS_8 : @"",
                          @"new_condition_1": startParam.OTHER_FLG ? iData.NEW_CONDITION_1 : @"",
                          @"new_condition_2": startParam.OTHER_FLG ? iData.NEW_CONDITION_2 : @"",
                          @"new_condition_3": startParam.OTHER_FLG ? iData.NEW_CONDITION_3 : @"",
                          @"new_condition_4": startParam.OTHER_FLG ? iData.NEW_CONDITION_4 : @"",
                          @"new_condition_5": startParam.OTHER_FLG ? iData.NEW_CONDITION_5 : @"",
                          @"new_condition_6": startParam.OTHER_FLG ? iData.NEW_CONDITION_6 : @"",
                          @"new_condition_7": startParam.OTHER_FLG ? iData.NEW_CONDITION_7 : @"",
                          @"new_condition_8": startParam.OTHER_FLG ? iData.NEW_CONDITION_8 : @"",
                          @"condition_cancel_1": startParam.OTHER_FLG ? iData.CONDITION_CANCEL_1 : @"",
                          @"condition_cancel_2": startParam.OTHER_FLG ? iData.CONDITION_CANCEL_2 : @"",
                          @"condition_cancel_3": startParam.OTHER_FLG ? iData.CONDITION_CANCEL_3 : @"",
                          @"condition_cancel_4": startParam.OTHER_FLG ? iData.CONDITION_CANCEL_4 : @"",
                          @"condition_cancel_5": startParam.OTHER_FLG ? iData.CONDITION_CANCEL_5 : @"",
                          @"condition_cancel_6": startParam.OTHER_FLG ? iData.CONDITION_CANCEL_6 : @"",
                          @"condition_cancel_7": startParam.OTHER_FLG ? iData.CONDITION_CANCEL_7 : @"",
                          @"condition_cancel_8": startParam.OTHER_FLG ? iData.CONDITION_CANCEL_8 : @"",
                          @"remarks_1": startParam.OTHER_FLG ? iData.REMARKS_1 : @"",
                          @"remarks_2": startParam.OTHER_FLG ? iData.REMARKS_2 : @"",
                          @"remarks_3": startParam.OTHER_FLG ? iData.REMARKS_3 : @"",
                          @"remarks_4": startParam.OTHER_FLG ? iData.REMARKS_4 : @"",
                          @"remarks_5": startParam.OTHER_FLG ? iData.REMARKS_5 : @"",
                          @"remarks_6": startParam.OTHER_FLG ? iData.REMARKS_6 : @"",
                          @"remarks_7": startParam.OTHER_FLG ? iData.REMARKS_7 : @"",
                          @"remarks_8": startParam.OTHER_FLG ? iData.REMARKS_8 : @"",
                          @"reserve_1": startParam.OTHER_FLG ? iData.RESERVE_1 : @"",
                          @"reserve_2": startParam.OTHER_FLG ? iData.RESERVE_2 : @"",
                          @"reserve_3": startParam.OTHER_FLG ? iData.RESERVE_3 : @"",
                          @"reserve_4": startParam.OTHER_FLG ? iData.RESERVE_4 : @"",
                          @"reserve_5": startParam.OTHER_FLG ? iData.RESERVE_5 : @"",
                          @"reserve_6": startParam.OTHER_FLG ? iData.RESERVE_6 : @"",
                          @"reserve_7": startParam.OTHER_FLG ? iData.RESERVE_7 : @"",
                          @"reserve_8": startParam.OTHER_FLG ? iData.RESERVE_8 : @"",
                          @"new_permanent_address_1": startParam.OTHER_FLG ? iData.NEW_PERMANENT_ADDRESS_1 : @"",
                          @"new_permanent_address_2": startParam.OTHER_FLG ? iData.NEW_PERMANENT_ADDRESS_2 : @"",
                          @"new_permanent_address_3": startParam.OTHER_FLG ? iData.NEW_PERMANENT_ADDRESS_3 : @"",
                          @"new_permanent_address_4": startParam.OTHER_FLG ? iData.NEW_PERMANENT_ADDRESS_4 : @"",
                          @"new_permanent_address_5": startParam.OTHER_FLG ? iData.NEW_PERMANENT_ADDRESS_5 : @"",
                          @"serial_num": startParam.OTHER_FLG ? iData.SERIAL_NUM : @"",
                          @"issuer": startParam.OTHER_FLG ? iData.ISSUER : @"",
                          @"main_person": startParam.OTHER_FLG ? iData.MAIN_PERSON : @"",
                          @"main_person_id": startParam.OTHER_FLG ? iData.MAIN_PERSON_ID : @"",
                          @"latitude": startParam.GEOLOCATION_FLG ? iData.LATITUDE : @"",
                          @"longitude": startParam.GEOLOCATION_FLG ? iData.LONGITUDE : @"",
                          @"error_code": iData.ERROR_CODE,
#warning TODO 位置情报是四个参数
                          @"photo_position": iData.PHOTO_POSITION,
                          
                          @"thickness_video": @"1",
                          @"faceid_signature": iData.FACEID_SIGNATURE,
                          @"log_id": @"",
                          @"expiration_date": iData.EXPIRATION_DATE,
                          @"biz_token": iData.BIZ_TOKEN,
                          @"request_id": iData.REQUEST_ID,
                          @"gw_api_token": configData.GW_API_KEY,
                          @"log_output": [NSString stringWithFormat:@"%d", iData.LOG_OUTPUT],
                          @"ocr_request": [NSString stringWithFormat:@"%d", iData.OCR_REQUEST],
                          @"uuid": startParam.UUID,
                          @"biz_no": startParam.BIZ_NO
                          };
#warning TODO 参数不全 free项目
    NSString *jsonStr = [Utils convertToJsonData:dic];
    
    // リクエスト内に設定するデータを暗号化する
    self.paramStr = [Utils aes_encryptWithString:jsonStr];
    
    // 作成したリクエストをオンライン本人確認サーバへ送信する。
    [self sendRequest];
}

- (void)sendRequest{
    AppComServerComm *comm = [AppComServerComm initService];
    comm.delegate = self;
    comm.urlPath = [NSString stringWithFormat:@"%@%@", kURLSendUserInformation, self.paramStr];
    FormData *img1 = [FormData initWithFileData:UIImageJPEGRepresentation(db.identificationData.OBVERSE_IMG, 1.0f) fileName:@"imgFile1" name:@"imgFile1" mimeType:@"image/jpeg"];
    FormData *img2 = [FormData initWithFileData:UIImageJPEGRepresentation(db.identificationData.PHOTO_IMG, 1.0f) fileName:@"imgFile2" name:@"imgFile2" mimeType:@"image/jpeg"];
#warning TODO 视频数据获取
    FormData *video = [FormData initWithFileData:[NSData new] fileName:@"videoFile" name:@"videoFile" mimeType:@"video/mp4"];
    comm.formDataArray = @[img1, img2, video];
    comm.contentType = contentTypeMultipart;
    [comm sendRequest];
}

#pragma mark - AppComServerCommDelegate

// 通信成功時
- (void)appComServerCommSuccessWithResponseObject:(id)responseObject{
    if ([responseObject[@"resultCode"] isEqualToString:@"1"]) {
        
        // データ格納応答の「処理結果」が「1：失敗」の場合
        // ポップアップにて「メッセージコード：CM-001-03E（%1:処理結果送信）」を表示する。
        [error showWithErrorCode:@"CM-001-03E" atCurrentController:self managerType:errorManagerTypeCustom buttonTitle:@"再試行" addFirstMsg:@"処理結果送信" addSecondMsg:@"" andTag:2000];
    }else{
        
        //  データ格納応答の「処理結果」が「0：成功」の場合
#warning TODO
        // 「SF-102：操作ログサーバ送信」機能を呼び出す。
        // 「SF-017：処理終了」機能を呼び出す。
    }
}

// 通信失敗時
- (void)appComServerCommFailure:(id)errorObject{
    
    // 　ポップアップにて「メッセージコード：CM-001-02E」を表示する。
    ErrorManager *error = [ErrorManager shareErrorManager];
    error.delegate = self;
    [error showWithErrorCode:@"CM-001-02E" atCurrentController:self managerType:errorManagerTypeCustom buttonTitle:@"再試行" andTag:1000];
}

// 再試行ボタンタップ時
- (void)buttonDidClickedWithTag:(NSInteger)tag{
    
    // データ格納要求再送信
    [self sendRequest];
}


@end
