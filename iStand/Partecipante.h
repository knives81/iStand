#import "_Partecipante.h"
#import "ASIHTTPRequest.h"
#import "TouchXML.h"



@interface Partecipante : _Partecipante {}

-(int) getFromWs:(NSString*)urlWs barCode:(NSString*)BarCode;
-(void)init:(NSString*)barCode;
- (void)requestWentWrong:(ASIHTTPRequest *)request;
- (void)requestDone:(ASIHTTPRequest *)request;
-(NSString*)toString;
@end
