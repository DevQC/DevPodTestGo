//
//  CWStarRateView.m
//  StarRateDemo
//
//  Created by WANGCHAO on 14/11/4.
//  Copyright (c) 2014年 wangchao. All rights reserved.
//

#import "CWStarRateView.h"

#define FOREGROUND_STAR_IMAGE_NAME @"designer_star_sel_img"
#define BACKGROUND_STAR_IMAGE_NAME @"designer_star_nor_img"
#define DEFALUT_STAR_NUMBER 5
#define ANIMATION_TIME_INTERVAL 0.2

@interface CWStarRateView ()

@property (nonatomic, strong) UIView *foregroundStarView;
@property (nonatomic, strong) UIView *backgroundStarView;

@property (nonatomic, assign) NSInteger numberOfStars;
@property (nonatomic, strong) NSString *foregroundStarImageName;
@property (nonatomic, strong) NSString *backgroundStarImageName;

@end

@implementation CWStarRateView

#pragma mark - Init Methods
- (instancetype)init {
    NSAssert(NO, @"You should never call this method in this class. Use initWithFrame: instead!");
    return nil;
}

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame numberOfStars:DEFALUT_STAR_NUMBER selStarImageName:FOREGROUND_STAR_IMAGE_NAME norStarImageName:BACKGROUND_STAR_IMAGE_NAME];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
             selStarImageName:(NSString *)selStarImageName
             norStarImageName:(NSString *)norStarImageName{
    if (self = [super initWithCoder:aDecoder]) {
        _numberOfStars = DEFALUT_STAR_NUMBER;
        _foregroundStarImageName = selStarImageName;
        _backgroundStarImageName = norStarImageName;
        [self buildDataAndUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
                numberOfStars:(NSInteger)numberOfStars
             selStarImageName:(NSString *)selStarImageName
             norStarImageName:(NSString *)norStarImageName{
    if (self = [super initWithFrame:frame]) {
        _numberOfStars = numberOfStars;
        _foregroundStarImageName = selStarImageName;
        _backgroundStarImageName = norStarImageName;
        [self buildDataAndUI];
    }
    return self;
}

#pragma mark - Private Methods

- (void)buildDataAndUI{
    _scorePercent = 1;//默认为1
    _hasAnimation = NO;//默认为NO
    _allowIncompleteStar = NO;//默认为NO

    self.foregroundStarView = [self createStarViewWithImage:_foregroundStarImageName];
    self.backgroundStarView = [self createStarViewWithImage:_backgroundStarImageName];
    
    [self addSubview:self.backgroundStarView];
    [self addSubview:self.foregroundStarView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTapRateView:)];
    tapGesture.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tapGesture];
}

- (void)userTapRateView:(UITapGestureRecognizer *)gesture {
    CGPoint tapPoint = [gesture locationInView:self];
    CGFloat offset = tapPoint.x;
    CGFloat realStarScore = offset / (self.bounds.size.width / self.numberOfStars);
    CGFloat starScore = self.allowIncompleteStar ? realStarScore : ceilf(realStarScore);
    self.scorePercent = starScore / self.numberOfStars;
}

- (UIView *)createStarViewWithImage:(NSString *)imageName {
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    view.clipsToBounds = YES;
    view.backgroundColor = [UIColor clearColor];
    for (NSInteger i = 0; i < self.numberOfStars; i ++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        imageView.frame = CGRectMake(i * self.bounds.size.width / self.numberOfStars, 0, self.bounds.size.width / self.numberOfStars, self.bounds.size.height);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview:imageView];
    }
    return view;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    __weak CWStarRateView *weakSelf = self;
    CGFloat animationTimeInterval = self.hasAnimation ? ANIMATION_TIME_INTERVAL : 0;
    [UIView animateWithDuration:animationTimeInterval animations:^{
       weakSelf.foregroundStarView.frame = CGRectMake(0, 0, weakSelf.bounds.size.width * weakSelf.scorePercent, weakSelf.bounds.size.height);
    }];
}

#pragma mark - Get and Set Methods

- (void)setScorePercent:(CGFloat)scroePercent {
    if (_scorePercent == scroePercent) {
        return;
    }
    
    if (scroePercent < 0) {
        _scorePercent = 0;
    } else if (scroePercent > 1) {
        _scorePercent = 1;
    } else {
        _scorePercent = scroePercent;
    }
    
    if ([self.delegate respondsToSelector:@selector(starRateView:scroePercentDidChange:)]) {
        [self.delegate starRateView:self scroePercentDidChange:scroePercent];
    }
    
    [self setNeedsLayout];
}

@end
