//
//  SelectNecessaryDocTableViewCell.m
//  FinplexiOS
//
//  Created by agilet-ryu on 2019/8/4.
//  Copyright © 2019 Fujitsu. All rights reserved.
//

#import "SelectNecessaryDocTableViewCell.h"
@interface SelectNecessaryDocTableViewCell()
@property (nonatomic, strong) UIButton *bu;
@end
@implementation SelectNecessaryDocTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setFrame:CGRectMake(0, 0, SCREEN_WIDTH, (kPaddingHeightSmall * 2) + kButtonHeightMedium)];
        [self initSubView];
    }
    return self;
}

- (void)initSubView{
    UIButton *bu = [UIButton buttonWithType:UIButtonTypeCustom];
    bu.backgroundColor = [UIColor whiteColor];
    [bu setFrame:CGRectMake(kPaddingwidthMedium, kPaddingHeightSmall, self.frame.size.width - (kPaddingwidthMedium * 2), kButtonHeightMedium)];
    bu.layer.borderWidth = kLineWidth;
    bu.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [bu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    bu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    bu.titleLabel.font = kFontSizeMedium;
    [bu addTarget:self action:@selector(selectItem) forControlEvents:UIControlEventTouchUpInside];
    bu.layer.borderColor = kLineColor.CGColor;
    bu.layer.cornerRadius = kButtonRadiusMedium;
    bu.layer.masksToBounds = YES;
    [self.contentView addSubview:bu];
    self.bu = bu;
}

- (void)setModel:(DocModel *)model{
    _model = model;
    [self.bu setTitle:model.kbnModel.name forState:UIControlStateNormal];
    self.bu.layer.borderColor = model.isSelected ? kBaseColor.CGColor : kLineColor.CGColor;
    //    self.bu.layer.shadowOpacity = 0.15f;
    //    self.bu.layer.shadowOffset = CGSizeMake(4, 4);
    //    self.bu.layer.masksToBounds = NO;
    model.isSelected = false;
}

- (void)selectItem {
    self.model.isSelected = true;
    if ([self.delegate respondsToSelector:@selector(didSelectItem:)]) {
        [self.delegate didSelectItem:self.model];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
