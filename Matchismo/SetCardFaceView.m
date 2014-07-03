//
//  SetCardFaceView.m
//  Matchismo
//
//  Created by Qing Yang on 19/04/2014.
//  Copyright (c) 2014 KikTech. All rights reserved.
//

#import "SetCardFaceView.h"
#import <QuartzCore/QuartzCore.h>
#import "SetCard.h"
@implementation SetCardFaceView

- (void)setCard:(SetCard *)card
{
    _card = card;
    [self setNeedsDisplay];
}

- (void)setHighlighted:(BOOL)highlighted
{
    _highlighted = highlighted;
    [self setNeedsDisplay];
}

#define ratio_diamond 0.5

#pragma mark - Drawing

#define CORNER_FONT_STANDARD_HEIGHT 180.0
#define CORNER_RADIUS 12.0
#define degreeToRadius(x) ((x) * M_PI / 180.0)

- (CGFloat)cornerScaleFactor { return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT; }
- (CGFloat)cornerRadius { return CORNER_RADIUS * [self cornerScaleFactor]; }
- (CGFloat)cornerOffset { return [self cornerRadius] / 3.0; }

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code

    UIBezierPath * aPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];
    [aPath addClip];
    if (self.card.isSelected) {
        [[UIColor grayColor] setFill];
    }
    else
    {
        [[UIColor whiteColor] setFill];
    }
    UIRectFill(self.bounds);
    
    if (self.highlighted) {
        [[UIColor redColor] setStroke];
        aPath.lineWidth = 10;
        _highlighted = NO;
    }
    else
    {
        [[UIColor blackColor] setStroke];
    }
    [aPath stroke];
    
    if (self.card) {
        CGFloat width = self.bounds.size.width * 2.0 / 3.0;
        CGFloat height = width * ratio_diamond;
        
        CGPoint centerPoint = CGPointMake(rect.size.width / 2.0, rect.size.height / 2.0);
        UIBezierPath * path = [self bezierPath:centerPoint height:height width:width];
        [path closePath];
        [path addClip];
        [self fillPattern:centerPoint ];
        [[self getForgroundColor] setStroke];
        [path stroke];
    }
   
    
}



- (UIBezierPath * )bezierPath: (CGPoint) centerPoint height: (CGFloat) height width: (CGFloat) width
{
    UIBezierPath * path = [[UIBezierPath alloc] init];
    switch (self.card.number) {
        case  1:
            [self createPath:path Center:centerPoint height:height width:width];
            break;
        case  2:
        {
            CGPoint firstCenterPoint = CGPointMake(centerPoint.x, centerPoint.y - height * 2.0 / 3.0);
            CGPoint secondCenterPoint = CGPointMake(centerPoint.x, centerPoint.y + height * 2.0 / 3.0);
            [self createPath:path Center:firstCenterPoint height:height width:width];
            [self createPath:path Center:secondCenterPoint height:height width:width];
            break;
        }
        case  3:
        {
            CGPoint firstCenterPoint = CGPointMake(centerPoint.x, centerPoint.y - height * 5.0 / 4.0);
            CGPoint secondCenterPoint = CGPointMake(centerPoint.x, centerPoint.y + height * 5.0 / 4.0);
            [self createPath:path Center:firstCenterPoint height:height width:width];
            [self createPath:path Center:secondCenterPoint height:height width:width];
            [self createPath:path Center:centerPoint height:height width:width];
            break;
        }
        default:
            break;
    }
    return path;
}

- (void)createPath: (UIBezierPath *)path Center:(CGPoint) centerPoint height: (CGFloat) height width: (CGFloat) width
{
    switch (self.card.symbol) {
        case 1:
            [self pathForDiamond:path Center:centerPoint height:height width:width];
            break;
        case 2:
            [self pathForSquiggle:path Center:centerPoint height:height width:width];
            break;
        case 3:
            [self pathForOval:path Center:centerPoint height:height width:width];
            break;
        default:
            break;
    }
    
}

- (void)pathForDiamond: (UIBezierPath *)path Center:(CGPoint) centerPoint height: (CGFloat) height width: (CGFloat) width
{
    [path moveToPoint:CGPointMake(centerPoint.x, centerPoint.y - height / 2.0)];
    [path addLineToPoint:CGPointMake(centerPoint.x + width / 2.0, centerPoint.y)];
    [path addLineToPoint:CGPointMake(centerPoint.x, centerPoint.y + height / 2.0)];
    [path addLineToPoint:CGPointMake(centerPoint.x - width / 2.0, centerPoint.y)];
    [path addLineToPoint:CGPointMake(centerPoint.x, centerPoint.y - height / 2.0)];
}

- (void)pathForSquiggle: (UIBezierPath *)path Center:(CGPoint) centerPoint height: (CGFloat) height width: (CGFloat) width
{
    [path moveToPoint:CGPointMake(centerPoint.x - width / 2.0, centerPoint.y + height / 2.0)];
    [path addCurveToPoint:CGPointMake(centerPoint.x + width / 2.0, centerPoint.y - height / 2.0) controlPoint1:CGPointMake(centerPoint.x - width * 3.0 / 8.0, centerPoint.y - height) controlPoint2:CGPointMake(centerPoint.x + width * 3.0 / 8.0, centerPoint.y + height / 2.0)];
    [path addCurveToPoint:CGPointMake(centerPoint.x - width / 2.0, centerPoint.y + height / 2.0) controlPoint1:CGPointMake(centerPoint.x + width * 3.0 / 8.0, centerPoint.y + height ) controlPoint2:CGPointMake(centerPoint.x - width * 3.0 / 8.0, centerPoint.y - height * 3.0 / 8.0 )];
}

- (void)pathForOval: (UIBezierPath *)path Center:(CGPoint) centerPoint height: (CGFloat) height width: (CGFloat) width
{
    CGFloat radius = height / 2.0;
    [path moveToPoint:CGPointMake(centerPoint.x - width / 2.0 + radius , centerPoint.y + height / 2.0)];
    [path addArcWithCenter:CGPointMake(centerPoint.x - width / 2.0 + radius, centerPoint.y) radius:radius startAngle:degreeToRadius(90.0) endAngle:degreeToRadius(270.0) clockwise:YES];
    [path addLineToPoint:CGPointMake(centerPoint.x + width / 2.0 - radius, centerPoint.y - height/2.0)];
    [path addArcWithCenter:CGPointMake(centerPoint.x + width / 2.0 - radius, centerPoint.y) radius:radius startAngle:degreeToRadius(270.0) endAngle:degreeToRadius(90.0) clockwise:YES];
    [path addLineToPoint:CGPointMake(centerPoint.x - width / 2.0 + radius, centerPoint.y + height/2.0)];
}




#define striped_line_width 2.0
#define striped_line_space 4
#define striped_default_width 70
#define current_striped_line_width(x) striped_line_width * (x)/ striped_default_width
#define current_striped_line_space(x) striped_line_space * (x)/ striped_default_width

- (void)fillPattern: (CGPoint) centerPoint
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[self getForgroundColor] set];
    switch (self.card.shading) {
        case 1:

            CGContextSetLineWidth(context, self.bounds.size.width);

            CGContextMoveToPoint(context, centerPoint.x  , centerPoint.y - self.bounds.size.height / 2.0);
            CGContextAddLineToPoint(context, centerPoint.x  , centerPoint.y + self.bounds.size.height / 2.0);
            CGContextStrokePath(context);
            
            break;
        case 2:
            CGContextSetLineWidth(context, current_striped_line_width(self.bounds.size.width));
            for (int i = 1 ; i < 21; i += 1 ) {
                CGContextMoveToPoint(context, centerPoint.x - self.bounds.size.width / 2.0 + i * current_striped_line_space(self.bounds.size.width), centerPoint.y - self.bounds.size.height / 2.0);
                CGContextAddLineToPoint(context, centerPoint.x - self.bounds.size.width / 2.0 + i * current_striped_line_space(self.bounds.size.width), centerPoint.y + self.bounds.size.height / 2.0);
                CGContextStrokePath(context);
            }
            break;
        case 3:
            
            break;
        default:
            break;
    }

   


    
}

- (UIColor *)getForgroundColor
{

    switch (self.card.color) {
        case 1:
            return [UIColor redColor];
            break;
        case 2:
            return [UIColor greenColor];
            break;
        case 3:
            return [UIColor purpleColor];
            break;
        default:
            return [UIColor whiteColor];
            break;
    }
}

- (void)selectedCard: (UITapGestureRecognizer *) gesture
{
    self.card.isSelected = !self.card.isSelected;
    [self setNeedsDisplay];
    if ([self.delegate respondsToSelector:@selector(selected:isSelected:)]) {
        [self.delegate selected:self isSelected:self.card.isSelected];
    }
}


#pragma mark - Init
- (void)setup
{
    self.backgroundColor = nil;
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedCard:)];
    [self addGestureRecognizer:tap];
}

- (void)awakeFromNib
{
    [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self setup];
    return self;
}


@end
