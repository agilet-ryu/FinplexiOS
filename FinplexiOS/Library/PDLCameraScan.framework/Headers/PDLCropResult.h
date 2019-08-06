//
//  Copyright PFU Limited 2018
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, PDLCropResult) {
    
    // 正常終了
    PDLCropResultOK = 0,
    
    // 書類の切り出しに失敗
    PDLCropResultCropFailed = 2,
};
