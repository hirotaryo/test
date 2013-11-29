//
//  TVSCustomCell.h
//  Device2
//
//  Created by ブレイブ ソフト on 13/08/22.
//  Copyright (c) 2013年 ブレイブ ソフト. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TVSCustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;//機種名
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;//バージョン
@property (weak, nonatomic) IBOutlet UILabel *resolutionLabel;//解析度

@end
