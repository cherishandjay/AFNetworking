//
//  HKtextfield.m
//  循环引用
//
//  Created by Jeremy on 2020/1/6.
//  Copyright © 2020 JeremyLu. All rights reserved.
//

#import "HKtextfield.h"

@implementation HKtextfield

 
- (CGRect)borderRectForBounds:(CGRect)bounds
{
    return bounds;
}

- (CGRect)textRectForBounds:(CGRect)bounds
{
    bounds.origin.y = 10;
    bounds.size.height = 64;
    return bounds;

}

- (CGRect)placeholderRectForBounds:(CGRect)bounds
{
    return bounds;

}

@end
