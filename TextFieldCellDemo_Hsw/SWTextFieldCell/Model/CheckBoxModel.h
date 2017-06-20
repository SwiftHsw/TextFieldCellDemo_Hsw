//
//  CheckBoxModel.h
//  TextFieldCellDemo_Hsw
//
//  Created by  677676  on 17/6/20.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckBoxModel : NSObject

/**
 *  发票抬头
 */
@property(nonatomic,copy)NSString * InvoiceHeader;

/**
 *  税务号
 */
@property(nonatomic,copy)NSString *TaxCode;
/**
 *  单位地址
 */
@property(nonatomic,copy)NSString *UnitAddress;
/**
 *  单位电话
 */
@property(nonatomic,copy)NSString *UnitPhone;
/**
 *  开户银行
 */
@property(nonatomic,copy)NSString *OpeningBank;

/**
 *  银行帐号
 */

@property(nonatomic,copy)NSString * BankAccountNumber;

@end
