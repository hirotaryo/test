//
//  DeviceEditViewController.m
//  Device2
//
//  Created by ブレイブ ソフト on 13/08/29.
//  Copyright (c) 2013年 ブレイブ ソフト. All rights reserved.
//

#import "DeviceEditViewController.h"

@interface DeviceEditViewController ()

@end

@implementation DeviceEditViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    deviceText = [[UITextField alloc]init];
    deviceText.frame = CGRectMake(10, 100, 300 ,40);
    deviceText.borderStyle = UITextBorderStyleRoundedRect;
    deviceText.delegate = self;
    deviceText.text = _deviceName;
    deviceText.placeholder = @"カテゴリー名";
    deviceText.keyboardType = UIKeyboardTypeAlphabet;
    deviceText.returnKeyType = UIReturnKeyDone;
    [deviceText becomeFirstResponder];
    [self.view addSubview:deviceText];
}

- (BOOL)textFieldShouldReturn:(UITextField *)_textField {
    NSString *null = @"";
    ///カテゴリーなのでスペースはあり得ない？からTextFieldに入力されたスペースをすべて削除
    NSString *string1 = [deviceText.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"%@",string1);//スペース削除確認
    if([string1 isEqualToString:null]){//string1に何もない場合何もしない
        NSLog(@"何も入ってないよ");
        [self.navigationController popViewControllerAnimated:YES];
    }else{//string1に文字列があった場合はカテゴリーに追加
        NSString *str = @"UPDATE main SET deviceName = (?) WHERE deviceName = (?);";
        FMDatabase* db = [FMDatabase databaseWithPath:self.path];
        [db open];
        [db executeUpdate:str,string1,_deviceName];
        [db close]; //データベースを閉じる
        [self.navigationController popViewControllerAnimated:YES];
        NSLog(@"カテゴリー登録完了");
    }
    return YES;
}

@end
