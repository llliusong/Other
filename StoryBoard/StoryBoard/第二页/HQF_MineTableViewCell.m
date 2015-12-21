//
//  HQF_MineTableViewCell.m
//  High_Quality_Fabric
//
//  Created by 黎金 on 15/11/5.
//  Copyright © 2015年 sixgui. All rights reserved.
//

#import "HQF_MineTableViewCell.h"
#import "Header.h"
@implementation HQF_MineTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        headImage = [[UIImageView alloc] initWithFrame:CGRectMake(12.5, 12.5, 20, 20)];
        headImage.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:headImage];
        
        titelLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, self.frame.size.width - 55, 45)];
        titelLabel.font = [UIFont systemFontOfSize:14.0];
        titelLabel.textAlignment = NSTextAlignmentLeft;
        titelLabel.textColor = TextColor;
        [self addSubview:titelLabel];
        
        self.grayView = [[UIView alloc] initWithFrame:CGRectMake(50, 44.5, SCREEN_WIDTH - 50, 0.5)];
        self.grayView.backgroundColor = GrayLine;
        [self addSubview:self.grayView];
    }
    return self;
    
}

-(void)HQF_MineTableViewCell:(NSString *)imageStr Title:(NSString *)titleStr{

    headImage.image = [UIImage imageNamed:imageStr];
    titelLabel.text = titleStr;
}

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

   
}

@end
