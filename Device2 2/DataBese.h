//
//  DataBese.h
//  Device2
//
//  Created by ブレイブ ソフト on 13/08/22.
//  Copyright (c) 2013年 ブレイブ ソフト. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataBese : NSObject
{
    ///////deviceViewController///////
    NSString *deviceId;//キー
    NSString *deviceName;//OS
    NSString *deleteId;
    //////////////////////////////////
    
    ///////modelViewController////////
    NSString *modelId;
    NSString *deviceID;
    NSString *modelName;
    NSString *resolution;
    NSString *version;
    NSString *Rental;
    //////////////////////////////////
    
    ///////lastViewController///////
    NSString *nameid;
    NSString *name;
    NSString *returnDay;
    NSString *DayString;
    NSString *nameID;
    NSString *modelID;
    //////////////////////////////////
    
    NSString *devicemax;
}

///////deviceViewController///////
@property(nonatomic,retain)NSString *deviceId;
@property(nonatomic,retain)NSString *deviceName;
@property(nonatomic,retain)NSString *deleteId;
//////////////////////////////////

///////modelViewController////////
@property(nonatomic,retain)NSString *modelId;
@property(nonatomic,retain)NSString *deviceID;
@property(nonatomic,retain)NSString *modelName;
@property(nonatomic,retain)NSString *resolution;
@property(nonatomic,retain)NSString *version;
@property(nonatomic,retain)NSString *Rental;
//////////////////////////////////

///////lastViewController///////
@property(nonatomic,retain)NSString *nameid;
@property(nonatomic,retain)NSString *name;
@property(nonatomic,retain)NSString *returnDay;
@property(nonatomic,retain)NSString *nameID;
@property(nonatomic,retain)NSString *modelID;
@property(nonatomic,retain)NSString *DayString;
//////////////////////////////////

@property(nonatomic,retain)NSString *devicemav;

@end
