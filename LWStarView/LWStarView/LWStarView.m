//
//  LWStarView.m
//  LWStarView
//
//  Created by 李伟 on 2017/6/1.
//  Copyright © 2017年 李伟. All rights reserved.
//

#import "LWStarView.h"
static CGFloat LWDefaultTotalScore = 10.;
static NSUInteger LWDefaultCount = 5;

@implementation LWStarView
{
    UIView *_upView;
    CGFloat _starWidth;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:[self setupStarViewWithImage:self.downImage]];
        _upView = [self setupStarViewWithImage:self.upImage];
        [self addSubview:_upView];
        self.enable = YES;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self addSubview:[self setupStarViewWithImage:self.downImage]];
        _upView = [self setupStarViewWithImage:self.upImage];
        [self addSubview:_upView];
        self.enable = YES;
    }
    return self;
}

- (UIView *)setupStarViewWithImage:(UIImage *)image {
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    view.layer.masksToBounds = YES;
    [view setBackgroundColor:[UIColor whiteColor]];
    _starWidth = self.bounds.size.width / self.totalCount;
    for (int i = 0; i < self.totalCount; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(_starWidth * i, 0, _starWidth, self.frame.size.height);
        [view addSubview:imageView];
    }
    return view;
}

#pragma mark - touch

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGFloat xPoint = [[touches anyObject] locationInView:self].x;
    if (self.enable) {
        switch (self.markType) {
            case LWMarkTypeInteger:
            {
                if(self.currentIndex == 1) {
                    self.currentIndex = roundf(xPoint / _starWidth);
                } else {
                    self.currentIndex = ceilf(xPoint / _starWidth);
                }
            }
                break;
            case LWMarkTypeDecimal:
            {
                self.currentPercent = xPoint / self.bounds.size.width;
            }
                break;
                
            default:
                break;
        }
        
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGFloat xPoint = [[touches anyObject] locationInView:self].x;
    if (self.enable) {
        switch (self.markType) {
            case LWMarkTypeDecimal:
            {
                if (xPoint < 0) {
                    xPoint = 0;
                } else if (xPoint > self.frame.size.width) {
                    xPoint = self.frame.size.width;
                }
                self.currentPercent = xPoint / self.bounds.size.width;
                [self changeStarValue];
            }
                break;
            case LWMarkTypeInteger:
            {
                if(self.currentIndex == 1) {
                    self.currentIndex = roundf(xPoint / _starWidth);
                } else {
                    self.currentIndex = ceilf(xPoint / _starWidth);
                }
                [self changeStarValue];
            }
                break;
                
            default:
                break;
        }
        
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.enable) {
        switch (self.markType) {
            case LWMarkTypeInteger:
            {
                if (self.markComplete) {
                    if (self.currentIndex > self.totalCount) {
                        self.currentIndex = self.totalCount;
                    }
                    self.currentIndex = self.currentIndex > self.totalCount ? self.totalCount : self.currentIndex;
                    self.markComplete(self.currentIndex * self.totalScore / self.totalCount);
                }
                [self changeStarValue];
                
            }
                break;
            case LWMarkTypeDecimal:
            {
                if (self.markComplete) {
                    self.currentPercent = self.currentPercent > 1. ? 1. : self.currentPercent;
                    self.currentPercent = self.currentPercent < 0. ? 0. : self.currentPercent;
                    self.markComplete(self.currentPercent * self.totalScore);
                }
                [self changeStarValue];
            }
                break;
                
            default:
                break;
        }
        
    }
}

- (void)changeStarValue {
    switch (self.markType) {
        case LWMarkTypeDecimal:
        {
            _upView.frame = CGRectMake(0, 0, self.bounds.size.width * self.currentPercent, self.frame.size.height);
            [self setNeedsDisplay];
        }
            break;
        case LWMarkTypeInteger:
        {
            _upView.frame = CGRectMake(0, 0, self.currentIndex * _starWidth, self.frame.size.height);
            [self setNeedsDisplay];
        }
            break;
            
        default:
            break;
    }
    
}

- (NSUInteger)totalCount {
    if (_totalCount <= 0) {
        _totalCount = LWDefaultCount;
    }
    return _totalCount;
}
- (CGFloat)totalScore {
    if (_totalScore <= 0.001) {
        _totalScore = LWDefaultTotalScore;
    }
    return _totalScore;
}

- (UIImage *)upImage {
    if (!_upImage) {
        _upImage = [UIImage imageNamed:@"up"];
    }
    return _upImage;
}

- (UIImage *)downImage {
    if (!_downImage) {
        _downImage = [UIImage imageNamed:@"down"];
    }
    return _downImage;
}

- (void)setCurrentPercent:(CGFloat)currentPercent {
    _currentPercent = currentPercent;
    [self changeStarValue];
}

@end
