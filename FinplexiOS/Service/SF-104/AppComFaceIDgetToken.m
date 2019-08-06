//
//  AppComFaceIDgetToken.m
//  demoApp
//
//  Created by agilet-ryu on 2019/8/1.
//  Copyright © 2019 fujitsu. All rights reserved.
//

#import "AppComFaceIDgetToken.h"
#import "AppComServerComm.h"
#import "InfoDatabase.h"

@interface AppComFaceIDgetToken()<AppComServerCommDelegate>
@property (nonatomic, strong) UIViewController *controller;
@property (nonatomic, copy) getFaceIDBizTokenResult result;
@end

@implementation AppComFaceIDgetToken

static AppComFaceIDgetToken *manager = nil;
static InfoDatabase *db = nil;

/**
 「顔照合認証要求(App-GetBizToken)」のREST APIを利用しリクエスト発行。
 */
+ (instancetype)sendGetFaceIDTokenRequestWithController:(UIViewController *)controller andCallback:(getFaceIDBizTokenResult)result{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AppComFaceIDgetToken alloc] init];
        db = [InfoDatabase shareInfoDatabase];
    });
    [manager sendGetFaceIDTokenRequest];
    manager.controller = controller;
    manager.result = result;
    return manager;
}

/**
 「顔照合認証要求(App-GetBizToken)」のREST APIを利用しリクエスト発行。
 */
- (void)sendGetFaceIDTokenRequest{
    FormData *data = [FormData initWithFileData:UIImageJPEGRepresentation(db.identificationData.OBVERSE_IMG, 1.0f)
                                       fileName:@"head"
                                           name:@"image_ref1"
                                       mimeType:@"image/jpeg"];
    
    AppComServerComm *commm = [AppComServerComm initService];
    commm.urlPath = kURLGetFaceIDToken;
    commm.delegate = self;
    commm.param = @{@"sign" : db.identificationData.FACEID_SIGNATURE,
                    @"sign_version" : @"hmac_sha1",
                    @"comparison_type" : @"0" ,
                    @"liveness_type" : @"meglive",
                    @"uuid" : @"1"};
    commm.contentType = contentTypeMultipart;
    commm.formDataArray = @[data];
    
    [commm sendRequest];
}

#pragma mark - AppComServerCommDelegate

// 通信成功時
- (void)appComServerCommSuccessWithResponseObject:(id)responseObject{
    NSDictionary *responseDic = [NSDictionary dictionaryWithDictionary:responseObject];
    if ([[responseDic allKeys] containsObject:@"error"]) {
        
        // エラーコード（error）が設定されている場合
        self.result(@"0");
    }else{
        
        // エラーコード（error）が設定されていない場合
        
        // 顔照合認証応答(App-GetBizToken)から取得したレスポンス内容を共通領域定義.本人確認内容データに設定する。
        db.identificationData.REQUEST_ID = responseObject[@"request_id"];
        db.identificationData.BIZ_TOKEN = responseObject[@"biz_token"];
        
        // 「処理結果」に1を設定し返却する。
        self.result(@"1");
    }
}

// 通信失敗時
- (void)appComServerCommFailure:(id)errorObject{
    self.result(@"0");
    [self dealWithError:errorObject[@"error"]];
}

- (void)dealWithError:(NSString *)error{
    NSString *code = [NSString string];
    NSString *msg = [NSString string];
    if ([error containsString:@"MISSING_ARGUMENTS"]) {
        code = @"EC00-003";
        msg = @"CM-001-99E";
    }else if ([error containsString:@"BAD_ARGUMENTS"]){
        code = @"EC00-003";
        msg = @"CM-001-99E";
    }else if ([error containsString:@"IMAGE_ERROR_UNSUPPORTED_FORMAT"]){
        msg = @"CM-001-07E";
    }else if ([error containsString:@"NO_FACE_FOUND"]){
        msg = @"CM-001-07E";
    }else if ([error containsString:@"INVALID_IMAGE_SIZE"]){
        msg = @"CM-001-07E";
    }else if ([error containsString:@"LOW_QUALITY"]){
        msg = @"CM-001-07E";
    }else if ([error containsString:@"MULTIPLE_FACES"]){
        msg = @"CM-001-07E";
    }else if ([error containsString:@"AUTHENTICATION_ERROR"]){
        msg = @"CM-001-99E";
        code = @"EC00-003";
    }else if ([error containsString:@"AUTHORIZATION_ERROR:"]){
        msg = @"CM-001-99E";
        code = @"EC00-004";
    }else if ([error containsString:@"CONCURRENCY_LIMIT_EXCEEDED"]){
        msg = @"CM-001-07E";
    }else if ([error containsString:@"API_NOT_FOUND"]){
        msg = @"CM-001-99E";
        code = @"EC00-004";
    }else if ([error containsString:@"Request Entity Too Large"]){
        msg = @"CM-001-99E";
        code = @"EC00-003";
    }else{
        msg = @"CM-001-07E";
    }
    
    ErrorManager *errorManager = [ErrorManager shareErrorManager];
    code.length ? [errorManager dealWithErrorCode:code msg:msg andController:self.controller] : [errorManager showWithErrorCode:msg atCurrentController:self.controller managerType:errorManagerTypeAlertClose addFirstMsg:@"再撮影" addSecondMsg:@""];
}
@end
