//
//  DeviceAddViewController.h
//  Device2
//
//  Created by ブレイブ ソフト on 13/08/26.
//  Copyright (c) 2013年 ブレイブ ソフト. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDatabase.h"
#import "DataBese.h"
#import <sqlite3.h>
@interface DeviceAddViewController : UIViewController<UITextFieldDelegate>
{
    UITextField *deviceText;
}
@property(nonatomic,strong) NSString *path;
@end
