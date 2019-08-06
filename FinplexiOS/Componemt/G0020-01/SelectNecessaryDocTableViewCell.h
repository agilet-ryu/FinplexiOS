//
//  SelectNecessaryDocTableViewCell.h
//  FinplexiOS
//
//  Created by agilet-ryu on 2019/8/4.
//  Copyright © 2019 Fujitsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DocModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol SelectNecessaryDocTableViewCellDelegate <NSObject>

- (void)didSelectItem:(DocModel *)model;

@end

@interface SelectNecessaryDocTableViewCell : UITableViewCell
@property (strong, nonatomic) DocModel *model;
@property (weak, nonatomic) id<SelectNecessaryDocTableViewCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
