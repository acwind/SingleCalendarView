//
//  CalendarView.m
//  CCSinglewCalendarView
//
//  Created by 李文睿 on 5/16/16.
//  Copyright © 2016 feather software. All rights reserved.
//

#import "CalendarView.h"

@implementation CalendarView {
    UILabel *_lblMonth;
    UILabel *_lblDay;
    UIView *_background;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat height = frame.size.height/3.0f;
        
        _background = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, height)];
        _background.backgroundColor = [self colorFromHexCode:@"#3498DB"];
        [self addSubview:_background];
        
        _lblMonth = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, height)];
        _lblMonth.font = [UIFont fontWithName:_lblMonth.font.fontName size:height-2.0f];
//        _lblMonth.text = @"五月";
        _lblMonth.textColor = [UIColor whiteColor];
        _lblMonth.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_lblMonth];
        
        _lblDay = [[UILabel alloc] initWithFrame:CGRectMake(0, height, frame.size.width, height*2.0f)];
        _lblDay.textAlignment = NSTextAlignmentCenter;
        _lblDay.font = [UIFont fontWithName:_lblDay.font.fontName size:height*2];
//        _lblDay.text = @"15";
        [self addSubview:_lblDay];
        
        self.layer.borderColor = [self colorFromHexCode:@"34495E"].CGColor;
        self.layer.borderWidth = 1.0f;
        
    }
    return self;
}

- (void)setDate: (NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM"];
    _lblMonth.text = [formatter stringFromDate:date];
    [formatter setDateFormat:@"d"];
    _lblDay.text = [formatter stringFromDate:date];
}

- (UIColor *) colorFromHexCode:(NSString *)hexString {
    NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if ([cleanString length] == 3) {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    if([cleanString length] == 6) {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }
    
    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
    
    float red = ((baseValue >> 24) & 0xFF)/255.0f;
    float green = ((baseValue >> 16) & 0xFF)/255.0f;
    float blue = ((baseValue >> 8) & 0xFF)/255.0f;
    float alpha = ((baseValue >> 0) & 0xFF)/255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

@end
