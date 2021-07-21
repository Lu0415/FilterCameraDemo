//
//  demoUtils.h
//  TestCamera
//
//  Created by USER on 2019/6/20.
//  Copyright © 2019 hyper-light N030. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

UIImage* loadImageCallback(const char* name, void* arg);

void loadImageOKCallback(UIImage* img, void* arg);

extern const char* g_effectConfig[];
extern int g_configNum;

extern NSString *titleArray[];

@interface DemoUtils : NSObject

+ (void)saveVideo :(NSURL*)videoURL;
+ (void)saveImage :(UIImage*)image;
+ (void)saveImage :(UIImage*)image completionBlock:(void (^)(NSURL*, NSError*))block;

@end


@interface MyImage : UIImageView
@property (nonatomic) int index;
@end


@interface MyButton : UIButton
@property (nonatomic) int index;
@end


@interface MyLabel : UILabel
@property (nonatomic) int index;
@end
