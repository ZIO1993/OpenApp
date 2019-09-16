#include <CoreFoundation/CoreFoundation.h>
#include <stdio.h>
#import <Foundation/Foundation.h>
#import "NSString.h"

#ifndef SPRINGBOARDSERVICES_H_
extern int SBSLaunchApplicationWithIdentifier(CFStringRef identifier, Boolean suspended);
extern CFStringRef SBSApplicationLaunchingErrorString(int error);
#endif

int main(int argc, char **argv, char **envp)
{
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
        //key::value;;key2::value2;;
        NSString *argument = [NSString stringWithUTF8String:argv[2]];
        //assert(argument != NULL);
        NSArray *listItems = [argument componentSeparatedByString:@";;"];

        CFDictionaryRef dict;
        CFStringRef keys[[listItems count]];
        CFStringRef values[[listItems count]];

        for(int i=0; i<[listItems count]; i++){
            NSArray* kv = [listItems[i] componentSeparatedByString:@"::"];
            keys[i] = kv[0];
            value[i] = kv[0];
        }

        dict = CFDictionaryCreate(NULL, (void **)keys, (void **)values, [listItems count],
        NULL, NULL);
        ret = SBSLaunchApplicationWithIdentifierAndLaunchOptions(identifier, dict, FALSE);

        if (ret != 0) {
            fprintf(stderr, "Couldn't open application: %s. Reason: %i, ", argv[1], ret);
            CFShow(SBSApplicationLaunchingErrorString(ret));
        }
        CFRelease(argument);
    }

    CFRelease(identifier);

    return ret;
}
