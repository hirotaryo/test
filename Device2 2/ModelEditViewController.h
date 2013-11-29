//
//  ModelEditViewController.h
//  Device2
//
//  Created by ブレイブ ソフト on 13/08/29.
//  Copyright (c) 2013年 ブレイブ ソフト. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDatabase.h"
#import <sqlite3.h>

@interface ModelEditViewController : UIViewController<UITextFieldDelegate>
{
    UITextField *modelNameTextField;
    UITextField *resolutionTextFiled;
    UITextField *versionTextField;
}

@property (nonatomic,strong)NSString *modelName;
@property (nonatomic,strong)NSString *resolution;
@property (nonatomic,strong)NSString *version;
@property (nonatomic,strong)NSString *path;
@end
