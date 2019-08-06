//
//  SelectReadMethodView.m
//  FinplexiOS
//
//  Created by agilet-ryu on 2019/8/4.
//  Copyright © 2019 Fujitsu. All rights reserved.
//

#import "SelectReadMethodView.h"
#import "UITool.h"

@implementation SelectReadMethodView


- (UIButton *)getCameraScanButtonWithKBNModel:(KBNModel *)model{
    UIButton *bt1 = [UIButton buttonWithType:UIButtonTypeCustom];
    bt1.backgroundColor = [UIColor whiteColor];
    [bt1 setImage:[UIImage imageNamed:model.STM1] forState:UIControlStateNormal];
    [bt1 setTitle:@"カメラ撮影" forState:UIControlStateNormal];
    [bt1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    bt1.adjustsImageWhenHighlighted = NO;
    bt1.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 50);
    bt1.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    bt1.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [bt1 setFrame:CGRectMake(0, 0, 1, 1)];
    bt1.layer.borderColor = kLineColor.CGColor;
    bt1.layer.borderWidth = kLineWidth;
    bt1.layer.cornerRadius = 20.0f;
    //    bt1.layer.shadowOpacity = 0.1f;
    //    bt1.layer.shadowOffset = CGSizeMake(4, 4);
    bt1.layer.masksToBounds = NO;
    return bt1;
}
- (UIButton *)getNFCButtonWithKBNModel:(KBNModel *)model{
    UIButton *bt2 = [UIButton buttonWithType:UIButtonTypeCustom];
    bt2.backgroundColor = [UIColor whiteColor];
    [bt2 setImage:[UIImage imageNamed:model.STM1] forState:UIControlStateNormal];
    [bt2 setTitle:@"NFC読み取り" forState:UIControlStateNormal];
    [bt2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    bt2.adjustsImageWhenHighlighted = NO;
    bt2.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 50);
    bt2.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    bt2.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [bt2 setFrame:CGRectMake(0, 0, 1, 1)];
    bt2.layer.borderColor = kLineColor.CGColor;
    bt2.layer.borderWidth = kLineWidth;
    bt2.layer.cornerRadius = 20.0f;
    //    bt2.layer.shadowOpacity = 0.15f;
    //    bt2.layer.shadowOffset = CGSizeMake(4, 4);
    bt2.layer.masksToBounds = NO;
    return bt2;
}
@end
