//
//  LWStarView.h
//  LWStarView
//
//  Created by 李伟 on 2017/6/1.
//  Copyright © 2017年 李伟. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LWMarkType) {
    LWMarkTypeInteger,   //整数
    LWMarkTypeDecimal,   //小数
};

@interface LWStarView : UIView
/** 类型 */
@property (nonatomic, assign) LWMarkType markType;
/** 星数 默认5颗星*/
@property (nonatomic, assign) NSUInteger totalCount;
/** 总分数 默认10分*/
@property (nonatomic, assign) CGFloat totalScore;
/** 是否可以滑动 默认可以滑动*/
@property (nonatomic, assign) BOOL enable;
/** 小数时使用 百分比[0,1] 默认1*/
@property (nonatomic, assign) CGFloat currentPercent;
/** 整数时使用 [1,totalCount]*/
@property (nonatomic, assign) NSUInteger currentIndex;
/** 填充图片 */
@property (nonatomic, strong) UIImage *upImage;
/** 未填充图片 */
@property (nonatomic, strong) UIImage *downImage;
/** 结果回调 */
@property (nonatomic, copy) void(^markComplete)(CGFloat score); //回传打分结果

@end
