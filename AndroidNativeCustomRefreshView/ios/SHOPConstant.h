//
//  SHOPConstant.h
//  AndroidNativeCustomRefreshView
//
//  Created by huangchengdu on 2019/3/7.
//  Copyright © 2019 Facebook. All rights reserved.
//

#ifndef SHOPConstant_h
#define SHOPConstant_h


#define RGBColor(redValue, greenValue, blueValue, alphaValue)   [UIColor colorWithRed:FFCOLOR2FLOAT(redValue) green:FFCOLOR2FLOAT(greenValue) blue:FFCOLOR2FLOAT(blueValue) alpha:alphaValue]

#define Color(r,g,b) RGBColor(r,g,b,1)

#define RGBColorHex(colorInHex) [UIColor colorWithRed:((float) ((colorInHex & 0xFF0000) >> 16)) / 0xFF green:((float) ((colorInHex & 0xFF00)   >> 8))  / 0xFF blue:((float)  (colorInHex & 0xFF)) / 0xFF alpha:1.0]

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

#endif /* SHOPConstant_h */
