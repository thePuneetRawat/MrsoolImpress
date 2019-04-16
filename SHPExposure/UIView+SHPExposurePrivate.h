//
//  UIView+SHPExposurePrivate.h
//  SHPExposure
//
//  Created by Wang Ya on 24/10/18.
//  Copyright © 2018 Shopee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+SHPExposure.h"
#import <Aspects/Aspects.h>

@interface UIView (SHPExposurePrivate)

@property (nonatomic, assign) BOOL shpex_isExposured;
@property (nonatomic, copy) NSDate *shpex_lastShowedDate;

@property (nonatomic, copy) SHPExposureBlock shpex_exposureBlock;
@property (nonatomic, assign) NSTimeInterval shpex_delay;
@property (nonatomic, assign) CGFloat shpex_minAreaRatio;
@property (atomic, strong) id<AspectToken> shpex_token;
@end