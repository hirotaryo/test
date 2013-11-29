//
//  DeviceEditViewController.h
//  Device2
//
//  Created by ブレイブ ソフト on 13/08/29.
//  Copyright (c) 2013年 ブレイブ ソフト. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "FMDatabase.h"

@interface DeviceEditViewController : UIViewController<UITextFieldDelegate>
{
    UITextField *deviceText;
}
@property (nonatomic,strong)NSString *deviceName;
@property (nonatomic,strong)NSString *path;
@end
