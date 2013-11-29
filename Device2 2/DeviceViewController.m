//
//  DeviceViewController.m
//  Device2
//
//  Created by ブレイブ ソフト on 13/08/22.
//  Copyright (c) 2013年 ブレイブ ソフト. All rights reserved.
//

#import "DeviceViewController.h"

@interface DeviceViewController ()

@end
DataBese *dataBese;

@implementation DeviceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];//セルの再利用
    
    
    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(fuga:)];
    [_tableView addGestureRecognizer:longPressGestureRecognizer];
    
}
//ロングタップで編集画面へ遷移
- (void)fuga:(UILongPressGestureRecognizer*)gestureRecognizer {
    
    // UILongPressGestureRecognizerからlocationInView:を使ってタップした場所のCGPointを取得する
    CGPoint p = [gestureRecognizer locationInView:_tableView];
    // 取得したCGPointを利用して、indexPathForRowAtPoint:でタップした場所のNSIndexPathを取得する
    NSIndexPath *indexPath = [_tableView indexPathForRowAtPoint:p];
    // NSIndexPathを利用して、cellForRowAtIndexPath:で該当でUITableViewCellを取得する
    if(gestureRecognizer.state == UIGestureRecognizerStateBegan){
        dataBese = array[indexPath.row];
        DeviceEditViewController *editView = [[DeviceEditViewController alloc]init];
        editView.deviceName = dataBese.deviceName;
        editView.path = self.path;
        [[self navigationController]pushViewController:editView animated:YES];
    }
}

//セクション
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [self db];
    return array.count;//配列の数だけセルを用意
}

//セルの中身
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";//セルのID
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    [self db];//データベース処理
    dataBese = array[indexPath.row];
    cell.textLabel.text = dataBese.deviceName;
    return cell;
}

//セルがタップされたときの処理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    dataBese = array[indexPath.row];
    ModelViewController *modelView = [[ModelViewController alloc]
                                      initWithNibName:@"ModelViewController"
                                      bundle:nil];
    modelView.Id = [dataBese deviceId];
    modelView.Name = [dataBese deviceName];
    modelView.path = self.path;
    [[self navigationController]pushViewController:modelView animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; // 選択状態の解除
}
//この処理をクラスにまとめて各クラスで呼び出せるようにしたほうがいい
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
            dataBese = [[DataBese alloc]init];
            //カラム名を指定してデータを取得
            dataBese.deviceId = [rs stringForColumn:@"deviceid"];//キー
            dataBese.deviceName = [rs stringForColumn:@"deviceName"];//OS
            [array addObject:dataBese];//配列に格納
        }
        [rs close]; //テーブルを閉じる
        [db close]; //データベースを閉じる
    }else{
        NSLog(@"DBひらけないいいいい");//DBが開けなかったらここ
    }
    self.path = writableDBPath;//他クラスで使うlist.dbへのパス
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];//何行目のセルの削除ボタンが押されたか判別（n番目）
    [array removeObjectAtIndex: row];//配列に入っているn番目を削除
    //ここでtableViewを更新するとDBの中身を削除してないので同じものが再表示されてしまうから先にDBの中身を削除
    [self deleteDB];
    //セルが消えるアニメーション&tableViewの更新
    [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]  withRowAnimation:UITableViewRowAnimationFade];
}

//DB削除メソッド
-(void)deleteDB
{
    FMDatabase* db  = [FMDatabase databaseWithPath:self.path];
    NSString* sql = @"DELETE FROM main WHERE deviceName = ?";//カテゴリー削除
    NSString* sql1 = @"DELETE FROM model WHERE deviceid = ?";//端末削除
    NSString*sql2 = @"DELETE FROM day WHERE modelid = ?";//日付削除
    [db open];
    [db setShouldCacheStatements:YES];
    rs = [db executeQuery:@"SELECT modelId FROM model WHERE deviceid = (?)",dataBese.deviceId];
    array = [[NSMutableArray alloc]init];
    while ([rs next]) {
        //sql文で削除するdeviceidが同じmodeiidをmodelテーブルから取得
        [db executeUpdate:sql2,[rs stringForColumn:@"modelid"]];//取得したものを引数に指定して、日付を削除・・・・①
    }
    [db executeUpdate:sql, dataBese.deviceName];/////・・・・②
    [db executeUpdate:sql1,dataBese.deviceId];//////・・・・・③
    //数字の順番を間違えてはいけない
    [db close];
}

- (IBAction)add:(id)sender {
    DeviceAddViewController *deviceaddViewController = [[DeviceAddViewController alloc]init];
    deviceaddViewController.path = self.path;
    [[self navigationController]pushViewController:deviceaddViewController animated:YES];
}
@end
