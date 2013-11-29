//
//  DBAccses.m
//  Device2
//
//  Created by ブレイブ ソフト on 13/08/30.
//  Copyright (c) 2013年 ブレイブ ソフト. All rights reserved.
//

#import "DBAccses.h"
DataBese *databese;
@implementation DBAccses


-(void)db//データベース処理メソッド
{
    BOOL success;
    NSError *error;
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"list.db"];
    success = [fm fileExistsAtPath:writableDBPath];
    if(!success){
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"list.db"];
        success = [fm copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
        if(!success){
            NSLog(@"%@",[error localizedDescription]);
        }
    }
    FMDatabase* db = [FMDatabase databaseWithPath:writableDBPath];
    if ([db open]) {
        [db setShouldCacheStatements:YES];
        rs = [db executeQuery:@"SELECT * FROM main"];//テーブル名を指定
        array = [[NSMutableArray alloc]init];
        while ([rs next]) {
            //次の項目があったら繰り返し
            databese = [[DataBese alloc]init];
            //カラム名を指定してデータを取得
            databese.deviceId = [rs stringForColumn:@"deviceid"];//キー
            databese.deviceName = [rs stringForColumn:@"deviceName"];//OS
            [array addObject:databese];//配列に格納
        }
        [rs close]; //テーブルを閉じる
        [db close]; //データベースを閉じる
    }else{
        NSLog(@"DBひらけないいいいい");//DBが開けなかったらここ
    }
    self.path = writableDBPath;//他クラスで使うlist.dbへのパス
}



-(void)deleteDB
{
    FMDatabase* db  = [FMDatabase databaseWithPath:self.path];
    NSString* sql = @"DELETE FROM main WHERE deviceName = ?";//カテゴリー削除
    NSString* sql1 = @"DELETE FROM model WHERE deviceid = ?";//端末削除
    NSString*sql2 = @"DELETE FROM day WHERE modelid = ?";//日付削除
    [db open];
    [db setShouldCacheStatements:YES];
    rs = [db executeQuery:@"SELECT modelId FROM model WHERE deviceid = (?)",databese.deviceId];
    array = [[NSMutableArray alloc]init];
    while ([rs next]) {
        //sql文で削除するdeviceidが同じmodeiidをmodelテーブルから取得
        [db executeUpdate:sql2,[rs stringForColumn:@"modelid"]];//取得したものを引数に指定して、日付を削除・・・・①
    }
    [db executeUpdate:sql, databese.deviceName];/////・・・・②
    [db executeUpdate:sql1,databese.deviceId];//////・・・・・③
    //数字の順番を間違えてはいけない
    [db close];
}

@end
