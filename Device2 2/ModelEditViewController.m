//
//  ModelEditViewController.m
//  Device2
//
//  Created by ブレイブ ソフト on 13/08/29.
//  Copyright (c) 2013年 ブレイブ ソフト. All rights reserved.
//

#import "ModelEditViewController.h"

@interface ModelEditViewController ()

@end

@implementation ModelEditViewController

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
    modelNameTextField = [[UITextField alloc]init];
    modelNameTextField.frame = CGRectMake(10, 50, 300 ,40);
    modelNameTextField.borderStyle = UITextBorderStyleRoundedRect;
    modelNameTextField.delegate = self;
    modelNameTextField.text = self.modelName;
    modelNameTextField.placeholder = @"端末名";
    modelNameTextField.returnKeyType = UIReturnKeyDone;
    [modelNameTextField becomeFirstResponder];
    [self.view addSubview:modelNameTextField];
    
    resolutionTextFiled = [[UITextField alloc]init];
    resolutionTextFiled.frame = CGRectMake(10, 100, 300, 40);
    resolutionTextFiled.borderStyle = UITextBorderStyleRoundedRect;
    resolutionTextFiled.delegate = self;
    resolutionTextFiled.text = self.resolution;
    resolutionTextFiled.returnKeyType = UIReturnKeyDone;
    resolutionTextFiled.placeholder = @"解像度";
    [self.view addSubview:resolutionTextFiled];
    
    versionTextField = [[UITextField alloc]init];
    versionTextField.frame = CGRectMake(10, 150, 300, 40);
    versionTextField.borderStyle = UITextBorderStyleRoundedRect;
    versionTextField.delegate = self;
    versionTextField.text = self.version;
    versionTextField.returnKeyType = UIReturnKeyDone;
    versionTextField.placeholder = @"バージョン";
    [self.view addSubview:versionTextField];

}

- (BOOL)textFieldShouldReturn:(UITextField *)_textField {
    NSString *null = @"";
    //modelNameTextFieldに入力された文字列の最初と最後にスペースがあった場合スペースを削除
    modelNameTextField.text = [modelNameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSLog(@"%@",modelNameTextField.text);//スペース削除確認
    //esolutionTextFiledとversionTextFieldに文字列が入っていてmodelNameTextFieldに文字列が入ってないと意味がないので
    //modelNameTextFieldがnullか調べて次の処理を決める
    if([modelNameTextField.text isEqualToString:null]){
        NSLog(@"入ってないよー");
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        FMDatabase* db = [FMDatabase databaseWithPath:self.path];
        NSString *sql =@"UPDATE model SET modelName = (?),Resolution = (?),Version = (?) WHERE modelName = (?)";
        [db open];
        [db executeUpdate:sql,modelNameTextField.text,resolutionTextFiled.text,versionTextField.text,self.modelName];
        [db close]; //データベースを閉じ
        [self.navigationController popViewControllerAnimated:YES];
    }
    return YES;
}


@end
