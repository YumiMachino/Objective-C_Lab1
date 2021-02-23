//
//  main.m
//  Lab1_
//
//  Created by Yumi Machino on 2021/02/22.
//

#import <Foundation/Foundation.h>

/// function:prompt the message and  takes user input from the command line(C), and return as NSString
/// get it as C String, convert it to NSString
NSString *getUserInput(int maxLength, NSString *prompt) {
    if (maxLength < 1) {
        maxLength = 255;
    }
    NSLog(@"%@ ", prompt);
    /// create a char array of size maxLength
    char inputChars[maxLength];
    /*
     fgets(array to store, size, source)-> return C string
     */
    char *result = fgets(inputChars, maxLength, stdin);
    if (result != NULL) {
        //1. initialize NSString from c-string(char array)
        NSString *objcString = [NSString stringWithUTF8String:inputChars];
        //2. trim the input (remove all whitespaces)
        NSString *trimmedInput = [objcString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSLog(@"%@", trimmedInput);
        return trimmedInput;
    }
    return NULL;
}


/// main is the starting point of the program
/// C, Objective-C
/// C String vs NSString
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        while(YES) {
            NSString *strInput = getUserInput(255, @"\nEnter your String: ('q' to quit): ");
            if ([strInput isEqualToString:@"q"]) {break; }
            
            while(YES) {
                NSString *option = getUserInput(10, @"\nChoose one of the following options:\n1. Uppercase\n2. Lowercase\n3. Numberize\n4. Canadianize\n5. Respond\n6. De-Space-It\n7. Word Count\n8. Remove Punctuations\n9. Done\n");
                
                if ([option isEqualToString: @"1\n"]) {
                    NSLog(@"%@", [strInput uppercaseString]);
                } else if  ([option isEqualToString: @"2\n"]) {
                    NSLog(@"%@", [strInput lowercaseString]);
                } else if  ([option isEqualToString: @"3\n"]) {
                    NSInteger integer = [strInput integerValue];
                    NSLog(@"integer: %ld", (long)integer);
                } else if  ([option isEqualToString:@"4\n"]) {
                    NSLog(@"%@, eh?", strInput);
                } else if  ([option isEqualToString:@"5\n"]) {
                    // if user input ends with '?', answer "I don't know"
                    // if it ends it '!', answer "Whoa, calm down!"
                    NSString * lastChar = [strInput substringFromIndex:[strInput length] - 2];
                    if ([lastChar isEqualToString: @"?\n"]) {
                        NSLog(@"I don't know");
                    } else if ([lastChar isEqualToString: @"!\n"]) {
                        NSLog(@"Whoa, calm down!");
                    }
                } else if  ([option isEqualToString:@"6\n"]) {
                    // Replace all spaces with "-"
                    for (int i = 0; i < [strInput length]; i++) {
                        if ([strInput characterAtIndex: i] == ' ') {
                            NSLog(@"-");
                        } else {
                            unichar uniCodeValue = [strInput characterAtIndex:i];
                            NSString * formatted = [NSString stringWithFormat: @"%c", uniCodeValue];
                            NSLog(@"%@", formatted);
                        }
                    }
                } else if  ([option isEqualToString:@"7\n"]) {
                    int count = 0;
                    for (int i = 0; i < [strInput length]; i++) {
                        if ([strInput characterAtIndex: i] == ' ') {
                            continue;
                        } else {
                            count ++;
                        }
                    }
                    NSLog(@"count: %i", count - 1);
                } else if  ([option isEqualToString:@"8\n"]) {
                    NSArray *punctuations = [NSArray arrayWithObjects: @"!", @";", @"!", @".", nil];
                    int count = [punctuations count];
                    NSLog(@"count: %d", count);
                    
                    for (int i = 0; i < [strInput length]; i++) {
                        int j;
                        for (j = 0; j < count ;j++) {
                            unichar uniCodeValue = [strInput characterAtIndex:i];
                            NSString * formatted = [NSString stringWithFormat: @"%c", uniCodeValue];
                            if ([formatted isEqualToString: [punctuations objectAtIndex: j]])   {
                                strInput = [strInput stringByReplacingOccurrencesOfString:formatted withString:@""];
                            }
                        }
                    }
                    NSLog(@"%@", strInput);
                }else if  ((option == nil) || [option isEqualToString:@"9\n"]) {
                    NSLog(@"Next String!");
                    break;
                } else {
                    NSLog(@"Not available.");
                }
            }
        }
    }
    return 0;
}


