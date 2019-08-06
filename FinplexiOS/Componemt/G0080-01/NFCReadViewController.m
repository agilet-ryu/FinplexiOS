//
//  NFCReadViewController.m
//  FinplexiOS
//
//  Created by agilet-ryu on 2019/8/5.
//  Copyright © 2019 Fujitsu. All rights reserved.
//

#import "NFCReadViewController.h"
#import "NFCReadResultViewController.h"

@interface NFCReadViewController ()

@end

@implementation NFCReadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewID = @"G0080-01";
    [self initView];
}

- (void)viewDidAppear:(BOOL)animated{
    [self performSelector:@selector(goNextView) withObject:nil afterDelay:3.0f];
}

- (void)initView {
    self.buttonHidden = YES;
    
    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pic9"]];
    [img setFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 200) * 0.5, 250, 200, 200)];
    [self.view addSubview:img];
    
    UIButton *footBT = [UIButton buttonWithType:UIButtonTypeCustom];
    footBT.backgroundColor = [UIColor whiteColor];
    [footBT setFrame:CGRectMake(16, [UIScreen mainScreen].bounds.size.height - 68, [UIScreen mainScreen].bounds.size.width - 32, 54)];
    [footBT setTitle:@"キャンセル" forState:UIControlStateNormal];
    [footBT addTarget:self action:@selector(doCancel) forControlEvents:UIControlEventTouchUpInside];
    [footBT setTitleColor:kBaseColor forState:UIControlStateNormal];
    footBT.layer.borderWidth = [UITool shareUITool].lineWidth;
    footBT.layer.borderColor = kBaseColor.CGColor;
    footBT.layer.cornerRadius = 6.0f;
    //    footBT.layer.shadowOpacity = 0.15f;
    //    footBT.layer.shadowOffset = CGSizeMake(6, 6);
    footBT.layer.masksToBounds = NO;
    [self.view addSubview:footBT];
}
- (void)doCancel{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)goNextView{
    NFCReadResultViewController *ic = [[NFCReadResultViewController alloc] init];
    ic.currentModel = self.currentModel;
    [self.navigationController pushViewController:ic animated:YES];
}

@end
