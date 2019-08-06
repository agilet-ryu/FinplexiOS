//
//  P2IIMG.h
//  PMIImageUtility
//
//  Copyright PFU Limited 2002-2018
//

#ifndef _P2IIMG_H_
#define _P2IIMG_H_

#include "stdint.h"

#ifdef __cplusplus
extern "C" {            /* Assume C declarations for C++ */
#endif  /* __cplusplus */

/***********************************
 画像情報
 ***********************************/
#define P2I_CLRODR_RGB	0 /* 色順 */
#define P2I_CLRODR_BGR	1 /* 色順 */

typedef struct _P2IIMG {
    unsigned char * pbyImg ;    /* イメージバッファ    */
    int32_t         nDepth ;    /* イメージのビット数(8=gray 固定) */
    int32_t         nClrOdr ;   /* 色順             */
    int32_t         nWidth ;    /* イメージの幅　　　　*/
    int32_t         nHeight ;   /* イメージの高さ     */
    int32_t         nBPL ;      /* １ラインのバイト数　*/
    int32_t         nSize ;     /* 全体のバイト数     */
    int32_t         nXReso ;    /* 主解像度　　　　　　*/
    int32_t         nYReso ;    /* 副解像度　　　　　　*/
    int32_t         nSX ;       /* 処理対象領域　　　　*/
    int32_t         nSY ;       /* 　〃　　　　　　　　*/
    int32_t         nEX ;       /* 　〃　　　　　　　　*/
    int32_t         nEY ;       /* 　〃　　　　　　　　*/
} P2IIMG ;

#define			DST_IMAGE_SINGLE		1
#define			DST_IMAGE_MULTI			2
#define			MULTI_IMAGE_MAX			50

typedef struct _P2IMULTIIMG {
    int32_t		nDstFlag ;					//	出力画像数のフラグ（SINGLE or MULTI）
    int32_t		nDstSize ;					//	出力画像数
    P2IIMG		image[MULTI_IMAGE_MAX] ;	//	出力画像
} P2IMULTIIMG, *PP2IMULTIIMG ;
    
#ifdef __cplusplus
}
#endif  /* __cplusplus */

#endif
