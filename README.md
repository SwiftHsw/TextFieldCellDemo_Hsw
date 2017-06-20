# TextFieldCellDemo_Hsw


NSMutableDictionary * cellTextData;   //为了存储textFiled值  一一对应




主要方法是这个
#pragma mark - textFiled 编辑状态
-(void)endediting:(UITextField *)textF
{
   [cellTextData  setObject:textF.text forKey:[NSString stringWithFormat:@"%ld",(long)textF.tag]];
}
