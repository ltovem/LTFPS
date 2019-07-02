//
// LTFPS.h
// LTFPS
//
//  Auther:    田高伟
//  email:     mailto:t@ltove.com
//  webSite:   https://www.ltove.com
//  GitHub:    https://github.com/LTOVEM/
//
// Created by LTOVE on 2019/7/2.
// Copyright © 2019 LTOVE. All rights reserved.
//
    

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

UIKIT_EXTERN NSNotificationName LTFPSNotification;
@interface LTFPS : UIWindow

@property (nonatomic,assign,getter=isenable)BOOL enable;

+ (instancetype)share;
@end

NS_ASSUME_NONNULL_END
