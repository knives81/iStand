#import "Scelta.h"
#import "CampoDinamico.h"

@implementation Scelta

- (NSString*)toString
{
    NSString *str = @"";
	CampoDinamico *campo = self.scelta_campod;
	str= [str stringByAppendingFormat:@"%@\n", [campo toString]];
	
    if(self.scelta_campod.tipo==[NSNumber numberWithInt:0])
    {
		str = [str stringByAppendingFormat:@"\tScelta = ValoreFlag:%@\n",self.valore_flag];
	}
    else if(self.scelta_campod.tipo==[NSNumber numberWithInt:1])
    {
		str = [str stringByAppendingFormat:@"\tScelta = ValoreNote:%@\n",self.valore_nota];
    }
    else if(self.scelta_campod.tipo==[NSNumber numberWithInt:2])
    {
	   str = [str stringByAppendingFormat:@"\tScelta = ValoreMultiple:%@-%@\n",self.valore_multiple, self.posizione_multiple];
    }
    return str;
}

@end
