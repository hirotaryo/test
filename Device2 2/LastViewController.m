
//
//  LastViewController.m
//  Device2
//
//  Created by ブレイブ ソフト on 13/08/22.
//  Copyright (c) 2013年 ブレイブ ソフト. All rights reserved.
//

#import "LastViewController.h"
DataBese *databese;
@interface LastViewController ()

@end
@implementation LastViewController
@synthesize modelid;
@synthesize sctionName;
NSInteger selectedRow;
NSString *namestr;
int i = 5;
int f = 20;
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = self;//delegateを使う
    self.tableView.dataSource = self;//TableViewを使うときに必須
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];//セルの再利用
    [_tableView registerNib:[UINib nibWithNibName:@"TVSCustomCell" bundle:nil] forCellReuseIdentifier:@"Cell"];;//カスタムセル
    
    [self.tableView registerClass:[UITableViewHeaderFooterView class]
forHeaderFooterViewReuseIdentifier:@"Header"];
    
    NSString *str = @"1";
    NSRange searchResult = [self.rental rangeOfString:str];//Rentalの中に１があった場合レンタル中
    if(searchResult.location == NSNotFound){
        // みつからない場合の処理
        ChangeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        ChangeBtn.frame = CGRectMake(10,80, 300, 30);
        [ChangeBtn setTitle:@"借りる" forState:UIControlStateNormal];
        [ChangeBtn addTarget:self action:@selector(Change:)
            forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:ChangeBtn];
        
        checkLabel = [[UILabel alloc] init];
        checkLabel.frame = CGRectMake(125, 10, 100, 50);
        checkLabel.textColor = [UIColor blackColor];
        checkLabel.font = [UIFont fontWithName:@"AppleGothic" size:20];
        checkLabel.text = @"貸出可";
        [self.view addSubview:checkLabel];
        
    }else{
        // レンタル中の場合はtextColorの文を追加
        
        checkLabel = [[UILabel alloc] init];
        checkLabel.frame = CGRectMake(125, 10, 100, 50);
        checkLabel.textColor = [UIColor redColor];
        checkLabel.font = [UIFont fontWithName:@"AppleGothic" size:20];
        checkLabel.text = @"貸出中";
        [self.view addSubview:checkLabel];
        
        ChangeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        ChangeBtn.frame = CGRectMake(10,80, 300, 30);
        [ChangeBtn setTitle:@"返却" forState:UIControlStateNormal];
        [ChangeBtn addTarget:self action:@selector(Change:)
            forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:ChangeBtn];
    }
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.frame = CGRectMake(100, 110, 150, 50);
    label1.textColor = [UIColor blackColor];
    label1.font = [UIFont fontWithName:@"AppleGothic" size:20];
    label1.text = @"最新履歴一覧";
    [self.view addSubview:label1];
    
    UILabel *namelabel = [[UILabel alloc] init];
    namelabel.frame = CGRectMake(50, 160, 80, 50);
    label1.backgroundColor = [UIColor clearColor];
    namelabel.textColor = [UIColor blackColor];
    namelabel.font = [UIFont fontWithName:@"AppleGothic" size:20];
    namelabel.text = @"使用者";
    [self.view addSubview:namelabel];
    
    UILabel *uelabel = [[UILabel alloc] init];
    uelabel.frame = CGRectMake(200, 145, 80, 50);
    uelabel.textColor = [UIColor blackColor];
    uelabel.font = [UIFont fontWithName:@"AppleGothic" size:20];
    uelabel.text = @"返却日付";
    [self.view addSubview:uelabel];
    
    UILabel *sitalabel = [[UILabel alloc] init];
    sitalabel.frame = CGRectMake(200, 175, 80, 50);
    sitalabel.backgroundColor = [UIColor clearColor];
    sitalabel.textColor = [UIColor blackColor];
    sitalabel.font = [UIFont fontWithName:@"AppleGothic" size:20];
    sitalabel.text = @"貸出日付";
    [self.view addSubview:sitalabel];
    
    btn1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn1.frame = CGRectMake(10, 120, 70, 30);
    [btn1 setTitle:@"最新20件" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(History:)
   forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:btn1];
    
    [self.navigationItem setTitle:sctionName];
    //[self.tableView reloadData];
    
}

//履歴表示数変更
-(void)History:(id)sender;
{
    if(i == 5){
        i = 20;
        [self.tableView reloadData];
        [btn1 setTitle:@"最新5件" forState:UIControlStateNormal];
    }else{
        i = 5;
        [self.tableView reloadData];
        [btn1 setTitle:@"最新20件" forState:UIControlStateNormal];
    }
}

//レンタル処理
- (void)Change:(id)sender;
{
    if([ChangeBtn.currentTitle isEqualToString:@"借りる"]){
        // UIPickerView
        UIPickerView *piv = [[UIPickerView alloc] init];
        piv.center = self.view.center; // 中央に表示
        piv.delegate = self; // デリゲートを自分自身に設定
        piv.dataSource = self; // データソースを自分自身に設定
        piv.showsSelectionIndicator = YES;
        
        //高さの調整
        piv.backgroundColor = [UIColor redColor];
        CGRect rect = piv.frame;
        rect.origin.y -= 100;
        piv.frame = rect;
        
        // アクションシート
        UIActionSheet *as = [[UIActionSheet alloc] init];
        as.delegate = self;
        as.title = @"選択\n\n\n\n\n\n\n\n\n\n\n\n\n\n";
        [as addButtonWithTitle:@"決定"];
        [as addButtonWithTitle:@"キャンセル"];
        as.cancelButtonIndex = 1;
        as.destructiveButtonIndex = 0;
        [as addSubview:piv];
        [as showInView:self.view.window];
        
    }else{
        [self returnDB];
        checkLabel.text = @"貸出可";
        checkLabel.textColor = [UIColor blackColor];
        [ChangeBtn setTitle:@"借りる" forState:UIControlStateNormal];
        [self.tableView reloadData];
    }
    
}

//アクションシート
-(void)actionSheet:(UIActionSheet*)actionSheet
clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (buttonIndex) {
        case 0:
            // 決定ボタンが押されたときの処理を記述する
            //NSLog(@"名前選択");
            
            [self nameDB];
            namestr = [NSString stringWithFormat:@"%d",selectedRow];
            [self dayDB];
            [self.tableView reloadData];
            checkLabel.text = @"貸出中";
            checkLabel.textColor = [UIColor redColor];
            [ChangeBtn setTitle:@"返却" forState:UIControlStateNormal];
            break;
    }
    
}

//選択されたピッカービューを取得
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //0列目の選択している行番号を取得
    selectedRow = [pickerView selectedRowInComponent:0];
}


//ピッカーの位置
- (CGFloat)pickerView:(UIPickerView *)pickerView
    widthForComponent:(NSInteger)component
{
    return 200.0;
}

//ピッカーの行数
- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    [self nameDB];
    return nameArray.count;
}

//ピッカーの列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

/**
 * ピッカーに表示する値を返す
 */
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    databese = [nameArray objectAtIndex:row];
    return  databese.name;
}

//セクション
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//セルの行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [self db];
    if(nameArray.count < 5){
        return nameArray.count;
    }else if (nameArray.count > 5 && i == 20 && nameArray.count < 20){
        return nameArray.count;
    }else {
        return i;
    }
    
}


//セルに表示する内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self db];
    TVSCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;  //セルを選択させない
    databese = [nameArray objectAtIndex:indexPath.row];
    cell.versionLabel.font = [UIFont systemFontOfSize:10];
    cell.resolutionLabel.font = [UIFont systemFontOfSize:10];
    cell.nameLabel.text = databese.name;
    cell.resolutionLabel.text = databese.DayString;
    cell.versionLabel.text = databese.returnDay;
    return cell;
}

//セルの高さ設定
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 71;//カスタムセルの高さの設定デフォルトは44
}

-(void)db//データベース処理メソッド
{
    FMDatabase* db = [FMDatabase databaseWithPath:self.path];
    if ([db open]) {
        [db setShouldCacheStatements:YES];
        [db executeQuery:@"SELECT day FROM day ORDER BY day DESC"];
        rs = [db executeQuery:@"SELECT * FROM day WHERE modelid = (?) ORDER BY day DESC",modelid];//テーブル名を指定
        nameArray = [[NSMutableArray alloc]init];
        while ([rs next]) {
            databese = [[DataBese alloc]init];
            //ここでデータを展開
            databese.nameID     = [rs stringForColumn:@"nameID"];//こいつを使って名前を出したいよ
            databese.modelID  = [rs stringForColumn:@"modelid"];
            databese.DayString  = [rs stringForColumn:@"day"];
            databese.returnDay  = [rs stringForColumn:@"returnDay"];
            subrs = [db executeQuery:@"SELECT * FROM name WHERE nameid = (?)",databese.nameID];
            while ([subrs next]) {
                databese.name = [subrs stringForColumn:@"name"];
                [nameArray addObject:databese];
            }
        }
        [rs close];
    }
    [db close];/////動かすな
}

//PickerViewに表示する名前と名前のidを取得するdbメソッド
-(void)nameDB
{
    //作成したテーブルからデータを取得
    FMDatabase* db = [FMDatabase databaseWithPath:self.path];
    if ([db open]) {
        [db setShouldCacheStatements:YES];
        rs = [db executeQuery:@"SELECT * FROM name"];//テーブル名を指定
        nameArray = [[NSMutableArray alloc]init];
        while ([rs next]) {
            //ここでデータを展開
            databese = [[DataBese alloc]init];
            databese.name = [rs stringForColumn:@"name"];
            [nameArray addObject:databese];
            
        }
        [rs close]; //テーブルを閉じる
        //NSLog(@"テーブル終了");
        [db close]; //データベースを閉じる
        //NSLog(@"データベース終了");
    }
}


//借りる時のDB処理
-(void)dayDB
{
    FMDatabase* db = [FMDatabase databaseWithPath:self.path];
    NSString*   sql = @"INSERT INTO day (modelid,nameid,day) VALUES (?,?,?)";
    NSString *sql1 = @"UPDATE model SET Rental = (?) WHERE modelName = (?);";
    NSString *str2 = @"1";
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat  = @"yyyy/MM/dd HH:mm:ss";
    NSString *str = [df stringFromDate:[NSDate date]];
    [db open];
    [self nameDB];
    [db executeUpdate:sql,modelid,namestr,str];
    [db executeUpdate:sql1,str2,sctionName];
    [db close];
}

//返却時のDB処理
-(void)returnDB
{
    FMDatabase* db = [FMDatabase databaseWithPath:self.path];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat  = @"yyyy/MM/dd HH:mm:ss";
    NSString *str = [df stringFromDate:[NSDate date]];
    NSString *sql1 = @"UPDATE model SET Rental = (?) WHERE modelId = (?);";
    NSString *sql = @"UPDATE day SET returnDay = (?) WHERE returnDay IS NULL AND modelid = (?);";
    NSString *str2 = @"0";
    [db open];
    [db executeUpdate:sql1,str2,modelid];
    [self nameDB];
    [db executeUpdate:sql,str,modelid];
    [db close]; //データベースを閉じる
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

@end
