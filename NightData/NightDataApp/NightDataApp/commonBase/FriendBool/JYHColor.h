//
//  JYHColor.h
//  CongestionOfGod
//
//  Created by 黄 梦炜 on 15/1/12.
//  Copyright (c) 2015年 黄 梦炜. All rights reserved.
//

#ifndef CongestionOfGod_JYHColor_h
#define CongestionOfGod_JYHColor_h


#endif


/*!
 @discussion NavBar背景色
 */

#define Color_black 0x1e0624

/*!
 @method getColorP(int intColor)
 @abstract 得到RGB颜色值中的R值
 @discussion 得到RGB颜色值中的R值。
 @param intColor 颜色值
 @result P / 255.0
 */
static inline float getColorP(int intColor){
    return 1.0 - ((intColor & 0xFF000000)>> 0x18) / 255.0f;
}

/*!
 @method getColorR(int intColor)
 @abstract 得到RGB颜色值中的R值
 @discussion 得到RGB颜色值中的R值。
 @param intColor 颜色值
 @result R / 255.0
 */
static inline float getColorR(int intColor){
    return ((intColor & 0x00FF0000) >> 0x10 ) / 255.0f;
}

/*!
 @method getColorG(int intColor)
 @abstract 得到RGB颜色值中的R值
 @discussion 得到RGB颜色值中的R值。
 @param intColor 颜色值
 @result G / 255.0
 */
static inline float getColorG(int intColor) {
    return ((intColor & 0x0000FF00) >> 0x08 ) / 255.0f;
}

/*!
 @method getColorB(int intColor)
 @abstract 得到RGB颜色值中的R值
 @discussion 得到RGB颜色值中的R值。
 @param intColor 颜色值
 @result B / 255.0
 */
static inline float getColorB(int intColor) {
    return (intColor & 0x000000FF) / 255.0f;
}


/*!
 @method getColorP(int intColor)
 @abstract 得到RGB颜色值中的R值
 @discussion 得到RGB颜色值中的R值。
 @param intColor 颜色值
 @result P / 255.0
 */
static inline UIColor* getUIColor(int intColor){
    
    return [UIColor colorWithRed:getColorR(intColor) green:getColorG(intColor) blue:getColorB(intColor) alpha:getColorP(intColor)];
}
