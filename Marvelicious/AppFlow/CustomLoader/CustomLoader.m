//
//  CustomLoader.m
//  Marvelicious
//
//  Created by ANUJ NIGAM on 13/06/18.
//  Copyright © 2018 ANUJ NIGAM. All rights reserved.
//

#import "CustomLoader.h"

#define duration 0.09

@interface CustomLoader() {
    
    NSMutableArray *arrayViews;
    BOOL isAnimating;
    int currentColorIndex , currentViewIndex;
}
@end

@implementation CustomLoader


+(instancetype)sharedLoader
{
    static CustomLoader *loader = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        loader = [[NSBundle mainBundle] loadNibNamed:@"CustomLoader" owner:nil options:nil].lastObject;
    });
    return loader;
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}
-(void)setup
{
    isAnimating = NO;
    currentViewIndex = 0;
    currentColorIndex = 0;
    arrayViews = [NSMutableArray arrayWithCapacity:4];
}
-(void)beginAnimationWithText:(NSString*)text OnView:(UIView*)view
{
    [arrayViews addObject:[self viewWithTag:1]];
    [arrayViews addObject:[self viewWithTag:2]];
    [arrayViews addObject:[self viewWithTag:3]];
    [arrayViews addObject:[self viewWithTag:4]];
    UILabel *label = (UILabel*)[self viewWithTag:5];
    label.text = text;
    self.frame = view.bounds;
    [view addSubview:self];
    isAnimating = YES;
    [self startAnimation];
}
-(void)startAnimation
{
    self.alpha = 1;
    isAnimating = YES;
    [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        if (self->arrayViews.count > 0) {
            UIView *view = self->arrayViews[self->currentViewIndex];
            [view setTransform:CGAffineTransformMakeScale(1.3, 1.3)];
            [view setBackgroundColor:[self getNextColor]];
        }
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.04 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
            if (self->arrayViews.count > 0) {
                UIView *view = self->arrayViews[self->currentViewIndex];
                [view setTransform:CGAffineTransformIdentity];
                [view setBackgroundColor:[self getDefaultColor]];
            }
            
            
        } completion:^(BOOL finished) {
            ++self->currentViewIndex;
            
            if (self->currentViewIndex< self->arrayViews.count) {
                [self startAnimation];
            }
            else
            {
                self->currentViewIndex = 0;
                [self startNextLevelAnimation];
            }
        }];
    }];
}
-(void)changeText:(NSString*)text
{
    UILabel *label = (UILabel*)[self viewWithTag:78];
    label.text = text;
}
-(void)endAnimation
{
    isAnimating = NO;
    currentViewIndex = 0;
    for (UIView *view in arrayViews) {
        view.backgroundColor = [self getDefaultColor];
        view.transform = CGAffineTransformIdentity;
    }
    currentColorIndex = 0;
    [arrayViews removeAllObjects];
    [self removeFromSuperview];
}
-(void)startNextLevelAnimation
{
    [UIView animateWithDuration:0.28 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        for (UIView *view in self->arrayViews) {
            
            view.transform = CGAffineTransformMakeScale(1.3, 1.3);
        }
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.18 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
            for (UIView *view in self->arrayViews) {
                
                view.transform = CGAffineTransformIdentity;
            }
            
        } completion:^(BOOL finished) {
            
            if (self->isAnimating) {
                self->currentViewIndex = 0;
                [self startAnimation];
            }
            else
            {
                self->isAnimating = NO;
                self->currentViewIndex = 0;
                for (UIView *view in self->arrayViews) {
                    
                    view.backgroundColor = [self getDefaultColor];
                    view.transform = CGAffineTransformIdentity;
                }
            }
        }];
        
    }];
}
-(UIColor*)getDefaultColor
{
    return [UIColor colorWithRed:210.0/255.0 green:219.0/255.0 blue:227.0/255.0 alpha:1.0];
}
-(UIColor*)getNextColor
{
    if (currentColorIndex == arrayViews.count) {
        currentColorIndex = 0;
    }
    UIColor *color = [self getRandomColor];
    currentColorIndex++;
    return color;
}

-(UIColor*)getRandomColor
{
    
    return [UIColor whiteColor];
    //    CGFloat redLevel    = rand() / (float) RAND_MAX;
    //    CGFloat greenLevel  = rand() / (float) RAND_MAX;
    //    CGFloat blueLevel   = rand() / (float) RAND_MAX;
    //
    //    return  [UIColor colorWithRed: redLevel
    //                            green: greenLevel
    //                             blue: blueLevel
    //                            alpha: 1.0];
}

@end
