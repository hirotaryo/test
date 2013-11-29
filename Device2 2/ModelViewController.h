//
//  ModelViewController.h
//  Device2
//
//  Created by ブレイブ ソフト on 13/08/22.
//  Copyright (c) 2013年 ブレイブ ソフト. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "TVSCustomCell.h"
#import "FMDatabase.h"
#import "DataBese.h"
#import "LastViewController.h"
#import "ModelAddViewController.h"
#import "ModelEditViewController.h"
@interface ModelViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,
UINavigationControllerDelegate>
{
    FMResultSet *rs;
    NSMutableArray *ar;
    NSMutableArray *modelarray;
    int i;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

///////deviceViewから値をもらうための変数/////
@property(nonatomic,strong) NSString *Id;
@property(nonatomic,strong) NSString *Name;
@property(nonatomic,strong) NSString *Num;
@property(nonatomic,strong) NSString *sectionName;
@property(nonatomic,strong) NSString *path;
/////////////////////////////////////////
@end
