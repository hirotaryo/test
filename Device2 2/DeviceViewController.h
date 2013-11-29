//
//  DeviceViewController.h
//  Device2
//
//  Created by ブレイブ ソフト on 13/08/22.
//  Copyright (c) 2013年 ブレイブ ソフト. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDatabase.h"
#import "ModelViewController.h"
#import <sqlite3.h>
#import "DeviceAddViewController.h"
#import "DataBese.h"
#import "DeviceEditViewController.h"
#import "DBAccses.h"
@interface DeviceViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate>
{
    FMResultSet *rs;
    NSMutableArray *array;
    int i;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSString *path;
- (IBAction)add:(id)sender;




@end
