//
//  CustomLoader.h
//  Marvelicious
//
//  Created by ANUJ NIGAM on 13/06/18.
//  Copyright © 2018 ANUJ NIGAM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomLoader : UIView

+(instancetype)sharedLoader;
-(void)beginAnimationWithText:(NSString*)text OnView:(UIView*)view;
-(void)changeText:(NSString*)text;
-(void)endAnimation;
@end
