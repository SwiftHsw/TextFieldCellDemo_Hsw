//
//  SwTextFieldCell.m
//  TextFieldCellDemo_Hsw
//
//  Created by  677676  on 17/6/20.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import "SwTextFieldCell.h"

#define SCREENW  [UIScreen mainScreen].bounds.size.width

@interface SwTextFieldCell ()

@end
@implementation SwTextFieldCell


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}



-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUp];
        
    }
    return self;
}
-(void)setUp{
    
    [self.contentView addSubview:self.titleLb];
    [self.contentView addSubview:self.dataTextField];
    
}


-(UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc]init];
        _titleLb.font = [UIFont systemFontOfSize:15];
        _titleLb.textColor = [UIColor grayColor];
    }
    return  _titleLb;
}


-(UITextField *)dataTextField{
    if (!_dataTextField) {
        _dataTextField = [[UITextField alloc]init];
        
    }
    return  _dataTextField;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGRect rect  =  [self.titleLb.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    
    
    _titleLb.frame = CGRectMake(15, 44/2-30/2, rect.size.width+5, 30);
    
    _dataTextField.frame = CGRectMake(CGRectGetMaxX(_titleLb.frame)+15, _titleLb.frame.origin.y,SCREENW -90 - 15 - 15  , _titleLb.frame.size.height);
    
    
}


@end
