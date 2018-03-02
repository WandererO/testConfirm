//
//  HUD.m
//  KangarooApp
//
//  Created by zhuangyihang on 6/16/15.
//  Copyright (c) 2015 KangarooFamily. All rights reserved.
//

#import "HUD.h"
@implementation HUD


+ (void)showMessageNo:(NSString *)message{
    [SVProgressHUD showWithStatus:message];
}
+ (void)showMessage:(NSString *)message{
    [SVProgressHUD dismissWithDelay:2];
    
    [SVProgressHUD showWithStatus:message];
}
+ (void)dismissMessage{
    [SVProgressHUD dismiss];
}
+ (void)showMessageNoImage:(NSString *)message{
    [SVProgressHUD dismissWithDelay:2];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.4]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setInfoImage:[UIImage imageNamed:@""]];
    [SVProgressHUD showInfoWithStatus:message];
}
+ (void)showErrorMessage:(NSString *)message{
    if (message.length>0) {
        [SVProgressHUD dismissWithDelay:1];
        [SVProgressHUD showErrorWithStatus:message];
        
    }
}

+ (void)showInfoMessage:(NSString *)message{
    if (message.length>0) {
        [SVProgressHUD dismissWithDelay:1];
        [SVProgressHUD showInfoWithStatus:message];
    }
}

+ (void)showSuccessMessage:(NSString *)message{
    [SVProgressHUD dismissWithDelay:1];
    [SVProgressHUD showSuccessWithStatus:message];
}

@end
