#include <CoreFoundation/CoreFoundation.h>
#include <stdio.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (SearchExtensions)
-(NSArray *)searchParts;
@end

//#ifndef SPRINGBOARDSERVICES_H_
extern int SBSLaunchApplicationWithIdentifier(CFStringRef identifier, Boolean suspended);
extern CFStringRef SBSApplicationLaunchingErrorString(int error);
//#endif

int main(int argc, char **argv, char **envp){
    int ret;

    if (argc < 2) {
        fprintf(stderr, "Usage: %s com.application.identifier \n", argv[0]);
        return -1;
    }
    
    CFStringRef identifier = CFStringCreateWithCString(kCFAllocatorDefault, argv[1], kCFStringEncodingUTF8);
    assert(identifier != NULL);
    
    if (argc == 2){    
        ret = SBSLaunchApplicationWithIdentifier(identifier, FALSE);
        if (ret != 0) {
            fprintf(stderr, "Couldn't open application: %s. Reason: %i, ", argv[1], ret);
            CFShow(SBSApplicationLaunchingErrorString(ret));
        }

    }
    
    if (argc==3){
        //key::value@@key2::value2
        NSString *argument = [NSString stringWithUTF8String:argv[2]];
        //assert(argument != NULL);
        NSArray *listItems = [argument componentsSeparatedByString: @"@@"];


        
        CFDictionaryRef dict;
        CFStringRef keys[[listItems count]];
        CFStringRef values[[listItems count]];

        for(int i=0; i<[listItems count]; i++){
            NSArray* kv = [listItems[i] componentsSeparatedByString: @"::"];
            keys[i] = (__bridge CFStringRef)kv[0];
            values[i] = (__bridge CFStringRef)kv[1];
        }

        dict = CFDictionaryCreate(NULL, (const void **)keys, (const void **)values, [listItems count],
        NULL, NULL);
        ret = SBSLaunchApplicationWithIdentifierAndLaunchOptions(identifier, dict, FALSE);

        if (ret != 0) {
            fprintf(stderr, "Couldn't open application: %s. Reason: %i, ", argv[1], ret);
            CFShow(SBSApplicationLaunchingErrorString(ret));
        }
        //CFRelease(argument);
    }

    CFRelease(identifier);
    /*
    NSString *arg1 = [NSString stringWithUTF8String:argv[1]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:arg1]];
    //[[UIApplication sharedApplication] openUrl:@"pythonista://"]
    //[openUrl:@"pythonista://"]
    */
    return ret;
}
