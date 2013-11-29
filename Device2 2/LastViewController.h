//
//  LastViewController.h
//  Device2
//
//  Created by ブレイブ ソフト on 13/08/22.
//  Copyright (c) 2013年 ブレイブ ソフト. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "FMDatabase.h"
#import "DataBese.h"
#import "TVSCustomCell.h"

@interface LastViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIActionSheetDelegate>
{
    FMResultSet *rs;
    FMResultSet *subrs;
    NSMutableArray *nameArray;//名前を入れる配列
    
    NSString *sctionName;//セクション名（modelNameをModelViewからもらう）
    NSString *modelid;//modelidデータベースを更新するときに使う
    
    UILabel *checkLabel;//一番にある貸出中か貸出可のラベル
    UIButton *ChangeBtn;//借りるor返却ボタン
    UIButton *btn1;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

////////modelViewから値をもらうための変数/////
@property(nonatomic,strong) NSString *modelid;
@property(nonatomic,strong) NSString *sctionName;
@property(nonatomic,strong) NSString *rental;
@property(nonatomic,strong) NSString *path;
/////////////////////////////////////////

@end
