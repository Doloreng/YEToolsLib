//
//  HToolsLibHeader.h
//  Pods
//
//  Created by Eason on 2017/4/7.
//
//

#ifndef HToolsLibHeader_h
#define HToolsLibHeader_h
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);

//颜色
#define ColorWithRGBA(int_r,int_g,int_b,int_a)  \
[UIColor colorWithRed:(int_r)/255.0 green:(int_g)/255.0 blue:(int_b)/255.0 alpha:(int_a)/255.0]

//通过数字初始化颜色
#define ColorWithNumberRGB(_hex)  \
ColorWithRGBA(((_hex)>>16)&0xFF,((_hex)>>8)&0xFF,(_hex)&0xFF,255)

#define ColorWithNumberRGBA(_hex) \
ColorWithRGBA(((_hex)>>24)&0xFF,((_hex)>>16)&0xFF,((_hex)>>8)&0xFF,(_hex)&0xFF)

#endif /* HToolsLibHeader_h */
