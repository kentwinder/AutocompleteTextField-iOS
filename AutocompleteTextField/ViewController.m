//
//  ViewController.m
//  AutocompleteTextField
//
//  Created by Kakashi on 06/26/2015.
//  Copyright (c) 2015 Kent Winder. All rights reserved.
//

#import "ViewController.h"
#import "Product.h"

@interface ViewController ()

@end

@implementation ViewController

NSArray *strings;
NSMutableArray *products;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initData {
    strings = @[@"accumsan", @"ad", @"adipiscing", @"aenean", @"aliquam", @"aliquet", @"amet", @"ante", @"aptent", @"arcu", @"assumenda", @"at", @"auctor", @"augue", @"aut", @"bibendum", @"blandit", @"class", @"commodo", @"condimentum", @"congue", @"consectetuer", @"consequat", @"consequatur", @"conubia", @"convallis", @"cras", @"cubilia", @"cum", @"curabitur", @"cursus", @"dapibus", @"diam", @"dictum", @"dictumst", @"dignissim", @"dis", @"dolor", @"donec", @"dui", @"duis", @"egestas", @"eget", @"eleifend", @"elementum", @"elit", @"enim", @"erat", @"eros", @"est", @"et", @"etiam", @"eu", @"euismod", @"facilis", @"facilisis", @"fames", @"faucibus", @"felis", @"fermentum", @"feugiat", @"fringilla", @"fusce", @"gravida", @"habitasse", @"hac", @"hendrerit", @"id", @"imperdiet", @"in", @"integer", @"interdum", @"ipsum", @"iure", @"justo", @"lacinia", @"lacus", @"laoreet", @"lectus", @"leo", @"libero", @"ligula", @"lobortis", @"lorem", @"luctus", @"maecenas", @"magna", @"malesuada", @"massa", @"mattis", @"mauris", @"maxime", @"metus", @"mi", @"modi", @"molestiae", @"molestie", @"mollis", @"mollit", @"montes", @"morbi", @"mus", @"nam", @"natoque", @"nec", @"neque", @"nibh", @"nisl", @"non", @"nonummy", @"nulla", @"nullam", @"nunc", @"odio", @"orci", @"ornare", @"parturient", @"pede", @"pellentesque", @"penatibus", @"per", @"pharetra", @"phasellus", @"placerat", @"platea", @"porta", @"porttitor", @"posuere", @"potenti", @"praesent", @"pretium", @"proin", @"pulvinar", @"purus", @"quam", @"qui", @"quis", @"quisque", @"rhoncus", @"ridiculus", @"risus", @"rutrum", @"sagittis", @"sapien", @"scelerisque", @"sed", @"sem", @"semper", @"senectus", @"sit", @"sociosqu", @"sodales", @"sollicitudin", @"suscipit", @"suspendisse", @"tellus", @"tempor", @"tempus", @"tincidunt", @"torquent", @"tortor", @"tristique", @"turpis", @"ullamcorper", @"ultrices", @"ultricies", @"urna", @"ut", @"varius", @"vehicula", @"vel", @"velit", @"venenatis", @"vestibulum", @"vitae", @"vivamus", @"viverra", @"voluptas", @"voluptate", @"voluptatibus", @"volutpat", @"vulputate", @"wisi"];
    
    products = [[NSMutableArray alloc] init];
    for (int i = 0; i < [strings count]; i++) {
        Product *product = [[Product alloc] init];
        product.code = [NSString stringWithFormat:@"P00%d", i];
        product.name = strings[i];
        [products addObject:product];
    }
    
    [self.stringAutoCompleteField setDelegate:self];
    [self.customObjAutocompleteField setDelegate:self];
    [self.suggestionsIsAboveField setDelegate:self];
}

- (NSArray *) dataForTextField:(AutocompleteTextField *)textField {
    if (textField == self.customObjAutocompleteField) {
        return products;
    }
    return strings;
}

- (NSString *)titleForSuggestion:(AutocompleteTextField *)textField obj:(id)obj {
    if (textField == self.customObjAutocompleteField) {
        return ((Product *)obj).name;
    }
    return (NSString *)obj;
}

- (NSPredicate *)predicateForDataFilter:(AutocompleteTextField *)textField {
    if (textField == self.customObjAutocompleteField) {
        return [NSPredicate predicateWithFormat:@"name BEGINSWITH[cd] %@", textField.text];
    } else if (textField == self.stringAutoCompleteField) {
        return [NSPredicate predicateWithFormat:@"self BEGINSWITH[cd] %@", textField.text];
    } else {
        return [NSPredicate predicateWithFormat:@"self CONTAINS[cd] %@", textField.text];
    }
}

- (int)minCharToStartFilter:(AutocompleteTextField *)textField {
    if (textField == self.customObjAutocompleteField) {
        return 2;
    }
    return 0;
}

- (BOOL)suggestionsIsDisplayedBelowTextField:(AutocompleteTextField *)textField {
    if (textField == self.suggestionsIsAboveField) {
        return NO;
    }
    return YES;
}

- (void)didSelectSuggestion:(AutocompleteTextField *)textField obj:(id)obj {
    if (textField == self.customObjAutocompleteField) {
        Product *p = (Product *)obj;
        NSString *message = [NSString stringWithFormat:@"You selected product '%@' with code: '%@'", p.name, p.code];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"OK", nil];
        [alert show];
    }
}

@end
