//
//  DWZonePickerDelegate.m
//  实验助手
//
//  Created by SXQ on 15/11/19.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import "DWZonePickerDelegate.h"
@interface DWZonePickerDelegate ()
@property (nonatomic,copy) DoneBlock doneBlock;
@property (nonatomic,copy) CancelBlock cancelBlock;

@property (nonatomic,strong) NSArray *provinces;
@property (nonatomic,strong) NSArray *cities;
@property (nonatomic,strong) NSDictionary *selectedProvince;
@property (nonatomic,strong) NSDictionary *selectedCity;
@end
@implementation DWZonePickerDelegate
- (instancetype)initWithDoneBlock:(DoneBlock)doneBlock cancelBlock:(CancelBlock)cancelBlock
{
    if (self = [super init]) {
        
        self.doneBlock = doneBlock;
        self.cancelBlock = cancelBlock;
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"city.json" ofType:nil];
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        _provinces = dict[@"provinces"];
        _cities = [[_provinces objectAtIndex:0] objectForKey:@"cities"];
        self.selectedProvince = [self.provinces objectAtIndex:0];
        self.selectedCity = [self.cities objectAtIndex:0];
    }
    return self;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return [self.provinces count];
            break;
        case 1:
            return [self.cities count];
            break;
        default:
            return 0;
            break;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return [[self.provinces objectAtIndex:row] objectForKey:@"name"];
            break;
        case 1:
            return [[self.cities objectAtIndex:row] objectForKey:@"name"];
            break;
        default:
            return nil;
            break;
    }
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (component) {
        case 0:
            self.cities = [[self.provinces objectAtIndex:row] objectForKey:@"cities"];
            [pickerView selectRow:0 inComponent:1 animated:NO];
            [pickerView reloadComponent:1];
            self.selectedProvince = [self.provinces objectAtIndex:row];
            if (self.cities.count) {
                self.selectedCity = [self.cities objectAtIndex:0];
            }
            break;
        case 1:
            if (self.cities.count) {
                self.selectedCity = [self.cities objectAtIndex:row];
            }
            break;
        default:
            break;
    }
}
- (void)actionSheetPickerDidCancel:(AbstractActionSheetPicker *)actionSheetPicker origin:(id)origin
{
    self.cancelBlock();
}
- (void)actionSheetPickerDidSucceed:(AbstractActionSheetPicker *)actionSheetPicker origin:(id)origin
{
    self.doneBlock(self.selectedProvince,self.selectedCity);
}
@end
