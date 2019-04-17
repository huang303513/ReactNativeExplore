//
//  RNSConstant.h
//  Example
//
//  Created by huangchengdu on 2019/4/16.
//  Copyright © 2019 Facebook. All rights reserved.
//

#ifndef RNSConstant_h
#define RNSConstant_h

#define RGBColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define Color(r,g,b) RGBColor(r,g,b,1)

#define RGBColorHex(colorInHex) [UIColor colorWithRed:((float) ((colorInHex & 0xFF0000) >> 16)) / 0xFF green:((float) ((colorInHex & 0xFF00)   >> 8))  / 0xFF blue:((float)  (colorInHex & 0xFF)) / 0xFF alpha:1.0]

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

#endif /* RNSConstant_h */
