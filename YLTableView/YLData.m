//
//  ContentModal.m
//  YLTableView
//
//  Created by 鲁玉兰 on 16/6/20.
//  Copyright © 2016年 luyulan. All rights reserved.
//

#import "YLData.h"

@implementation YLData
{
    CGFloat _cellHeight;
}

+ (instancetype)messageWithDict:(NSDictionary *)dict
{
    YLData *message = [[YLData alloc] init];
    [message setValuesForKeysWithDictionary:dict];
    return  message;
}


#define CELL_MARGIN 10.0f
#define CELL_FONT 13.0f
#define CELL_FIXED_HEIGHT (CELL_MARGIN * 2 + 30)
- (CGFloat)cellHeight
{
    if (!_cellHeight) {
        CGFloat width = [[UIScreen mainScreen] bounds].size.width;
        CGFloat height = [self.content boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:CELL_FONT]} context:nil].size.height;
        _cellHeight = height + CELL_FIXED_HEIGHT + CELL_MARGIN;
        
        if (self.contentImageName.length) {
            UIImage *image = [UIImage imageNamed:self.contentImageName];
            CGFloat imageH = image.size.height;
            CGFloat imageW = image.size.width;
            
            self.contentImageRect = CGRectMake(CELL_MARGIN, _cellHeight, imageW, imageH);
            
            _cellHeight += imageH + CELL_MARGIN;
        }
        
    }
    return _cellHeight;
}

@end
