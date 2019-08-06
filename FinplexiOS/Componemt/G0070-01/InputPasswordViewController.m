//
//  InputPasswordViewController.m
//  FinplexiOS
//
//  Created by agilet-ryu on 2019/8/4.
//  Copyright © 2019 Fujitsu. All rights reserved.
//

#import "InputPasswordViewController.h"
#import "NFCReadViewController.h"

@interface InputPasswordViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *tf1;
@property (nonatomic, strong) UITextField *tf2;
@property (nonatomic, strong) UIButton *nextBT;
@end

@implementation InputPasswordViewController

static InfoDatabase *db = nil;
- (void)viewDidLoad {
    [super viewDidLoad];

    self.viewID = @"G0070-01";
    [self initView];
}

- (void)initView {
    db = [InfoDatabase shareInfoDatabase];
    if (db.identificationData.DOC_TYPE == [Utils getSystemCode].id_doc_KBN.CARD_DRIVER.code) [self addViewGroup2];
}

- (void)addViewGroup {
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(16, 210, [UIScreen mainScreen].bounds.size.width - 32, 30)];
    title.text = @"暗証番号1";
    [self.view addSubview:title];
    
    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(16, 250, [UIScreen mainScreen].bounds.size.width - 32, 50)];
    tf.backgroundColor = kLineColor;
    tf.borderStyle = UITextBorderStyleRoundedRect;
    tf.tintColor = kBodyTextColor;
    tf.placeholder = @"数値４桁";
    tf.keyboardType = UIKeyboardTypeNumberPad;
    tf.keyboardAppearance = UIKeyboardAppearanceAlert;
    tf.secureTextEntry = YES;
    tf.delegate = self;
    [self.view addSubview:tf];
    self.tf1 = tf;
    
    UIButton *image = [UIButton buttonWithType:UIButtonTypeCustom];
    [image setFrame:CGRectMake(0, 0, 70, 50)];
    [image setTitle:@"表示" forState:UIControlStateNormal];
    [image setTitle:@"非表示" forState:UIControlStateSelected];
    [image setTitleColor:[UIColor colorWithRed:(34.0f / 255.0f)
                                         green:(132.0f / 255.0f)
                                          blue:(216.0f / 255.0f)
                                         alpha:1.0f] forState:UIControlStateNormal];
    image.adjustsImageWhenHighlighted = NO;
    [image addTarget:self action:@selector(showText1:) forControlEvents:UIControlEventTouchUpInside];
    tf.rightView = image;
    tf.rightViewMode = UITextFieldViewModeNever;
}

- (void)addViewGroup2 {
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(16, 340, [UIScreen mainScreen].bounds.size.width - 32, 30)];
    title.text = @"暗証番号2";
    [self.view addSubview:title];
    
    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(16, 380, [UIScreen mainScreen].bounds.size.width - 32, 50)];
    tf.borderStyle = UITextBorderStyleRoundedRect;
    tf.tintColor = kBodyTextColor;
    tf.placeholder = @"数値４桁";
    tf.backgroundColor = kLineColor;
    tf.keyboardType = UIKeyboardTypeNumberPad;
    tf.keyboardAppearance = UIKeyboardAppearanceAlert;
    tf.secureTextEntry = YES;
    tf.delegate = self;
    [self.view addSubview:tf];
    self.tf2 = tf;
    
    UIButton *image = [UIButton buttonWithType:UIButtonTypeCustom];
    [image setFrame:CGRectMake(0, 0, 70, 50)];
    [image setTitle:@"表示" forState:UIControlStateNormal];
    [image setTitle:@"非表示" forState:UIControlStateSelected];
    [image setTitleColor:[UIColor colorWithRed:(34.0f / 255.0f)
                                         green:(132.0f / 255.0f)
                                          blue:(216.0f / 255.0f)
                                         alpha:1.0f] forState:UIControlStateNormal];
    image.adjustsImageWhenHighlighted = NO;
    [image addTarget:self action:@selector(showText2:) forControlEvents:UIControlEventTouchUpInside];
    tf.rightView = image;
    tf.rightViewMode = UITextFieldViewModeNever;
}

- (void)didFooterButtonClicked {
    [super didFooterButtonClicked];
    NFCReadViewController *re = [[NFCReadViewController alloc] init];
    re.currentModel = self.currentModel;
    [self.navigationController pushViewController:re animated:YES];
}

- (void)showText1:(UIButton *)button {
    button.selected = !button.isSelected;
    self.tf1.secureTextEntry = !button.selected;
}

- (void)showText2:(UIButton *)button {
    button.selected = !button.isSelected;
    self.tf2.secureTextEntry = !button.selected;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (string.length == 0) return YES;
    NSMutableString *newtxt = [NSMutableString stringWithString:textField.text];
    [newtxt replaceCharactersInRange:range withString:string];
    if (newtxt.length > 4) return NO;
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.tf1.text.length > 0 ? [self.tf1 setRightViewMode:UITextFieldViewModeAlways] : [self.tf1 setRightViewMode:UITextFieldViewModeNever];
    self.tf2.text.length > 0 ? [self.tf2 setRightViewMode:UITextFieldViewModeAlways] : [self.tf2 setRightViewMode:UITextFieldViewModeNever];
    if (textField.text.length == 4) {
        textField.backgroundColor = [UIColor whiteColor];
    } else {
        textField.backgroundColor = kLineColor;
    }
    if (self.tf1.text.length == 4 && self.tf2.text.length == 4) {
        self.nextBT.userInteractionEnabled = YES;
        self.nextBT.backgroundColor = kBaseColor;
    } else{
        self.nextBT.userInteractionEnabled = NO;
        self.nextBT.backgroundColor = kBaseColorUnEnabled;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField{
    return[textField resignFirstResponder];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent*)event{
    [self.view endEditing:YES];
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
