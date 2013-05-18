/*==============================================================================
 Copyright (c) 2010-2013 QUALCOMM Austria Research Center GmbH.
 All Rights Reserved.
 Qualcomm Confidential and Proprietary
 ==============================================================================*/


#import <Foundation/Foundation.h>

@interface Texture : NSObject
- (BOOL)copyImageDataForOpenGL:(CFDataRef)imageData;
@property (nonatomic, readonly) int width;
@property (nonatomic, readonly) int height;
@property (nonatomic) int textureID;
@property (nonatomic, readonly) unsigned char* pngData;

@end
