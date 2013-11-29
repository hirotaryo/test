//
//  AppDelegate.h
//  Device2
//
//  Created by ブレイブ ソフト on 13/08/22.
//  Copyright (c) 2013年 ブレイブ ソフト. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeviceViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UIWindow *window;
    UIViewController *deviceViewController;
    UINavigationController *navigationController;
}
@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,strong) UIViewController *deviceViewController;
@end
