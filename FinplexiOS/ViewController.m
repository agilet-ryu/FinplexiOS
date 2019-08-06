//
//  ViewController.m
//  FinplexiOS
//
//  Created by agilet-ryu on 2019/8/4.
//  Copyright © 2019 Fujitsu. All rights reserved.
//

#import "ViewController.h"
#import "Service/Common/Utils.h"
#import "Service/SF-104/AppComFaceIDgetToken.h"
#import "initManager.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    Config *c = [Config new];
    c.API_SECRET = @"asdasd";
    c.UUID = @"sadasd";
    c.THREHOLDS_LEVEL = FARTypeLevelOne;
    c.IMAGE_TYPE = ImageTypeJPEG;
    [initManager startFinplexWithConfig:c Controller:self callback:^(ResultModel * _Nonnull resultModel) {
        NSLog(@"%@ _+_+ %@", resultModel.SDK_RESULT, resultModel.ERROR_CODE);
    }];
}



@end
