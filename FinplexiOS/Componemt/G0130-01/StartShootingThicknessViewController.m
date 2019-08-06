//
//  StartShootingThicknessViewController.m
//  FinplexiOS
//
//  Created by agilet-ryu on 2019/8/4.
//  Copyright © 2019 Fujitsu. All rights reserved.
//

#import "StartShootingThicknessViewController.h"
#import <WebKit/WebKit.h>

@interface StartShootingThicknessViewController ()

@end

@implementation StartShootingThicknessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewID = @"G0130-01";
    [self initView];
}


- (void)initView{
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0,200,SCREEN_WIDTH,250)];
    [self.view addSubview:webView];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"verify" ofType:@"gif"];
    NSURL *url = [NSURL fileURLWithPath:path];
    [webView loadFileURL:url allowingReadAccessToURL:url];
    self.automaticallyAdjustsScrollViewInsets=NO;
    webView.userInteractionEnabled = NO;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
