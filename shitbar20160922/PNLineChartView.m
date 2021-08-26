// PNLineChartView.m
//
// Copyright (c) 2014 John Yung pincution@gmail.com
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#import "PNLineChartView.h"
#import "PNPlot.h"
#import <math.h>
#import <objc/runtime.h>
#import <QuartzCore/QuartzCore.h>


#pragma mark -
#pragma mark MACRO





#define POINT_CIRCLE  10.0f
#define NUMBER_VERTICAL_ELEMENTS (10)
#define HORIZONTAL_LINE_SPACES (20.1)
#define HORIZONTAL_LINE_WIDTH (0.2)
#define HORIZONTAL_START_LINE (0.17)
#define POINTER_WIDTH_INTERVAL  (42) //原45
#define AXIS_FONT_SIZE    (11)

#define AXIS_BOTTOM_LINE_HEIGHT (30)
#define AXIS_LEFT_LINE_WIDTH (35)

#define FLOAT_NUMBER_FORMATTER_STRING  @"%.f"

#define DEVICE_WIDTH   (420)

#define AXIX_LINE_WIDTH (0.5)



#pragma mark -

@interface PNLineChartView ()
{
    int theHighScore;
    int theWidthScore;
    
    int DW;
    int what1;
    int what2;
    int what3;
    int what4;
    
    int whatbh;
    int whatbw;

}

@property (nonatomic, strong) NSString* fontName;
@property (nonatomic, assign) CGPoint contentScroll;



@end


@implementation PNLineChartView


#pragma mark -
#pragma mark init

-(void)commonInit{

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    theHighScore = [defaults integerForKey:@"HighScore"];
    theWidthScore =[defaults integerForKey:@"WidthScore"];
    NSLog(@"%d,%d",theHighScore,theWidthScore);
    
    
    if(theHighScore >= 736)
    {
        DW = 180;
        what1 = 69;
        what2 = 9;
        what3 = 5;
        what4 = 62;
        whatbh = 8;
        whatbw = 53;
        
        self.xAxisFontSize = 16;
        
        self.horizontalLineInterval = 30.1;
        self.horizontalLineWidth = 0.4;
        self.pointerInterval = 63;
        
        
        self.axisBottomLinetHeight = 40;
        
        self.axisLineWidth = 1;
        
    }else if(theHighScore >= 667)
    {
        DW = 100;
        what1 = 59;
        what2 = 9;
        what3 = 5;
        what4 = 53;
        whatbh = 15;
        whatbw = 60;
        
        self.xAxisFontSize = 14;
        
        self.horizontalLineInterval = 27.1;
        self.horizontalLineWidth = 0.4;
        self.pointerInterval = 52;
        
        
        self.axisBottomLinetHeight = 35;
        
        self.axisLineWidth = 0.8;
        
    }else if(theHighScore < 667)
    {
        DW = 0;
        what1 = 42;
        what2 = 5;
        what3 = 0;
        what4 = 42;
        whatbh = 25;
        whatbw = 70;
        
        
        self.xAxisFontSize = 11;
        
        self.horizontalLineInterval = 20.1;
        self.horizontalLineWidth = 0.2;
        self.pointerInterval = 42;
        
        
        self.axisBottomLinetHeight = 30;
        
        self.axisLineWidth = 0.5;
    }
    
    
    self.fontName=@"Helvetica";
    self.numberOfVerticalElements=NUMBER_VERTICAL_ELEMENTS;
    self.xAxisFontColor = [UIColor darkGrayColor];
    //self.xAxisFontSize = AXIS_FONT_SIZE;
    self.horizontalLinesColor = [UIColor blackColor];
    
    //self.horizontalLineInterval = HORIZONTAL_LINE_SPACES;
    //self.horizontalLineWidth = HORIZONTAL_LINE_WIDTH;
    //self.pointerInterval = POINTER_WIDTH_INTERVAL;
    
    
    //self.axisBottomLinetHeight = AXIS_BOTTOM_LINE_HEIGHT;
    self.axisLeftLineWidth = AXIS_LEFT_LINE_WIDTH;
    //self.axisLineWidth = AXIX_LINE_WIDTH;
    
    self.floatNumberFormatterString = FLOAT_NUMBER_FORMATTER_STRING;
    
    
    
    
}

- (instancetype)init {
  if((self = [super init])) {
      [self commonInit];
  }
  return self;
}

- (void)awakeFromNib
{
      [self commonInit];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       [self commonInit];
    }
    return self;
}

#pragma mark -
#pragma mark Plots

- (void)addPlot:(PNPlot *)newPlot;
{
    if(nil == newPlot ) {
        return;
    }
    
    if (newPlot.plottingValues.count ==0) {
        return;
    }
    
    
    if(self.plots == nil){
        _plots = [NSMutableArray array];
    }
    
    [self.plots addObject:newPlot];
    
    [self layoutIfNeeded];
}

-(void)clearPlot{
    if (self.plots) {
        [self.plots removeAllObjects];
    }
}

#pragma mark -
#pragma mark Draw the lineChart

-(void)drawRect:(CGRect)rect{
    CGFloat startHeight = self.axisBottomLinetHeight;
    CGFloat startWidth = self.axisLeftLineWidth;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0.0f , self.bounds.size.height);
    CGContextScaleCTM(context, 1, -1);
    
    // set text size and font
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextSelectFont(context, [self.fontName UTF8String], self.xAxisFontSize, kCGEncodingMacRoman);
    
    
    // draw yAxis
    for (int i=0; i<=self.numberOfVerticalElements; i++) {
        int height =self.horizontalLineInterval*i;
        float verticalLine = height + startHeight - self.contentScroll.y;
        
        CGContextSetLineWidth(context, self.horizontalLineWidth);
        
        [self.horizontalLinesColor set];
        
        CGContextMoveToPoint(context, startWidth, verticalLine);
        CGContextAddLineToPoint(context, self.bounds.size.width, verticalLine);
        CGContextStrokePath(context);
        
        
        NSNumber* yAxisVlue = [self.yAxisValues objectAtIndex:i];
        
        NSString* numberString = [NSString stringWithFormat:self.floatNumberFormatterString, yAxisVlue.floatValue];
        
        NSInteger count = [numberString lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
        
        CGContextShowTextAtPoint(context, 20, verticalLine - self.xAxisFontSize/2+3, [numberString UTF8String], count);
    }
    
    
    // draw lines
    for (int i=0; i<self.plots.count; i++)
    {
        PNPlot* plot = [self.plots objectAtIndex:i];
        
        [plot.lineColor set];
        CGContextSetLineWidth(context, plot.lineWidth);
        
        
        NSArray* pointArray = plot.plottingValues;
        NSArray* pointArray2 = plot.plottingValues2;
        NSArray* pointArray3 = plot.plottingValues3;
        NSArray* pointArray4 = plot.plottingValues4;
        NSArray* pointArray5 = plot.plottingValues5;
        NSArray* pointArray6 = plot.plottingValues6;
        NSArray* pointArray7 = plot.plottingValues7;
        
        // draw lines
        
        ///1
        for (int i=0; i<pointArray.count; i++) {
            NSNumber* value = [pointArray objectAtIndex:i];
            float floatValue = value.floatValue;
            
            float height = (floatValue-self.min)/self.interval*self.horizontalLineInterval-self.contentScroll.y+startHeight;
            float width =(self.pointerInterval-((what1/pointArray.count)*(pointArray.count-1)))*(i+1)+self.contentScroll.x+ startHeight+what2+((what1/pointArray.count)*(pointArray.count-1)+what3);
            
            if (width<startWidth) {
                
                NSNumber* nextValue = [pointArray objectAtIndex:i+1];
                float nextFloatValue = nextValue.floatValue;
                float nextHeight = (nextFloatValue-self.min)/self.interval*self.horizontalLineInterval+startHeight;
                
                CGContextMoveToPoint(context, startWidth, nextHeight);
                
                continue;
            }
            
            if (i==0) {
                CGContextMoveToPoint(context,  width, height);
            }
            else{
                CGContextAddLineToPoint(context, width, height);
            }
        }
        if(pointArray2.count > 0)
        {
            NSNumber* value2 = [pointArray2 objectAtIndex:0];
            float floatValue2 = value2.floatValue;
            
            float height2 = (floatValue2-self.min)/self.interval*self.horizontalLineInterval-self.contentScroll.y+startHeight;
            float width2 =(self.pointerInterval-((what1/pointArray2.count)*(pointArray2.count-1)))*(i+1)+self.contentScroll.x+ startHeight+what2+((what1/pointArray2.count)*(pointArray2.count-1)+what4*1);
            
            CGContextAddLineToPoint(context, width2, height2);
            
        }else if(pointArray3.count > 0)
        {
            NSNumber* value3 = [pointArray3 objectAtIndex:0];
            float floatValue3 = value3.floatValue;
            
            float height3 = (floatValue3-self.min)/self.interval*self.horizontalLineInterval-self.contentScroll.y+startHeight;
            float width3 =(self.pointerInterval-((what1/pointArray3.count)*(pointArray3.count-1)))*(i+1)+self.contentScroll.x+ startHeight+what2+((what1/pointArray3.count)*(pointArray3.count-1)+what4*2);
            
            CGContextAddLineToPoint(context, width3, height3);
        }else if(pointArray4.count > 0)
        {
            NSNumber* value4 = [pointArray4 objectAtIndex:0];
            float floatValue4 = value4.floatValue;
            
            float height4 = (floatValue4-self.min)/self.interval*self.horizontalLineInterval-self.contentScroll.y+startHeight;
            float width4 =(self.pointerInterval-((what1/pointArray4.count)*(pointArray4.count-1)))*(i+1)+self.contentScroll.x+ startHeight+what2+((what1/pointArray4.count)*(pointArray4.count-1)+what4*3);
            
            CGContextAddLineToPoint(context, width4, height4);
        }else if(pointArray5.count > 0)
        {
            NSNumber* value5 = [pointArray5 objectAtIndex:0];
            float floatValue5 = value5.floatValue;
            
            float height5 = (floatValue5-self.min)/self.interval*self.horizontalLineInterval-self.contentScroll.y+startHeight;
            float width5 =(self.pointerInterval-((what1/pointArray5.count)*(pointArray5.count-1)))*(i+1)+self.contentScroll.x+ startHeight+what2+((what1/pointArray5.count)*(pointArray5.count-1)+what4*4);
            
            CGContextAddLineToPoint(context, width5, height5);
        }else if(pointArray6.count > 0)
        {
            NSNumber* value6 = [pointArray6 objectAtIndex:0];
            float floatValue6 = value6.floatValue;
            
            float height6 = (floatValue6-self.min)/self.interval*self.horizontalLineInterval-self.contentScroll.y+startHeight;
            float width6 =(self.pointerInterval-((what1/pointArray6.count)*(pointArray6.count-1)))*(i+1)+self.contentScroll.x+ startHeight+what2+((what1/pointArray6.count)*(pointArray6.count-1)+what4*5);
            
            CGContextAddLineToPoint(context, width6, height6);
        }else if(pointArray7.count > 0)
        {
            NSNumber* value7 = [pointArray7 objectAtIndex:0];
            float floatValue7 = value7.floatValue;
            
            float height7 = (floatValue7-self.min)/self.interval*self.horizontalLineInterval-self.contentScroll.y+startHeight;
            float width7 =(self.pointerInterval-((what1/pointArray7.count)*(pointArray7.count-1)))*(i+1)+self.contentScroll.x+ startHeight+what2+((what1/pointArray7.count)*(pointArray7.count-1)+what4*6);
            
            CGContextAddLineToPoint(context, width7, height7);
        }
        
        
        
        
        
        ///2
        for (int i=0; i<pointArray2.count; i++) {
            NSNumber* value2 = [pointArray2 objectAtIndex:i];
            float floatValue2 = value2.floatValue;
            
            float height2 = (floatValue2-self.min)/self.interval*self.horizontalLineInterval-self.contentScroll.y+startHeight;
            float width2 =(self.pointerInterval-((what1/pointArray2.count)*(pointArray2.count-1)))*(i+1)+self.contentScroll.x+ startHeight+what2+((what1/pointArray2.count)*(pointArray2.count-1)+what4*1);
            
            if (width2<startWidth) {
                
                NSNumber* nextValue = [pointArray2 objectAtIndex:i+1];
                float nextFloatValue = nextValue.floatValue;
                float nextHeight = (nextFloatValue-self.min)/self.interval*self.horizontalLineInterval+startHeight;
                
                CGContextMoveToPoint(context, startWidth, nextHeight);
                
                continue;
            }
            
            if (i==0) {
                CGContextMoveToPoint(context,  width2, height2);
            }
            else{
                CGContextAddLineToPoint(context, width2, height2);
            }
        }
        if(pointArray3.count > 0)
        {
            NSNumber* value3 = [pointArray3 objectAtIndex:0];
            float floatValue3 = value3.floatValue;
            
            float height3 = (floatValue3-self.min)/self.interval*self.horizontalLineInterval-self.contentScroll.y+startHeight;
            float width3 =(self.pointerInterval-((what1/pointArray3.count)*(pointArray3.count-1)))*(i+1)+self.contentScroll.x+ startHeight+what2+((what1/pointArray3.count)*(pointArray3.count-1)+what4*2);
            
            CGContextAddLineToPoint(context, width3, height3);
        }else if(pointArray4.count > 0)
        {
            NSNumber* value4 = [pointArray4 objectAtIndex:0];
            float floatValue4 = value4.floatValue;
            
            float height4 = (floatValue4-self.min)/self.interval*self.horizontalLineInterval-self.contentScroll.y+startHeight;
            float width4 =(self.pointerInterval-((what1/pointArray4.count)*(pointArray4.count-1)))*(i+1)+self.contentScroll.x+ startHeight+what2+((what1/pointArray4.count)*(pointArray4.count-1)+what4*3);
            
            CGContextAddLineToPoint(context, width4, height4);
        }else if(pointArray5.count > 0)
        {
            NSNumber* value5 = [pointArray5 objectAtIndex:0];
            float floatValue5 = value5.floatValue;
            
            float height5 = (floatValue5-self.min)/self.interval*self.horizontalLineInterval-self.contentScroll.y+startHeight;
            float width5 =(self.pointerInterval-((what1/pointArray5.count)*(pointArray5.count-1)))*(i+1)+self.contentScroll.x+ startHeight+what2+((what1/pointArray5.count)*(pointArray5.count-1)+what4*4);
            
            CGContextAddLineToPoint(context, width5, height5);
        }else if(pointArray6.count > 0)
        {
            NSNumber* value6 = [pointArray6 objectAtIndex:0];
            float floatValue6 = value6.floatValue;
            
            float height6 = (floatValue6-self.min)/self.interval*self.horizontalLineInterval-self.contentScroll.y+startHeight;
            float width6 =(self.pointerInterval-((what1/pointArray6.count)*(pointArray6.count-1)))*(i+1)+self.contentScroll.x+ startHeight+what2+((what1/pointArray6.count)*(pointArray6.count-1)+what4*5);
            
            CGContextAddLineToPoint(context, width6, height6);
        }else if(pointArray7.count > 0)
        {
            NSNumber* value7 = [pointArray7 objectAtIndex:0];
            float floatValue7 = value7.floatValue;
            
            float height7 = (floatValue7-self.min)/self.interval*self.horizontalLineInterval-self.contentScroll.y+startHeight;
            float width7 =(self.pointerInterval-((what1/pointArray7.count)*(pointArray7.count-1)))*(i+1)+self.contentScroll.x+ startHeight+what2+((what1/pointArray7.count)*(pointArray7.count-1)+what4*6);
            
            CGContextAddLineToPoint(context, width7, height7);
        }
        
        
        
        ///3
        for (int i=0; i<pointArray3.count; i++) {
            NSNumber* value3 = [pointArray3 objectAtIndex:i];
            float floatValue3 = value3.floatValue;
            
            float height3 = (floatValue3-self.min)/self.interval*self.horizontalLineInterval-self.contentScroll.y+startHeight;
            float width3 =(self.pointerInterval-((what1/pointArray3.count)*(pointArray3.count-1)))*(i+1)+self.contentScroll.x+ startHeight+what2+((what1/pointArray3.count)*(pointArray3.count-1)+what4*2);
            
            if (width3<startWidth) {
                
                NSNumber* nextValue = [pointArray objectAtIndex:i+1];
                float nextFloatValue = nextValue.floatValue;
                float nextHeight = (nextFloatValue-self.min)/self.interval*self.horizontalLineInterval+startHeight;
                
                CGContextMoveToPoint(context, startWidth, nextHeight);
                
                continue;
            }
            
            if (i==0) {
                CGContextMoveToPoint(context,  width3, height3);
            }
            else{
                CGContextAddLineToPoint(context, width3, height3);
            }
        }
        if(pointArray4.count > 0)
        {
            NSNumber* value4 = [pointArray4 objectAtIndex:0];
            float floatValue4 = value4.floatValue;
            
            float height4 = (floatValue4-self.min)/self.interval*self.horizontalLineInterval-self.contentScroll.y+startHeight;
            float width4 =(self.pointerInterval-((what1/pointArray4.count)*(pointArray4.count-1)))*(i+1)+self.contentScroll.x+ startHeight+what2+((what1/pointArray4.count)*(pointArray4.count-1)+what4*3);
            
            CGContextAddLineToPoint(context, width4, height4);
        }else if(pointArray5.count > 0)
        {
            NSNumber* value5 = [pointArray5 objectAtIndex:0];
            float floatValue5 = value5.floatValue;
            
            float height5 = (floatValue5-self.min)/self.interval*self.horizontalLineInterval-self.contentScroll.y+startHeight;
            float width5 =(self.pointerInterval-((what1/pointArray5.count)*(pointArray5.count-1)))*(i+1)+self.contentScroll.x+ startHeight+what2+((what1/pointArray5.count)*(pointArray5.count-1)+what4*4);
            
            CGContextAddLineToPoint(context, width5, height5);
        }else if(pointArray6.count > 0)
        {
            NSNumber* value6 = [pointArray6 objectAtIndex:0];
            float floatValue6 = value6.floatValue;
            
            float height6 = (floatValue6-self.min)/self.interval*self.horizontalLineInterval-self.contentScroll.y+startHeight;
            float width6 =(self.pointerInterval-((what1/pointArray6.count)*(pointArray6.count-1)))*(i+1)+self.contentScroll.x+ startHeight+what2+((what1/pointArray6.count)*(pointArray6.count-1)+what4*5);
            
            CGContextAddLineToPoint(context, width6, height6);
        }else if(pointArray7.count > 0)
        {
            NSNumber* value7 = [pointArray7 objectAtIndex:0];
            float floatValue7 = value7.floatValue;
            
            float height7 = (floatValue7-self.min)/self.interval*self.horizontalLineInterval-self.contentScroll.y+startHeight;
            float width7 =(self.pointerInterval-((what1/pointArray7.count)*(pointArray7.count-1)))*(i+1)+self.contentScroll.x+ startHeight+what2+((what1/pointArray7.count)*(pointArray7.count-1)+what4*6);
            
            CGContextAddLineToPoint(context, width7, height7);
        }
        
        
        
        ///4
        for (int i=0; i<pointArray4.count; i++) {
            NSNumber* value4 = [pointArray4 objectAtIndex:i];
            float floatValue4 = value4.floatValue;
            
            float height4 = (floatValue4-self.min)/self.interval*self.horizontalLineInterval-self.contentScroll.y+startHeight;
            float width4 =(self.pointerInterval-((what1/pointArray4.count)*(pointArray4.count-1)))*(i+1)+self.contentScroll.x+ startHeight+what2+((what1/pointArray4.count)*(pointArray4.count-1)+what4*3);
            
            if (width4<startWidth) {
                
                NSNumber* nextValue = [pointArray objectAtIndex:i+1];
                float nextFloatValue = nextValue.floatValue;
                float nextHeight = (nextFloatValue-self.min)/self.interval*self.horizontalLineInterval+startHeight;
                
                CGContextMoveToPoint(context, startWidth, nextHeight);
                
                continue;
            }
            
            if (i==0) {
                CGContextMoveToPoint(context,  width4, height4);
            }
            else{
                CGContextAddLineToPoint(context, width4, height4);
            }
        }
        if(pointArray5.count > 0)
        {
            NSNumber* value5 = [pointArray5 objectAtIndex:0];
            float floatValue5 = value5.floatValue;
            
            float height5 = (floatValue5-self.min)/self.interval*self.horizontalLineInterval-self.contentScroll.y+startHeight;
            float width5 =(self.pointerInterval-((what1/pointArray5.count)*(pointArray5.count-1)))*(i+1)+self.contentScroll.x+ startHeight+what2+((what1/pointArray5.count)*(pointArray5.count-1)+what4*4);
            
            CGContextAddLineToPoint(context, width5, height5);
        }else if(pointArray6.count > 0)
        {
            NSNumber* value6 = [pointArray6 objectAtIndex:0];
            float floatValue6 = value6.floatValue;
            
            float height6 = (floatValue6-self.min)/self.interval*self.horizontalLineInterval-self.contentScroll.y+startHeight;
            float width6 =(self.pointerInterval-((what1/pointArray6.count)*(pointArray6.count-1)))*(i+1)+self.contentScroll.x+ startHeight+what2+((what1/pointArray6.count)*(pointArray6.count-1)+what4*5);
            
            CGContextAddLineToPoint(context, width6, height6);
        }else if(pointArray7.count > 0)
        {
            NSNumber* value7 = [pointArray7 objectAtIndex:0];
            float floatValue7 = value7.floatValue;
            
            float height7 = (floatValue7-self.min)/self.interval*self.horizontalLineInterval-self.contentScroll.y+startHeight;
            float width7 =(self.pointerInterval-((what1/pointArray7.count)*(pointArray7.count-1)))*(i+1)+self.contentScroll.x+ startHeight+what2+((what1/pointArray7.count)*(pointArray7.count-1)+what4*6);
            
            CGContextAddLineToPoint(context, width7, height7);
        }
        
        
        
        
        ///5
        for (int i=0; i<pointArray5.count; i++) {
            NSNumber* value5 = [pointArray5 objectAtIndex:i];
            float floatValue5 = value5.floatValue;
            
            float height5 = (floatValue5-self.min)/self.interval*self.horizontalLineInterval-self.contentScroll.y+startHeight;
            float width5 =(self.pointerInterval-((what1/pointArray5.count)*(pointArray5.count-1)))*(i+1)+self.contentScroll.x+ startHeight+what2+((what1/pointArray5.count)*(pointArray5.count-1)+what4*4);
            
            if (width5<startWidth) {
                
                NSNumber* nextValue = [pointArray objectAtIndex:i+1];
                float nextFloatValue = nextValue.floatValue;
                float nextHeight = (nextFloatValue-self.min)/self.interval*self.horizontalLineInterval+startHeight;
                
                CGContextMoveToPoint(context, startWidth, nextHeight);
                
                continue;
            }
            
            if (i==0) {
                CGContextMoveToPoint(context,  width5, height5);
            }
            else{
                CGContextAddLineToPoint(context, width5, height5);
            }
        }
        if(pointArray6.count > 0)
        {
            NSNumber* value6 = [pointArray6 objectAtIndex:0];
            float floatValue6 = value6.floatValue;
            
            float height6 = (floatValue6-self.min)/self.interval*self.horizontalLineInterval-self.contentScroll.y+startHeight;
            float width6 =(self.pointerInterval-((what1/pointArray6.count)*(pointArray6.count-1)))*(i+1)+self.contentScroll.x+ startHeight+what2+((what1/pointArray6.count)*(pointArray6.count-1)+what4*5);
            
            CGContextAddLineToPoint(context, width6, height6);
        }else if(pointArray7.count > 0)
        {
            NSNumber* value7 = [pointArray7 objectAtIndex:0];
            float floatValue7 = value7.floatValue;
            
            float height7 = (floatValue7-self.min)/self.interval*self.horizontalLineInterval-self.contentScroll.y+startHeight;
            float width7 =(self.pointerInterval-((what1/pointArray7.count)*(pointArray7.count-1)))*(i+1)+self.contentScroll.x+ startHeight+what2+((what1/pointArray7.count)*(pointArray7.count-1)+what4*6);
            
            CGContextAddLineToPoint(context, width7, height7);
        }
        
        
        
        
        ///6
        for (int i=0; i<pointArray6.count; i++) {
            NSNumber* value6 = [pointArray6 objectAtIndex:i];
            float floatValue6 = value6.floatValue;
            
            float height6 = (floatValue6-self.min)/self.interval*self.horizontalLineInterval-self.contentScroll.y+startHeight;
            float width6 =(self.pointerInterval-((what1/pointArray6.count)*(pointArray6.count-1)))*(i+1)+self.contentScroll.x+ startHeight+what2+((what1/pointArray6.count)*(pointArray6.count-1)+what4*5);
            
            if (width6<startWidth) {
                
                NSNumber* nextValue = [pointArray objectAtIndex:i+1];
                float nextFloatValue = nextValue.floatValue;
                float nextHeight = (nextFloatValue-self.min)/self.interval*self.horizontalLineInterval+startHeight;
                
                CGContextMoveToPoint(context, startWidth, nextHeight);
                
                continue;
            }
            
            if (i==0) {
                CGContextMoveToPoint(context,  width6, height6);
            }
            else{
                CGContextAddLineToPoint(context, width6, height6);
            }
        }
        if(pointArray7.count > 0)
        {
            NSNumber* value7 = [pointArray7 objectAtIndex:0];
            float floatValue7 = value7.floatValue;
            
            float height7 = (floatValue7-self.min)/self.interval*self.horizontalLineInterval-self.contentScroll.y+startHeight;
            float width7 =(self.pointerInterval-((what1/pointArray7.count)*(pointArray7.count-1)))*(i+1)+self.contentScroll.x+ startHeight+what2+((what1/pointArray7.count)*(pointArray7.count-1)+what4*6);
            
            CGContextAddLineToPoint(context, width7, height7);
        }
        
        
        
        
        ///7
        for (int i=0; i<pointArray7.count; i++) {
            NSNumber* value7 = [pointArray7 objectAtIndex:i];
            float floatValue7 = value7.floatValue;
            
            float height7 = (floatValue7-self.min)/self.interval*self.horizontalLineInterval-self.contentScroll.y+startHeight;
            float width7 =(self.pointerInterval-((what1/pointArray7.count)*(pointArray7.count-1)))*(i+1)+self.contentScroll.x+ startHeight+what2+((what1/pointArray7.count)*(pointArray7.count-1)+what4*6);
            
            if (width7<startWidth) {
                
                NSNumber* nextValue = [pointArray objectAtIndex:i+1];
                float nextFloatValue = nextValue.floatValue;
                float nextHeight = (nextFloatValue-self.min)/self.interval*self.horizontalLineInterval+startHeight;
                
                CGContextMoveToPoint(context, startWidth, nextHeight);
                
                continue;
            }
            
            if (i==0) {
                CGContextMoveToPoint(context,  width7, height7);
            }
            else{
                CGContextAddLineToPoint(context, width7, height7);
            }
        }
        
        
        
        
        
        
        CGContextStrokePath(context);
        
        
        
        /*for (int i=0; i<pointArray.count; i++) {
            NSNumber* value = [pointArray objectAtIndex:i];
            float floatValue = value.floatValue;
            
            float height = (floatValue-self.min)/self.interval*self.horizontalLineInterval-self.contentScroll.y+startHeight;
            float width =self.pointerInterval*(i+1)+self.contentScroll.x+ startHeight+what2;
            
            if (width<startWidth) {
                
                NSNumber* nextValue = [pointArray objectAtIndex:i+1];
                float nextFloatValue = nextValue.floatValue;
                float nextHeight = (nextFloatValue-self.min)/self.interval*self.horizontalLineInterval+startHeight;
                
                CGContextMoveToPoint(context, startWidth, nextHeight);
                
                continue;
            }
            
            if (i==0) {
                CGContextMoveToPoint(context,  width, height);
            }
            else{
                CGContextAddLineToPoint(context, width, height);
            }
        }
        
        CGContextStrokePath(context);*/

        
        // draw pointer
        for (int i=0; i<pointArray.count; i++) {
            NSNumber* value = [pointArray objectAtIndex:i];
            float floatValue = value.floatValue;
            
            float height = (floatValue-self.min)/self.interval*self.horizontalLineInterval-self.contentScroll.y+startHeight;
            float width =(self.pointerInterval-((what1/pointArray.count)*(pointArray.count-1)))*(i+1)+self.contentScroll.x+ startWidth+((what1/pointArray.count)*(pointArray.count-1))+what3;
      
            
            if (width>startWidth){
                CGContextFillEllipseInRect(context, CGRectMake(width-POINT_CIRCLE, height-POINT_CIRCLE/2, POINT_CIRCLE, POINT_CIRCLE));
                
                
                CGRect frame = CGRectMake(width-POINT_CIRCLE, self.frame.size.width-(height+POINT_CIRCLE/2), POINT_CIRCLE, POINT_CIRCLE);
                UIButton *someAddButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                someAddButton.backgroundColor = [UIColor blackColor];
                [someAddButton setTitle:@"" forState:UIControlStateNormal];
                someAddButton.frame = frame;
                [someAddButton addTarget:self action:@selector(someButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
                
                
                
                [self addSubview:someAddButton];
                
            }
        }

        for (int i=0; i<pointArray2.count; i++) {
            NSNumber* value = [pointArray2 objectAtIndex:i];
            float floatValue = value.floatValue;
            
            float height = (floatValue-self.min)/self.interval*self.horizontalLineInterval-self.contentScroll.y+startHeight;
            float width =(self.pointerInterval-((what1/pointArray2.count)*(pointArray2.count-1)))*(i+1)+self.contentScroll.x+ startWidth+((what1/pointArray2.count)*(pointArray2.count-1)+what4*1);
            
            if (width>startWidth){
                CGContextFillEllipseInRect(context, CGRectMake(width-POINT_CIRCLE, height-POINT_CIRCLE/2, POINT_CIRCLE, POINT_CIRCLE));
                
                
                CGRect frame = CGRectMake(width-POINT_CIRCLE, self.frame.size.width-(height+POINT_CIRCLE/2), POINT_CIRCLE, POINT_CIRCLE);
                UIButton *someAddButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                someAddButton.backgroundColor = [UIColor blackColor];
                [someAddButton setTitle:@"" forState:UIControlStateNormal];
                someAddButton.frame = frame;
                [someAddButton addTarget:self action:@selector(someButtonClicked) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:someAddButton];
                
                
            }
        }
        
        for (int i=0; i<pointArray3.count; i++) {
            NSNumber* value = [pointArray3 objectAtIndex:i];
            float floatValue = value.floatValue;
            
            float height = (floatValue-self.min)/self.interval*self.horizontalLineInterval-self.contentScroll.y+startHeight;
            float width =(self.pointerInterval-((what1/pointArray3.count)*(pointArray3.count-1)))*(i+1)+self.contentScroll.x+ startWidth+((what1/pointArray3.count)*(pointArray3.count-1)+what4*2);
            
            if (width>startWidth){
                CGContextFillEllipseInRect(context, CGRectMake(width-POINT_CIRCLE, height-POINT_CIRCLE/2, POINT_CIRCLE, POINT_CIRCLE));
                
                CGRect frame = CGRectMake(width-POINT_CIRCLE, self.frame.size.width-(height+POINT_CIRCLE/2), POINT_CIRCLE, POINT_CIRCLE);
                UIButton *someAddButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                someAddButton.backgroundColor = [UIColor blackColor];
                [someAddButton setTitle:@"" forState:UIControlStateNormal];
                someAddButton.frame = frame;
                [someAddButton addTarget:self action:@selector(someButtonClicked) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:someAddButton];
                
                
            }
        }
        
        for (int i=0; i<pointArray4.count; i++) {
            NSNumber* value = [pointArray4 objectAtIndex:i];
            float floatValue = value.floatValue;
            
            float height = (floatValue-self.min)/self.interval*self.horizontalLineInterval-self.contentScroll.y+startHeight;
            float width =(self.pointerInterval-((what1/pointArray4.count)*(pointArray4.count-1)))*(i+1)+self.contentScroll.x+ startWidth+((what1/pointArray4.count)*(pointArray4.count-1)+what4*3);
            
            if (width>startWidth){
                CGContextFillEllipseInRect(context, CGRectMake(width-POINT_CIRCLE, height-POINT_CIRCLE/2, POINT_CIRCLE, POINT_CIRCLE));
                
                CGRect frame = CGRectMake(width-POINT_CIRCLE, self.frame.size.width-(height+POINT_CIRCLE/2), POINT_CIRCLE, POINT_CIRCLE);
                UIButton *someAddButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                someAddButton.backgroundColor = [UIColor blackColor];
                [someAddButton setTitle:@"" forState:UIControlStateNormal];
                someAddButton.frame = frame;
                [someAddButton addTarget:self action:@selector(someButtonClicked) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:someAddButton];
                
                
            }
        }
        
        for (int i=0; i<pointArray5.count; i++) {
            NSNumber* value = [pointArray5 objectAtIndex:i];
            float floatValue = value.floatValue;
            
            float height = (floatValue-self.min)/self.interval*self.horizontalLineInterval-self.contentScroll.y+startHeight;
            float width =(self.pointerInterval-((what1/pointArray5.count)*(pointArray5.count-1)))*(i+1)+self.contentScroll.x+ startWidth+((what1/pointArray5.count)*(pointArray5.count-1)+what4*4);
            
            if (width>startWidth){
                CGContextFillEllipseInRect(context, CGRectMake(width-POINT_CIRCLE, height-POINT_CIRCLE/2, POINT_CIRCLE, POINT_CIRCLE));
                
                CGRect frame = CGRectMake(width-POINT_CIRCLE, self.frame.size.width-(height+POINT_CIRCLE/2), POINT_CIRCLE, POINT_CIRCLE);
                UIButton *someAddButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                someAddButton.backgroundColor = [UIColor blackColor];
                [someAddButton setTitle:@"" forState:UIControlStateNormal];
                someAddButton.frame = frame;
                [someAddButton addTarget:self action:@selector(someButtonClicked) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:someAddButton];
                
            }
        }
        
        for (int i=0; i<pointArray6.count; i++) {
            NSNumber* value = [pointArray6 objectAtIndex:i];
            float floatValue = value.floatValue;
            
            float height = (floatValue-self.min)/self.interval*self.horizontalLineInterval-self.contentScroll.y+startHeight;
            float width =(self.pointerInterval-((what1/pointArray6.count)*(pointArray6.count-1)))*(i+1)+self.contentScroll.x+ startWidth+((what1/pointArray6.count)*(pointArray6.count-1)+what4*5);
            
            if (width>startWidth){
                CGContextFillEllipseInRect(context, CGRectMake(width-POINT_CIRCLE, height-POINT_CIRCLE/2, POINT_CIRCLE, POINT_CIRCLE));
                
                CGRect frame = CGRectMake(width-POINT_CIRCLE, self.frame.size.width-(height+POINT_CIRCLE/2), POINT_CIRCLE, POINT_CIRCLE);
                UIButton *someAddButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                someAddButton.backgroundColor = [UIColor blackColor];
                [someAddButton setTitle:@"" forState:UIControlStateNormal];
                someAddButton.frame = frame;
                [someAddButton addTarget:self action:@selector(someButtonClicked) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:someAddButton];
                
                
            }
        }
        
        for (int i=0; i<pointArray7.count; i++) {
            NSNumber* value = [pointArray7 objectAtIndex:i];
            float floatValue = value.floatValue;
            
            float height = (floatValue-self.min)/self.interval*self.horizontalLineInterval-self.contentScroll.y+startHeight;
            float width =(self.pointerInterval-((what1/pointArray7.count)*(pointArray7.count-1)))*(i+1)+self.contentScroll.x+ startWidth+((what1/pointArray7.count)*(pointArray7.count-1)+what4*6);
            
            if (width>startWidth){
                CGContextFillEllipseInRect(context, CGRectMake(width-POINT_CIRCLE, height-POINT_CIRCLE/2, POINT_CIRCLE, POINT_CIRCLE));
                
                CGRect frame = CGRectMake(width-POINT_CIRCLE, self.frame.size.width-(height+POINT_CIRCLE/2), POINT_CIRCLE, POINT_CIRCLE);
                UIButton *someAddButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                someAddButton.backgroundColor = [UIColor blackColor];
                [someAddButton setTitle:@"" forState:UIControlStateNormal];
                someAddButton.frame = frame;
                [someAddButton addTarget:self action:@selector(someButtonClicked) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:someAddButton];
                
            }
        }
        
        
        CGContextStrokePath(context);
    }
    
    [self.xAxisFontColor set];
    CGContextSetLineWidth(context, self.axisLineWidth);
    CGContextMoveToPoint(context, startWidth, startHeight);
    
    CGContextAddLineToPoint(context, startWidth, self.bounds.size.height);
    CGContextStrokePath(context);
    
    CGContextMoveToPoint(context, startWidth, startHeight);
    CGContextAddLineToPoint(context, self.bounds.size.width, startHeight);
    CGContextStrokePath(context);
    
    // x axis text
    for (int i=0; i<self.xAxisValues.count; i++) {
        float width =self.pointerInterval*(i+1)+self.contentScroll.x+ startHeight;
        float height = self.xAxisFontSize;
        
        if (width<startWidth) {
            continue;
        }

        
        NSInteger count = [[self.xAxisValues objectAtIndex:i] lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
        CGContextShowTextAtPoint(context, width-5, height, [[self.xAxisValues objectAtIndex:i] UTF8String], count);
    }
    
}

-(void)someButtonClicked:(id)sender{
    UIButton *btn = sender;
    NSLog(@"%ld",btn.tag);
    
    NSLog(@"%@",_hurtData);
}

#pragma mark -
#pragma mark touch handling
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touchLocation=[[touches anyObject] locationInView:self];
    CGPoint prevouseLocation=[[touches anyObject] previousLocationInView:self];
    float xDiffrance=touchLocation.x-prevouseLocation.x;
    float yDiffrance=touchLocation.y-prevouseLocation.y;
    
    _contentScroll.x+=xDiffrance;
    _contentScroll.y+=yDiffrance;
    
    if (_contentScroll.x >0) {
        _contentScroll.x=0;
    }
    
    if(_contentScroll.y<0){
        _contentScroll.y=0;
    }
    
    if (-_contentScroll.x>(self.pointerInterval*(self.xAxisValues.count +3)-(DEVICE_WIDTH+DW))) {
        _contentScroll.x=-(self.pointerInterval*(self.xAxisValues.count +3)-(DEVICE_WIDTH+DW));
    }
    
    if (_contentScroll.y>self.frame.size.height/2) {
        _contentScroll.y=self.frame.size.height/2;
    }
    
    
    _contentScroll.y =0;// close the move up
    
    [self setNeedsDisplay];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

@end

