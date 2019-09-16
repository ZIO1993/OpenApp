#include <CoreFoundation/CoreFoundation.h>
#include <stdio.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (SearchExtensions)
-(NSArray *)searchParts;
@end

#ifndef SPRINGBOARDSERVICES_H_
extern int SBSLaunchApplicationWithIdentifier(CFStringRef identifier, Boolean suspended);
extern CFStringRef SBSApplicationLaunchingErrorString(int error);
#endif

/*
#ifndef SPRINGBOARDSERVICES_H_
extern int SBSLaunchApplicationWithIdentifierAndLaunchOptions(CFStringRef identifier, CFDictionaryRef launchOptions, Boolean suspended);
extern CFStringRef SBSApplicationLaunchingErrorString(int error);
#endif
*/

//- (void)openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenExternalURLOptionsKey, id> *)options completionHandler:(void (^)(BOOL success))completion;

int main(int argc, char **argv, char **envp){
    //int ret;

    if (argc < 2) {
        fprintf(stderr, "Usage: %s com.application.identifier \n", argv[0]);
        return -1;
    }
    /*
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
        NSArray *listItems = [argument componentsSeparatedByString: @";;"];


        
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

    */
    NSString *wazeAppURL = @"waze://";
    NSString *mapsAppURL = @"maps://";

    BOOL canOpenURL = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:wazeAppURL]];

    NSString *url = canOpenURL ? wazeAppURL : mapsAppURL;
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];

    /*
    NSString *url = [NSString stringWithUTF8String:argv[1]];
    //NSURL *url = [NSURL URLWithString:[string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    //openURL(url);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];

    //[self openScheme: @string];

    //return ret;
    */
    return 0;
}
