//
//  AnLiModel.h
//  Project_HaoFeng
//
//  Created by qianfeng001 on 16/1/20.
//  Copyright © 2016年 郝锋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnLiModel : NSObject

@property (nonatomic, assign) NSInteger Id;

@property (nonatomic, assign) NSInteger design_style;

@property (nonatomic, copy) NSString *design_style_title;

@property (nonatomic, copy) NSString *picture;

@property (nonatomic, copy) NSString *design_name;

@property (nonatomic, copy) NSString *rooms_title;

@property (nonatomic, copy) NSString *activity_title;

@property (nonatomic, assign) NSInteger activity_id;

@property (nonatomic, copy) NSString *area;

@property (nonatomic, assign) NSInteger reserves;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *orig_price;

@property (nonatomic, assign) NSInteger quota;

@property (nonatomic, assign) NSInteger designer_id;

@property (nonatomic, assign) NSInteger rooms;


@end
