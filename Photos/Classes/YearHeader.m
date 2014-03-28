//
//  YearHeader.m
//  Photos
//
//  Created by tag_mac_05 on 14-3-26.
//  Copyright (c) 2014年 tag_ux. All rights reserved.
//

#import "YearHeader.h"

@implementation YearHeader

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        yearLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        [self addSubview:yearLabel];
        
        
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = self.bounds;
//        button.backgroundColor = [gUIColor redColor];

        button.tag = 1;
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    return self;
}
-(void)buttonPressed:(UIButton*)sender
{
    if ([_delegate respondsToSelector:@selector(yearHeaderPressed:)]) {
        
        [self.delegate yearHeaderPressed:self];
    }
}

-(void)setYearText:(NSString*)text
{
    yearLabel.text = text;
}

-(NSString*)yearText
{
    return yearLabel.text;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
