//
//  BaseViewController.m
//  demoApp
//
//  Created by agilet-ryu on 2019/8/3.
//  Copyright © 2019 fujitsu. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@property (nonatomic, strong) UIButton *footerButton;
@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation BaseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView {
    self.view.backgroundColor = kBodyColor;
    
    // 戻るボタン
    UIBarButtonItem *back = [[UIBarButtonItem alloc] init];
    back.title = @"";
    self.navigationItem.backBarButtonItem = back;
    self.navigationController.navigationBar.tintColor = [UIColor clearColor];
    
    // 閉じるボタン
    UIBarButtonItem *close = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(closeSDK)];
    self.navigationItem.rightBarButtonItem = close;
    
    // 次へボタン
    UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
    [b setFrame:CGRectMake(kPaddingwidthMedium, SCREEN_HEIGHT - kPaddingHeightMedium - kButtonHeightLarge, SCREEN_WIDTH - (kPaddingwidthMedium * 2), kButtonHeightLarge)];
    [b setTitle:@"次へ" forState:UIControlStateNormal];
    b.titleLabel.font = kFontSizeMedium;
    [b addTarget:self action:@selector(didFooterButtonClicked) forControlEvents:UIControlEventTouchDown];
    b.layer.cornerRadius = kButtonRadiusLarge;
    //    footBT.layer.shadowOpacity = 0.15f;
    //    footBT.layer.shadowOffset = CGSizeMake(6, 6);
    b.layer.masksToBounds = NO;
    [self.view addSubview:b];
    self.footerButton = b;

    UILabel *l = [[UILabel alloc] init];
    l.numberOfLines = 0;
    l.font = kFontSizeMedium;
    l.textColor = kBodyTextColor;
    [self.view addSubview:l];
    self.headerLabel = l;
    
    UIProgressView *p = [[ UIProgressView alloc] initWithFrame:CGRectMake(0, kNavAndStatusHight, SCREEN_WIDTH, 2)];
    p.trackTintColor = kLineColor;
    p.tintColor = kBaseColor;
    [self.view addSubview:p];
    self.progressView = p;
}

/**
 次へボタンを押す
 */
- (void)didFooterButtonClicked{
    
    // 操作ログ編集
    [AppComLog writeEventLog:@"次へボタン" viewID:self.viewID LogLevel:LOGLEVELInformation withCallback:^(NSString * _Nonnull resultCode) {
        
    } atController:self];
}

/**
 閉じるボタンを押す
 */
- (void)closeSDK{
    
    // 操作ログ編集
    [AppComLog writeEventLog:@"閉じるボタン" viewID:self.viewID LogLevel:LOGLEVELInformation withCallback:^(NSString * _Nonnull resultCode) {
        
    } atController:self];
}


- (void)setViewID:(NSString *)viewID{
    _viewID = viewID;
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[ViewConfig new].viewDictionary];
    self.currentViewModel = (ViewModel *)dic[viewID];
    
    self.title = self.currentViewModel.viewTitle;
    
    if (self.currentViewModel.viewFirstDetail.length) {
        self.detailString = self.currentViewModel.viewFirstDetail;
    }
    
    if (self.currentViewModel.viewProgress) {
        [self.progressView setProgress:self.currentViewModel.viewProgress animated:NO];
    }else{
        self.progressView.hidden = YES;
    }
    self.buttonInteractionEnabled = NO;
}

- (void)setButtonInteractionEnabled:(BOOL)buttonInteractionEnabled{
    _buttonInteractionEnabled = buttonInteractionEnabled;
    self.footerButton.backgroundColor = buttonInteractionEnabled ? kBaseColor : kBaseColorUnEnabled;
    self.footerButton.userInteractionEnabled = buttonInteractionEnabled;
}

- (void)setButtonHidden:(BOOL)buttonHidden{
    _buttonHidden = buttonHidden;
    self.footerButton.hidden = buttonHidden;
}

- (void)setDetailString:(NSString *)detailString{
    _detailString = detailString;
    [self.headerLabel setText:detailString];
    CGFloat fontSize = [UITool shareUITool].textSizeMedium;
    CGFloat labelHeight = [[UITool shareUITool] heightWithWidth:SCREEN_WIDTH - (kPaddingwidthMedium * 2) font:fontSize str:detailString];
    [self.headerLabel setFrame:CGRectMake(kPaddingwidthMedium, kNavAndStatusHight + kPaddingHeightLarge, SCREEN_WIDTH - (kPaddingwidthMedium * 2), labelHeight)];
    self.positionY = kNavAndStatusHight + labelHeight + (kPaddingHeightLarge * 2);
    [self.view layoutSubviews];
}

@end
