//
//  DeviceAddViewController.m
//  Device2
//
//  Created by ブレイブ ソフト on 13/08/26.
//  Copyright (c) 2013年 ブレイブ ソフト. All rights reserved.
//
#import "DeviceAddViewController.h"

@interface DeviceAddViewController ()

@end

@implementation DeviceAddViewController

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
    deviceText.placeholder = @"カテゴリー名";
    deviceText.keyboardType = UIKeyboardTypeAlphabet;
    deviceText.returnKeyType = UIReturnKeyDone;
    [deviceText becomeFirstResponder];
    [self.view addSubview:deviceText];
    NSLog(@"読んでるよー");
    
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
        NSString *str = @"INSERT INTO main (deviceName) VALUES (?)";
        FMDatabase* db = [FMDatabase databaseWithPath:self.path];
        [db open];
        [db executeUpdate:str,string1];
        [db close]; //データベースを閉じる
        [self.navigationController popViewControllerAnimated:YES];
        NSLog(@"カテゴリー登録完了");
    }
    return YES;
}




@end
