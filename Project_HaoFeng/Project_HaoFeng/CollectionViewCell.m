//
//  CollectionViewCell.m
//  瀑布流自己的
//
//  Created by dllo on 15/10/28.
//  Copyright © 2015年 zhaoqingwen. All rights reserved.
//

#import "CollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "Model.h"

@implementation CollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _picImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:_picImageView];
        _button = [[UIButton alloc] init];
        [_picImageView addSubview:_button];
        
}
    return self;
}

-(void)setModel:(Model *)model
{
    _model = model;

    [_picImageView sd_setImageWithURL:[NSURL URLWithString:_model.picture] placeholderImage:[UIImage imageNamed:@"1.png"]];
    
}
//layoutAttributes = Itme
-(void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    _picImageView.frame = CGRectMake(0, 0, layoutAttributes.frame.size.width, layoutAttributes.frame.size.height );
    _button.frame = CGRectMake(0, 0, layoutAttributes.frame.size.width, layoutAttributes.frame.size.height );
      
}

@end
