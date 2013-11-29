//
//  DBAccses.h
//  Device2
//
//  Created by ブレイブ ソフト on 13/08/30.
//  Copyright (c) 2013年 ブレイブ ソフト. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DeviceViewController.h"
#import "FMDatabase.h"
#import <sqlite3.h>
#import "DataBese.h"

@interface DBAccses : NSObject
{
    FMResultSet *rs;
    NSMutableArray *array;
}

@property(nonatomic,strong)NSString *path;
-(void)db;
-(void)deleteDB;

@end
