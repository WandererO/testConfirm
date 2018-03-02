//
//  HUD.h
//  KangarooApp
//
//  Created by zhuangyihang on 6/16/15.
//  Copyright (c) 2015 KangarooFamily. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import <UIKit/UIKit.h>
@interface HUD : NSObject


+ (void)showMessageNo:(NSString *)message;
+ (void)showMessage:(NSString *)message;
+ (void)dismissMessage;
+ (void)showErrorMessage:(NSString *)message;
+ (void)showSuccessMessage:(NSString *)message;
+ (void)showInfoMessage:(NSString *)message;
+ (void)showMessageNoImage:(NSString *)message;
@end
