//
//  demoUtils.m
//  TestCamera
//
//  Created by USER on 2019/6/20.
//  Copyright © 2019 hyper-light N030. All rights reserved.
//

#import "demoUtils.h"
#import "cgeSharedGLContext.h"
#import <AssetsLibrary/ALAssetsLibrary.h>

const char* g_effectConfig[] = {
    nil,
    "@adjust saturation 1.8 @adjust brightness 0.15",
    "@adjust saturation 1.8 @adjust brightness 0.15 @adjust whitebalance 0.2 1",
    "@adjust saturation 1.8 @adjust brightness 0.15 @adjust whitebalance -0.2 1",
    "@adjust contrast 1.24 @adjust saturation 1.24 @adjust shadowhighlight -20 20",
    "@adjust contrast 1.24 @adjust saturation 1.24 @adjust shadowhighlight -20 20 @adjust whitebalance 0.2 1",
    "@adjust contrast 1.24 @adjust saturation 1.24 @adjust shadowhighlight -20 20 @adjust whitebalance -0.2 1",
    "@adjust saturation 0 @adjust contrast 1.24 @adjust shadowhighlight -25 25",
    "@adjust contrast 0.9 @adjust saturation 0.9 @adjust level 0.15 1 0.61 @adjust colorbalance 0.04 -0.01 -0.04",
    "@adjust contrast 0.9 @adjust saturation 0.9 @adjust brightness 0.1 @adjust whitebalance 0.01 1"
};

int g_configNum = sizeof(g_effectConfig) / sizeof(*g_effectConfig);

NSString *titleArray[] = {
    @"原圖",
    @"鮮豔",
    @"鮮豔暖色",
    @"鮮豔冷色",
    @"戲劇",
    @"戲劇暖色",
    @"戲劇冷色",
    @"黑白",
    @"摩登",
    @"清新"
};

UIImage* loadImageCallback(const char* name, void* arg) {
    NSString* filename = [NSString stringWithUTF8String:name];
    return [UIImage imageNamed:filename];
}

void loadImageOKCallback(UIImage* img, void* arg) {
    
}


@implementation DemoUtils

+ (void)saveVideo :(NSURL*)videoURL {
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    if ([library videoAtPathIsCompatibleWithSavedPhotosAlbum:videoURL]) {
        [library writeVideoAtPathToSavedPhotosAlbum:videoURL completionBlock:^(NSURL *assetURL, NSError *error) {
             dispatch_async(dispatch_get_main_queue(), ^{

                 if (error) {
//                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Video Saving Failed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                     [alert show];
                 } else {
//                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Video Saved" message:@"Saved To Photo Album" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                     [alert show];
                 }
             });
         }];
    } else {
        [CGEProcessingContext mainSyncProcessingQueue:^{
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"File format is not compatibale with album!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [alert show];
        }];
    }
}

+ (void)saveImage:(UIImage *)image {
    [DemoUtils saveImage:image completionBlock:nil];
}

+ (void)saveImage:(UIImage *)image completionBlock:(void (^)(NSURL *, NSError *))block {
    [CGEProcessingContext mainSyncProcessingQueue:^{
        
        if (image != nil) {
            [[[ALAssetsLibrary alloc] init] writeImageToSavedPhotosAlbum:[image CGImage] orientation:(ALAssetOrientation)[image imageOrientation] completionBlock:block];
        }
    }];
}

@end

@implementation MyImage


@end

@implementation MyButton


@end

@implementation MyLabel


@end

