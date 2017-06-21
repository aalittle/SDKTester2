//
//  ColorHelper.m
//  SDKTest2
//
//  Created by Andrew Little on 2017-06-18.
//  Copyright © 2017 Andrew Little. All rights reserved.
//

#import "ColorHelper.h"

@implementation ColorHelper

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert
{
  NSString *noHashString = [stringToConvert stringByReplacingOccurrencesOfString:@"#" withString:@""]; // remove the #
  NSScanner *scanner = [NSScanner scannerWithString:noHashString];
  [scanner setCharactersToBeSkipped:[NSCharacterSet symbolCharacterSet]]; // remove + and $
  
  unsigned hex;
  if (![scanner scanHexInt:&hex]) return nil;
  int r = (hex >> 16) & 0xFF;
  int g = (hex >> 8) & 0xFF;
  int b = (hex) & 0xFF;
  
  return [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:1.0f];
}

@end
