//
//  TaoTuModel.h
//  Project_HaoFeng
//
//  Created by qianfeng001 on 16/1/21.
//  Copyright © 2016年 郝锋. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Info;
@interface TaoTuModel : NSObject


@property (nonatomic, strong) NSArray<Info *> *info;

@property (nonatomic, copy) NSString *rows;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *oldcid;

@property (nonatomic, copy) NSString *isCollection;

@property (nonatomic, copy) NSString *webUrl;


@end
@interface Info : NSObject

@property (nonatomic, copy) NSString *height;

@property (nonatomic, copy) NSString *oldaid;

@property (nonatomic, copy) NSString *webUrl;

@property (nonatomic, copy) NSString *viewsnum;

@property (nonatomic, copy) NSString *width;

@property (nonatomic, copy) NSString *filename;

@property (nonatomic, copy) NSString *likenum;

@property (nonatomic, copy) NSString *isCollection;

@property (nonatomic, copy) NSString *pid;

@end

