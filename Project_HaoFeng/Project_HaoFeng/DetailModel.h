//
//  DetailModel.h
//  Project_HaoFeng
//
//  Created by qianfeng001 on 16/1/20.
//  Copyright © 2016年 郝锋. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Picture_Storage;
@interface DetailModel : NSObject


@property (nonatomic, copy) NSString *picture_id;

@property (nonatomic, assign) NSInteger Id;

@property (nonatomic, assign) NSInteger case_id;

@property (nonatomic, assign) NSInteger space_type;

@property (nonatomic, copy) NSString *picture_url;

@property (nonatomic, copy) NSString *space_type_title;

@property (nonatomic, copy) NSString *Description;

@property (nonatomic, strong) Picture_Storage *picture_storage;



@end
@interface Picture_Storage : NSObject

@property (nonatomic, assign) NSInteger height;

@property (nonatomic, copy) NSString *Hash;

@property (nonatomic, copy) NSString *format;

@property (nonatomic, copy) NSString *mime;

@property (nonatomic, assign) NSInteger width;

@property (nonatomic, assign) NSInteger size;

@property (nonatomic, copy) NSString *created_at;

@property (nonatomic, assign) NSInteger seconds;

@property (nonatomic, copy) NSString *path;

@property (nonatomic, copy) NSString *updated_at;


@end
