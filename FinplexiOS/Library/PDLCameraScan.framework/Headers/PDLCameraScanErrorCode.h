//
//  Copyright PFU Limited 2017-2018
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, PDLCameraScanErrorCode) {
    PDLCameraScanErrorCodeOK = 0,
    PDLCameraScanErrorCodeMemory = -2001,
    PDLCameraScanErrorCodeDLScanUninitialized = -6001,
    PDLCameraScanErrorCodeCamScanUnKnown = 9000,
    PDLCameraScanErrorCodeCamScanInvalidArgument = 9001,
    PDLCameraScanErrorCodeCamScanInternal = 9002,
    PDLCameraScanErrorCodeCamScanBadSequence = 9003,
    PDLCameraScanErrorCodeCamScanHardwareFailed = 9100,
    PDLCameraScanErrorCodeCamScanNotReleased = 9200,
};
