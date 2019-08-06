//
//  Wrapper.h
//  PMIBlurDetector
//
//  Copyright PFU Limited 2016-2018
//
#ifndef PMIBlurDetectorWrapper_h
#define PMIBlurDetectorWrapper_h

#import <UIKit/UIKit.h>
#import <PMIImageUtility/PMIImageUtility.h>

@interface PMIBlurDetectorParam : NSObject
    @property (nonatomic, readwrite) int roi_size;
    @property (nonatomic, readwrite) int roi_gap;
    @property (nonatomic, readwrite) int roi_margin;
    @property (nonatomic, readwrite) int roi_pattern;
    @property (nonatomic, readwrite) double score_diff_threshold;
    @property (nonatomic, readwrite) double initialSlice;
    @property (nonatomic, readwrite) double incrementRate;
    @property (nonatomic, readwrite) double decrementRate;

-(id)init;
@end

@interface PMIBlurDetector : NSObject
+ (bool) judgeImageBlurred:(UIImage*)image initialSlice:(double)initialSlice incrementRate:(double)incrementRate decrementRate:(double)decrementRate threshold:(double*)threshold status:(PMIStatus*)status;

+ (bool) judgeImageBlurred2:(UIImage*)image threshold:(double*)threshold status:(PMIStatus*)status lastScore:(double*)lastScore param:(const PMIBlurDetectorParam *)param;

+ (bool) judgeImageBlurredRect:(UIImage*)image threshold:(double*)threshold status:(PMIStatus*)status lastScore:(double*)lastScore param:(const PMIBlurDetectorParam *)param region_left: (int)region_left region_top: (int)region_top  region_right: (int)region_right  region_bottom: (int)region_bottom;

@end

#endif /* PMIBlurDetectorWrapper_h */
