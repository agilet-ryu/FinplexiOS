//
//  ViewConfig.m
//  demoApp
//
//  Created by agilet-ryu on 2019/8/3.
//  Copyright © 2019 fujitsu. All rights reserved.
//

#import "ViewConfig.h"

@implementation ViewConfig

- (NSDictionary *)viewDictionary{
    if (!_viewDictionary) {
        _viewDictionary = @{
                            @"G0010-01" : [ViewModel initViewModelWithViewID:@"G0010-01" viewName:@"スプラッシュ画面" viewTitle:@"" viewFirstDetail:@"" viewSecondDetail:@"" viewProgress:0],
                            @"G0020-01" : [ViewModel initViewModelWithViewID:@"G0020-01" viewName:@"本人確認書類選択画面" viewTitle:@"本人確認書類の選択" viewFirstDetail:@"使用する本人確認書類を選択してください。" viewSecondDetail:@"" viewProgress:0.1],
                            @"G0030-01" : [ViewModel initViewModelWithViewID:@"G0030-01" viewName:@"読取方法選択画面" viewTitle:@"読み取り方法の選択" viewFirstDetail:@"の読み取り方法を選択してください。" viewSecondDetail:@"" viewProgress:0.2],
                            @"G0040-01" : [ViewModel initViewModelWithViewID:@"G0040-01" viewName:@"本人確認書類撮影開始前画面" viewTitle:@"" viewFirstDetail:@"を撮影します。\nよろしいですか？" viewSecondDetail:@"" viewProgress:0],
                            @"G0060-01" : [ViewModel initViewModelWithViewID:@"G0060-01" viewName:@"本人確認書類撮影結果画面" viewTitle:@"撮影結果の確認" viewFirstDetail:@"撮影画像をご確認いただき、不鮮明な場合や上下反転している場合は再撮影してください。問題がなければ、確認チェックボックスにチェックを入れてください。" viewSecondDetail:@"書類撮影の結果、書類の切り出し範囲が適切でないため、再撮影してください。" viewProgress:0.5],
                            @"G0070-01" : [ViewModel initViewModelWithViewID:@"G0070-01" viewName:@"暗証番号入力画面" viewTitle:@"暗証番号の入力" viewFirstDetail:@"ICチップから情報を取得します。\n読み取り用の暗証番号(※)を入力してください。\n暗証番号に関する説明を記載" viewSecondDetail:@"" viewProgress:0.3],
                            @"G0090-01" : [ViewModel initViewModelWithViewID:@"G0090-01" viewName:@"NFC読取結果画面" viewTitle:@"読み取り結果の確認" viewFirstDetail:@"" viewSecondDetail:@"" viewProgress:0.6],
                            @"G0100-01" : [ViewModel initViewModelWithViewID:@"G0100-01" viewName:@"自然人検知開始前画面" viewTitle:@"顔画像の撮影開始" viewFirstDetail:@"スマートフォンのカメラで、顔画像を撮影します。\n背景に他人が写り込んでいない状況で撮影してください。" viewSecondDetail:@"" viewProgress:0.7],
                            @"G0120-01" : [ViewModel initViewModelWithViewID:@"G0120-01" viewName:@"顔照合画面" viewTitle:@"顔照合" viewFirstDetail:@"顔照合中・・・・" viewSecondDetail:@"" viewProgress:0.8],
                            @"G0130-01" : [ViewModel initViewModelWithViewID:@"G0130-01" viewName:@"厚み撮影開始前画面" viewTitle:@"厚みの撮影開始" viewFirstDetail:@"スマートフォンのカメラで、本人確認書類の厚みを撮影します。" viewSecondDetail:@"" viewProgress:0],
                            @"G0160-01" : [ViewModel initViewModelWithViewID:@"G0160-01" viewName:@"OCR読取結果画面" viewTitle:@"読み取り結果の確認" viewFirstDetail:@"撮影画像から情報を読み取りました。\n読み取り結果が正しいことを確認してください。" viewSecondDetail:@"" viewProgress:0.6],
                            @"G0050-01" : [ViewModel initViewModelWithViewID:@"G0050-01" viewName:@"処理結果送信画面" viewTitle:@"処理結果送信" viewFirstDetail:@"処理結果送信中・・・" viewSecondDetail:@"" viewProgress:0]
                            };
    }
    return _viewDictionary;
}

@end

@implementation ViewModel

+ (instancetype)initViewModelWithViewID:(NSString *)viewID viewName:(NSString *)viewName viewTitle:(NSString *)viewTitle viewFirstDetail:(NSString *)viewFirstDetail viewSecondDetail:(NSString *)viewSecondDetail viewProgress:(float)viewProgress{
    ViewModel *model = [[ViewModel alloc] init];
    model.viewID = viewID;
    model.viewName = viewName;
    model.viewTitle = viewTitle;
    model.viewFirstDetail = viewFirstDetail;
    model.viewSecondDetail = viewSecondDetail;
    model.viewProgress = viewProgress;
    return model;
}

@end
