//
//  ModelViewController.m
//  Device2
//
//  Created by ブレイブ ソフト on 13/08/22.
//  Copyright (c) 2013年 ブレイブ ソフト. All rights reserved.
//

#import "ModelViewController.h"

@interface ModelViewController ()

@end
DataBese *databese;
ModelEditViewController *editView;
@implementation ModelViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = self;//delegateを使う
    self.tableView.dataSource = self;//TableViewを使うときに必須
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    //セルの再利用
    [_tableView registerNib:[UINib nibWithNibName:@"TVSCustomCell" bundle:nil] forCellReuseIdentifier:@"Cell"];;//カスタムセル
    [_tableView registerClass:[UITableViewHeaderFooterView class]
forHeaderFooterViewReuseIdentifier:@"Header"];
    
    
    UIBarButtonItem *hogeMetButton = [[UIBarButtonItem alloc]
                                      initWithTitle:@"+"
                                      style:UIBarButtonItemStyleBordered
                                      target:self action:@selector(add:)];  //②
    self.navigationItem.rightBarButtonItem = hogeMetButton;
    
    //空の配列を使い、表示するものがないときでもカスタムセルを使えるようにするため
    ar = [NSMutableArray array];
    [ar addObject:@" "];
    //////////////////////////////////////////////////////////////
    
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
    if(i == 0){
        databese = modelarray[indexPath.row];
        editView = [[ModelEditViewController alloc]init];
        editView.modelName = databese.modelName;
        editView.resolution = databese.resolution;
        editView.version = databese.version;
        editView.path = self.path;
        [[self navigationController]pushViewController:editView animated:YES];
        i++;
    }
}

-(void)add:(id)sender
{
    ModelAddViewController *modeladdViewController = [[ModelAddViewController alloc]init];
    modeladdViewController.deviceid = self.Id;
    modeladdViewController.path = self.path;
    [[self navigationController]pushViewController:modeladdViewController animated:YES];
}


//セルの行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [self db];
    if(modelarray.count == 0){
        return ar.count;
    }
    return modelarray.count;
}

//セクション名///////////////////////////////
- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section
{
    return self.Name;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *tableViewHeader = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"Header"];
    tableViewHeader.textLabel.text = @"UITableViewHeaderFooterView";
    return tableViewHeader;
}
//////////////////////////////////////////

//カスタムセルの高さ設定
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 71;//カスタムセルの高さに合わせる
}

//セルに表示する内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self db];//データベース処理
    TVSCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if(modelarray.count == 0){//端末が登録されてない場合はスペースだけが入っている配列を表示し、タップ不可にする
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.nameLabel.text = [NSString stringWithFormat:@"%@",[ar objectAtIndex:indexPath.row]];
        cell.resolutionLabel.text = [NSString stringWithFormat:@"%@",[ar objectAtIndex:indexPath.row]];
        cell.versionLabel.text = [NSString stringWithFormat:@"%@",[ar objectAtIndex:indexPath.row]];
        return cell;
    }else{
        //databese = modelarray[indexPath.row];
        databese = [modelarray objectAtIndex:indexPath.row];
        NSString *str = @"1";
        NSRange searchResult = [databese.Rental rangeOfString:str];//Rentalの中に１があった場合レンタル中
        if(searchResult.location == NSNotFound){
            // みつからない場合の処理
            cell.nameLabel.textColor = [UIColor blackColor];
            cell.nameLabel.text = databese.modelName;
            cell.versionLabel.text =databese.version;
            cell.resolutionLabel.text = databese.resolution;
        }else{
            // レンタル中の場合はtextColorの文を追加
            cell.nameLabel.textColor = [UIColor redColor];
            cell.nameLabel.text = databese.modelName;
            cell.versionLabel.text =databese.version;
            cell.resolutionLabel.text = databese.resolution;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{//セルがタップされたときの処理
    if(modelarray.count != 0){
        databese = modelarray[indexPath.row];
        LastViewController *lastView = [[LastViewController alloc]
                                        initWithNibName:@"LastViewController"
                                        bundle:nil];
        lastView.sctionName = [databese modelName];
        lastView.modelid = [databese modelId];
        lastView.rental = [databese Rental];
        lastView.path = self.path;
        [[self navigationController]pushViewController:lastView animated:YES];
        [tableView deselectRowAtIndexPath:indexPath animated:YES]; // 戻ってきたときにセルの選択状態解除
    }
}

-(void)db//データベース処理メソッド
{
    FMDatabase* db = [FMDatabase databaseWithPath:self.path];
    if ([db open]) {
        [db setShouldCacheStatements:YES];
        rs = [db executeQuery:@"SELECT * FROM model"];//テーブル名を指定
        modelarray = [[NSMutableArray alloc]init];
        while ([rs next]) {
            //ここでデータを展開
            databese = [[DataBese alloc]init];
            databese.modelName   = [rs stringForColumn:@"modelName"];//フィールド名を指定
            databese.modelId     = [rs stringForColumn:@"modelId"];
            databese.deviceID    = [rs stringForColumn:@"deviceid"];
            databese.resolution  = [rs stringForColumn:@"Resolution"];
            databese.version     = [rs stringForColumn:@"Version"];
            databese.Rental      = [rs stringForColumn:@"Rental"];
            NSRange searchResult = [databese.deviceID rangeOfString:_Id];//modelNameのなかにKeyがあるかチェック
            if(searchResult.location == NSNotFound){
                // みつからない場合の処理
            }else{
                // みつかった場合の処理
                [modelarray addObject:databese];
            }
        }
        [rs close]; //テーブルを閉じる
        [db close]; //データベースを閉じる
    }else{
        NSLog(@"DBひらけないいいいい");//DBが開けなかったらここ
    }
}

-(void)viewWillAppear:(BOOL)animated//遷移先から戻ってきたときにtableview更新
{
    [self.tableView reloadData];
    i = 0;
}


//セルをスワイプで削除ボタン表示
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (modelarray.count != 0) {
        // 削除ボタン表示
        editingStyle = UITableViewCellEditingStyleDelete;
        [self removeContents:indexPath];
    } else {
        editingStyle = UITableViewCellEditingStyleNone;
    }
}

// 削除ボタン制御
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (modelarray.count != 0) {
        // 削除ボタン表示
        //        NSInteger row = [indexPath row];
        //        [modelarray removeObjectAtIndex: row];
        //        //[contentsArry removeObjectAtIndex: row];
        //        [self deleteDB];
        //        コメントを外すとスワイプだけで消える
        //        //セルが消えるアニメーション
        //        //[_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]  withRowAnimation:UITableViewRowAnimationFade];
        //
        //        [self.tableView reloadData];
        return UITableViewCellEditingStyleDelete;
    } else {
        return UITableViewCellEditingStyleNone;
    }
}

- (BOOL)tableView:(UITableView*)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath*)indexPath
{
	return YES;
}

- (void)removeContents:(NSIndexPath*)indexPath
{
    
    //選択したrow番目の配列要素を削除する。
    NSInteger row = [indexPath row];
    [modelarray removeObjectAtIndex: row];
    //[contentsArry removeObjectAtIndex: row];
    [self deleteDB];
    [self.tableView reloadData];
    /*注意
     カスタムセルを使ってセルの高さを広げてるため、端末が一つしか登録されてないときに削除をすると通常のセルに切り替わるため汚く見えてしまう*/
    //スペースだけを入れた配列を表示し、セルをタップ不可にすることで対応
}
-(void)deleteDB
{
    NSLog(@"%@",databese.modelName);
    NSLog(@"%@",databese.modelId);
    FMDatabase* db  = [FMDatabase databaseWithPath:self.path];
    NSString* sql1 = @"DELETE FROM model WHERE modelName = ?";//端末削除
    NSString*sql2 = @"DELETE FROM day WHERE modelid = ?";//日付削除
    [db open];
    [db executeUpdate:sql1,databese.modelName];
    [db executeUpdate:sql2,databese.modelId];
    [db close];
}


@end
