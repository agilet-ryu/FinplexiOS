//
//  Wrapper.h
//  PMIJudgeRectangle
//
//  Copyright PFU Limited 2016-2018
//

#ifndef PMIJudgeRectangle_Wrapper_h
#define PMIJudgeRectangle_Wrapper_h

#import <UIKit/UIKit.h>
#import <PMIImageUtility/PMIImageUtility.h>

@interface PMIJudgeRectangle : NSObject
+ (bool) judgeRectangle:(NSArray*)framePoints cornerPoints:(NSArray*)cornerPoints parallelSlice:(double)parallelSlice angleSlice:(double)angleSlice status:(PMIStatus*)status;

@end

#endif /* PMIJudgeRectangle_Wrapper_h */
