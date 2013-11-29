//
//  ModelAddViewController.h
//  Device2
//
//  Created by ブレイブ ソフト on 13/08/27.
//  Copyright (c) 2013年 ブレイブ ソフト. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDatabase.h"
#import "DataBese.h"
#import <sqlite3.h>
#import "FMResultSet.h"
@interface ModelAddViewController : UIViewController<UITextFieldDelegate>
{
    FMResultSet *rs;
    
    //FMResultSet *subrs;
    NSMutableArray *max;
    UITextField *modelNameTextField;
    UITextField *resolutionTextFiled;
    UITextField *versionTextField;
}
@property (nonatomic,strong) NSString *modelid;
@property (nonatomic,strong) NSString *deviceid;
@property(nonatomic,strong) NSString *path;

@end
