#import "Partecipante.h"
#import "Scelta.h"

@implementation Partecipante


-(int) getFromWs:(NSString*)urlWs barCode:(NSString*)BarCode
{
		
	NSMutableString *soapMessage = [[NSMutableString alloc]init];
	[soapMessage appendFormat:@"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:tem=\"http://tempuri.org/\"><soapenv:Header/><soapenv:Body><tem:GetDelegate>    <tem:delegateCode>%@</tem:delegateCode><tem:locationCode></tem:locationCode></tem:GetDelegate></soapenv:Body></soapenv:Envelope>",BarCode];
	
	NSURL *url = [NSURL URLWithString:urlWs];
	NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
	ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:url];
	[request setTimeOutSeconds:5];
	[request addRequestHeader: @"Content-Type" value:@"text/xml; charset=utf-8"];
	[request addRequestHeader: @"SOAPAction" value:@"http://tempuri.org/IEStand/GetDelegate"];
	[request addRequestHeader: @"Content-Length" value:msgLength];
	[request setRequestMethod: @"POST"];
	NSMutableData *data = (NSMutableData*)[soapMessage dataUsingEncoding:NSUTF8StringEncoding];
	[request setPostBody:data];
	[request setDelegate:self];
	[request setDidFinishSelector:@selector(requestDone:)];
	[request setDidFailSelector:@selector(requestWentWrong:)];
	
	[request startSynchronous];
	
	NSData *dataReturn = [request responseData];
	NSString *rawXML = [[NSString alloc] initWithData:dataReturn encoding:NSUTF8StringEncoding];
	NSRange range = [rawXML rangeOfString:@"Bad Request"];
	
	//errore ws non raggiungibile o host invalido
	if (range.length >0 || [dataReturn length] == 0)
	{       
		return 1;
	}    
	else
	{
		NSLog(@"rawXML:%@",rawXML);
		
		rawXML = [rawXML stringByReplacingOccurrencesOfString:@"xmlns:s=\"http://schemas.xmlsoap.org/soap/envelope/\"" withString:@""];
		rawXML = [rawXML stringByReplacingOccurrencesOfString:@"xmlns=\"http://tempuri.org/\"" withString:@""];
		rawXML = [rawXML stringByReplacingOccurrencesOfString:@"xmlns:a=\"http://schemas.datacontract.org/2004/07/EStand.ServiceLibrary\"" withString:@""];
		rawXML = [rawXML stringByReplacingOccurrencesOfString: @"xmlns:i=\"http://www.w3.org/2001/XMLSchema-instance\"" withString:@""];
		rawXML = [rawXML stringByReplacingOccurrencesOfString: @"i:" withString:@""];
		rawXML = [rawXML stringByReplacingOccurrencesOfString: @"s:" withString:@""];
		rawXML = [rawXML stringByReplacingOccurrencesOfString: @"a:" withString:@""];
		
		CXMLDocument *doc = [[CXMLDocument alloc] initWithXMLString:rawXML options:0 error:nil];        
		NSArray *nodes = [doc nodesForXPath:@"//GetDelegateResult" error:nil];
		
		//devo prendere solo il primo
		for (CXMLElement *node in nodes) 
		{
			
			NSMutableDictionary *item = [[NSMutableDictionary alloc] init];
			int counter;
			for(counter = 0; counter < [node childCount]; counter++) 
			{
				NSString *valore = [[node childAtIndex:counter] stringValue];
				NSString *nomeCampo = [[node childAtIndex:counter] name];
				[item setObject:valore forKey:nomeCampo];
				
			}
			
			NSString *isError = [item objectForKey:@"Error"];
			NSRange range = [isError rangeOfString:@"true"];
			if(range.location == NSNotFound)
			{        
				self.nome = [item objectForKey:@"FirstName"];        
				self.indirizzo = [item objectForKey:@"Address"];
				self.citta = [item objectForKey:@"City"];
				self.paese = [item objectForKey:@"Country"];
				self.dipartimento = [item objectForKey:@"Department"];
				self.email = [item objectForKey:@"Email"];
				self.istituto = [item objectForKey:@"Institute"];
				self.indirizzo_ist = [item objectForKey:@"InstituteAddress"];
				self.citta_ist = [item objectForKey:@"InstituteCity"];
				self.paese_ist = [item objectForKey:@"InstituteCountry"];
				self.provincia_ist = [item objectForKey:@"InstituteProvince"];
				//self. = [item objectForKey:@"InstituteState"];
				self.cap_ist = [item objectForKey:@"InstituteZip"];
				self.cellulare = [item objectForKey:@"Mobile"];
				self.telefono = [item objectForKey:@"Phone"];
				self.posizione = [item objectForKey:@"Position"];
				self.provincia = [item objectForKey:@"Province"];
				self.cognome = [item objectForKey:@"SecondName"];
				self.specialita = [item objectForKey:@"Specialty"];        
				//self. = [item objectForKey:@"State"];
				self.fax = [item objectForKey:@"Telefax"];
				self.cap = [item objectForKey:@"Zip"];
				self.da_aggiornare = [NSNumber numberWithInt:0];
				return 0;
			}
			//codice non trovato nel db
			else {				
				return 2;               
			}
		}
		//solo se la richiesta al ws Ë andata bene ma non trovo il tag corretto
		return 3;
	}
		
}


-(void)init:(NSString*)barCode
{
	self.codice = barCode;
    self.nome = @"";        
    self.indirizzo = @"";
    self.citta = @"";
    self.paese = @"";
    self.dipartimento = @"";
    self.email = @"";
    self.istituto = @"";
    self.indirizzo_ist = @"";
    self.citta_ist = @"";
    self.paese_ist = @"";
    self.provincia_ist = @"";
    self.cap_ist = @"";
    self.cellulare = @"";
    self.telefono = @"";
    self.posizione = @"";
    self.provincia = @"";
    self.cognome = @"";
    self.specialita = @"";       
    self.fax = @"";
    self.cap = @"";
    self.email_add = @"";
    self.telefono_add = @"";
    self.fax_add = @"";
    self.cellulare_add = @"";
    self.da_aggiornare = [NSNumber numberWithInt:1];
}

- (void)requestDone:(ASIHTTPRequest *)request
{
    request.userInfo = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"OK", @"info", nil];
    NSLog(@"ws finito");
    
}
- (void)requestWentWrong:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"Error Descr %@",error.localizedDescription);
    request.userInfo = [[NSMutableDictionary alloc] initWithObjectsAndKeys:error.localizedDescription, @"info", nil];
}
-(NSString*)toString
{
    NSString *str = @"";
    str= [str stringByAppendingFormat:@"Partecipante: %@ %@ %@", self.codice, self.nome, self.cognome];
	NSSet *setScelte = self.partec_scelta_inv;
    for(Scelta *scelta in setScelte)
	{
        str = [str stringByAppendingFormat:@"%@",[scelta toString]];
		
	}	
    return str;
}


@end
