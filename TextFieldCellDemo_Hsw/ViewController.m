//
//  ViewController.m
//  TextFieldCellDemo_Hsw
//
//  Created by  677676  on 17/6/20.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import "ViewController.h"
#import "SwTextFieldCell.h"
#import "CheckBoxModel.h"
#import "SVProgressHUD.h"

#define SCREENW  [UIScreen mainScreen].bounds.size.width
#define SCREENH  [UIScreen mainScreen].bounds.size.height
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
@interface ViewController ()
<UITableViewDelegate,
UITableViewDataSource,
UITextFieldDelegate>{
NSMutableDictionary * cellTextData;   //存储textFiled值
}

@property(nonatomic,retain)UITableView * CheckBoxTable;
@property(nonatomic,retain)NSArray * CheckBoxTableDataArr;
@property(nonatomic,retain)UIButton * BottomBtn;
@property(nonatomic,assign)NSIndexPath * NewIndexPath;

@end
static NSString * SwTextFieldCellID = @"SwTextFieldCell";
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    cellTextData = [NSMutableDictionary dictionary];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.CheckBoxTable];
    [self.view addSubview:self.BottomBtn];
    
   
}
-(UITableView *)CheckBoxTable{
    if (!_CheckBoxTable) {
        _CheckBoxTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREENW, SCREENH) style:UITableViewStylePlain];
        _CheckBoxTable.delegate =self;
        _CheckBoxTable.dataSource = self;
        _CheckBoxTable.backgroundColor = [UIColor whiteColor];
        [_CheckBoxTable registerClass:[SwTextFieldCell class] forCellReuseIdentifier:SwTextFieldCellID];
        _CheckBoxTable.tableFooterView = [UIView new];
    }
    return _CheckBoxTable;
}
-(NSArray *)CheckBoxTableDataArr{
    if (!_CheckBoxTableDataArr) {
        _CheckBoxTableDataArr = @[
                                  @[ @"发票抬头",@"税  务  号",@"单位地址",@"单位电话",@"开户银行",@"银行帐号"],
                                  @[@"请填写准确的抬头名称",@"请输入税务登记证号",@"请填写收票单位注册地址",@"请输入单位电话号码",@"请填写收票单位开户银行",@"请输入收票单位银行帐号"]
                                  ];
    }
    return _CheckBoxTableDataArr;
}

-(UIButton *)BottomBtn{
    if (!_BottomBtn) {
        _BottomBtn = [[UIButton alloc]init];
        _BottomBtn .backgroundColor = [UIColor purpleColor];
        _BottomBtn .frame = CGRectMake(15, SCREENH - 70, SCREENW - 30, 50);
        [_BottomBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_BottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_BottomBtn addTarget:self action:@selector(ClickToServer) forControlEvents:UIControlEventTouchUpInside];
    }
    return _BottomBtn;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.CheckBoxTableDataArr[0] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SwTextFieldCell * cell = [tableView dequeueReusableCellWithIdentifier:SwTextFieldCellID];
    cell.titleLb.text = self.CheckBoxTableDataArr[0][indexPath.row];
    cell.dataTextField.placeholder = self.CheckBoxTableDataArr[1][indexPath.row];
    cell.dataTextField.tag = indexPath.row;
    cell.dataTextField.delegate = self;
    [cell.dataTextField addTarget:self action:@selector(endediting:) forControlEvents:UIControlEventEditingDidEnd];
    return cell;
    
}
#pragma mark - textFiled 编辑状态
-(void)endediting:(UITextField *)textF
{
   [cellTextData  setObject:textF.text forKey:[NSString stringWithFormat:@"%ld",(long)textF.tag]];
}


#pragma mark －－保存
-(void)ClickToServer{
    
    [self registFrist];
    
    /**
     *  固定就这几个的话写死了tag值
     */
    CheckBoxModel * model = [CheckBoxModel new];
    model.InvoiceHeader =    [cellTextData valueForKey:[NSString stringWithFormat:@"%d",0]];
    model.TaxCode =           [cellTextData valueForKey:[NSString stringWithFormat:@"%d",1]];
    model.UnitAddress =   [cellTextData valueForKey:[NSString stringWithFormat:@"%d",2]];
    model.UnitPhone =   [cellTextData valueForKey:[NSString stringWithFormat:@"%d",3]];
    model.OpeningBank =   [cellTextData valueForKey:[NSString stringWithFormat:@"%d",4]];
    model.BankAccountNumber =   [cellTextData valueForKey:[NSString stringWithFormat:@"%d",5]];
   
    [self releaseRequirements:model];
    
}

-(void)registFrist{
    for (int i =0 ; i<[self.CheckBoxTableDataArr[0] count]; i++) {
        SwTextFieldCell * cell = [self.CheckBoxTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        UITextField * textF = [cell viewWithTag:i];
        [textF resignFirstResponder];
    }
}

-(void)releaseRequirements:(CheckBoxModel *)model{
    if (kStringIsEmpty(model.InvoiceHeader)) {
        
        [SVProgressHUD showErrorWithStatus:@"请填写抬头名称"];
        return;
    }
    if (kStringIsEmpty(model.TaxCode)) {
        [SVProgressHUD showErrorWithStatus:@"请输入税务登记号"];
        return;
    }
    if (kStringIsEmpty(model.UnitAddress)) {
        [SVProgressHUD showErrorWithStatus:@"请填写收票单位地址"];
        return;
    }
    if (kStringIsEmpty(model.UnitPhone)) {
        [SVProgressHUD showErrorWithStatus:@"请输入电话"];
        return;
    }
    if (kStringIsEmpty(model.OpeningBank)) {
        [SVProgressHUD showErrorWithStatus:@"请填写开户银行"];
        return;
    }
    if (kStringIsEmpty(model.BankAccountNumber)) {
        [SVProgressHUD showErrorWithStatus:@"请输入银行帐号"];
        return;
    }
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}
@end
