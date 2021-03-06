Public Class Reject_Alternate_Form{
Public List<Price_Request_Transaction__c> transactions{Get; set;}
Public List<double> Tiers{get ;set;}
Public List<SAP_Price_Tier__c> SAPTiers{get ;set;}
Public SAP_Price_Tier__c toptier{Get; Set;}
Public String uomoptions{get; set;}
Public String Date_Today{Get; set;}
Public String Date_One_Year{get; set;}
Public string effdate{Get; set;}
Public string expdate{Get; set;}
Public String type{Get; Set;}
Public Static String pacCode{Get; Set;}
Public String application{Get; Set;}
Public String oem{Get; Set;}
Public String SpecifiedMaterial{Get; Set;}
Public String supplier{Get; Set;}
Public String description{Get; Set;}
Public String ExistingBusiness{Get; Set;}
Public String CompetitiveProducer{Get; Set;}
Public String competitivegrade{Get; Set;}
Public Decimal estanualVol{Get; Set;}
Public String estanualUom{Get; Set;}
Public String ContainerForNewMaterial{Get; Set;}
Public String drumdeposit{Get; Set;}
Public String upfront{get; set;}
Public Decimal volume{get ;set;}
Public String volumeuom{get ;set;}
Public String priceuom{get ;set;}
Public String price{get ;set;}
//Public Decimal price{get ;set;}
Public String amid{get ;set;}
Public String reqtier{get ;set;}
Public Decimal eoq{get ;set;}
Public String eoquom{get ;set;}
Public String obtainedfrom{get ;set;}
Public String Competitor{get; set;}
Public String CompetitorId{get; set;}
Public String compuom{get ;set;}
Public Decimal compprice{get ;set;}
Public String CurrencyIsoCode{get; set;}
Map<String, Double> CurrencyMap{get; set;}
Public String PriceProt {Get; Set;}
Public String PriceProtectionOptions{get; set;}
Public String ReasonCode {Get; Set;}
Public String ReasonCodeOptions{get; set;}
Public String PACCodeOptions{get; set;}
Public String comments{get; set;}
Public String appcomments {Get; Set;}
Public String coordcomments {Get; Set;}
Public String FreightTermOptions{get; set;}
Public String Freight{get; set;}
Public String freightMatch{get; set;}

Public boolean prosmaterial{get; set;}

Account_Material__c AM;

Public String psrsupplier{get; set;}
Public String aggrnum{get; set;} 
Public String psreffdate{Get; set;}
Public String psrexpdate{get; set;}
Public String psregion{get; set;}
Public String regionoptions{get; set;}
Public Double suppPrice{get; set;}
Public Double suppdisc1 {get; set;}
Public String plantid{get; set;}
Public String plantname{get; set;}
Public String psfreight{get; set;}
Public String psruom{get; set;}
Public String disc1type{get; set;}
Public String disc2type{get; set;}

Public Reject_Alternate_Form(){}

Public Void FormOnLoad(){
     system.debug('Begin');
     
  String ids = ApexPages.currentpage().getparameters().get('ids');
  String mat= ApexPages.currentpage().getparameters().get('mat');
  String opt= ApexPages.currentpage().getparameters().get('opt');
  system.debug('ids is:'+ids);
  system.debug('opt is:'+opt);
  system.debug('mat parameter is:'+mat);
  uomoptions = '';
  volumeuom = '';
  priceuom = '';
  eoquom = '';
  CurrencyIsoCode = '';
  type='';
  drumdeposit='';
  CompetitorId = '';
  Competitor = '';
  obtainedfrom = '';
  compuom = '';
  PriceProt = '';
  ReasonCode = '';
  comments = '';
  appcomments ='';
  coordcomments = '';
  pacCode= '';
  application='';
  oem='';
  SpecifiedMaterial= '';
  supplier= '';
  description= '';
  ExistingBusiness= '';
  CompetitiveProducer= '';
  competitivegrade= '';
  estanualUom= '';
  ContainerForNewMaterial= '';
  Freight = '';
  freightMatch = '';
   
   CurrencyMap = new Map<String, Double>();
    for(CurrencyType c:[select id, IsoCode, ConversionRate from CurrencyType])
    {
       if(c.isocode != '' && c.isocode != null)
         CurrencyMap.put(c.IsoCode, C.ConversionRate);
    }
    
    system.debug('Beginning');
    
  List <Price_Request_Transaction__c> prtrec = [select Id, 
  Requested_Effective_Date__c,
  Requested_Expiration_Date__c,
  currencyisocode,
  Type__c, 
  Prospect_Material__c,
  Reason_Code__c,
  Requested_Drum_Deposit__c,
  Quantity__c,
  Estimated_Order_Qty_UoM__c,
  Competitor__c,
  Competitor__r.name,
  Competitor_Obtained_From__c,
  Competitive_Price__c,
  Competitive_UoM__c,
  Requested_Price_Protection__c,
  comments__c,  
  Approval_Rejection_Comments__c,
  Coordinator_Comments__c,
  PAC_Code__c,
  Application__c,
  OEM__c,
  Specified_Material__c,
  Existing_Business_for_Customer__c,
  Competitive_Producer__c,
  Competitive_Grade__c,
  Estimated_Annual_Volume__c,
  Estimated_Annual_Volume_UOM__c,
  Description__c,
  Material_Supplier__c,
  Container_for_new_Material__c, Account_Material__r.Freight_Terms__c,
  Account_Material__c, Requested_Tiers__c, SAP_Material__r.name, Freight_Terms__c, CSP_Currency__c
    from Price_Request_Transaction__c where Id =: ids];
    
    if(prtrec.size()>0){    
    amid = prtrec[0].Account_Material__c;
    if(prtrec[0].Requested_Effective_Date__c != null)
        effdate = prtrec[0].Requested_Effective_Date__c.format();
    else
        effdate = '';
    
    if(prtrec[0].Requested_Expiration_Date__c != null)
        expdate = prtrec[0].Requested_Expiration_Date__c.format();
    else
        expdate = '';
    if(CurrencyIsoCode == '')
        CurrencyIsoCode = prtrec[0].CSP_Currency__c;
    //    CurrencyIsoCode = prtrec[0].currencyisocode;

    system.debug('PAC Code is:'+prtrec[0].PAC_Code__c);
    if(pacCode== '')
        pacCode= prtrec[0].PAC_Code__c;
    
    if(application== '')
        application= prtrec[0].Application__c;
    
    if(oem== '')
    oem= prtrec[0].OEM__c;
    
    if(Freight== '' && prtrec[0].Account_Material__r.Freight_Terms__c != null)
    Freight= prtrec[0].Account_Material__r.Freight_Terms__c.escapeHTML4();
        
    
    if(SpecifiedMaterial== '')
    SpecifiedMaterial= prtrec[0].Specified_Material__c;
    
    if(ExistingBusiness== '')
    ExistingBusiness= prtrec[0].Existing_Business_for_Customer__c;
    
    if(CompetitiveProducer== '')
    CompetitiveProducer= prtrec[0].Competitive_Producer__c;
    
    if(competitivegrade== '')
    competitivegrade= prtrec[0].Competitive_Grade__c;
    
    estanualVol= prtrec[0].Estimated_Annual_Volume__c == null ? 0 : prtrec[0].Estimated_Annual_Volume__c.intvalue();
    
    if(estanualUom== '')
    estanualUom= prtrec[0].Estimated_Annual_Volume_UOM__c;
    
    if(description== '')
    description= prtrec[0].Description__c;
    
    if(supplier== '')
    supplier= prtrec[0].Material_Supplier__c;
    system.debug('Supplier is;'+supplier);
    if(ContainerForNewMaterial== '')
    ContainerForNewMaterial= prtrec[0].Container_for_new_Material__c;
    
    
    if(type== '')
        type = prtrec[0].Type__c;
    
    //Added to predefault Type as CSP on form on click of Convert RFQ
    if(opt == 'convert')
         type = 'CSP';
        
    if(drumdeposit== '')
        drumdeposit = prtrec[0].Requested_Drum_Deposit__c;
    //if(eoq== '')
        system.debug(prtrec[0].Quantity__c);
        
        eoq = prtrec[0].Quantity__c == null ? 0 : prtrec[0].Quantity__c.intvalue();
        
    if(eoquom== '')
        eoquom = prtrec[0].Estimated_Order_Qty_UoM__c;
    if(CompetitorId == '' && prtrec[0].Competitor__c != null)
    { CompetitorId = prtrec[0].Competitor__c; 
      Competitor = prtrec[0].Competitor__r.name.escapeHTML4(); }
    if(obtainedfrom == '')
        obtainedfrom = prtrec[0].Competitor_Obtained_From__c;
    if(prtrec[0].Competitive_Price__c != null){
        if(CurrencyIsoCode.contains('4'))
            compprice = prtrec[0].Competitive_Price__c.setscale(4);
        else 
            compprice = prtrec[0].Competitive_Price__c.setscale(2);}
         
        
   // if(Decimal.valueof(compprice).scale()<2)
   //   Decimal.valueof(compprice).setscale(2);
    
    system.debug('compprice is : '+compprice);
    if(compuom == '')
        compuom = prtrec[0].Competitive_UoM__c;
    
    priceprotectionoptions = getPriceProtection();
    ReasonCodeOptions = getReasonCode();
    PACCodeOptions = getpacCode();
    
    
   for(Freight_Terms_Code__c f:Freight_Terms_Code__c.getall().values())
   {
       string freightval = f.Name+'-'+f.Description__c;
       if(freightMatch != 'Yes' && Freight != freightval)
            freightMatch = 'No';
       else 
            freightMatch = 'Yes';
   }
   
   FreightTermOptions = getFreightTerms();
   
    if(ReasonCode == '')
        ReasonCode = prtrec[0].Reason_Code__c;
        
    if(PriceProt == '')
        PriceProt = prtrec[0].Requested_Price_Protection__c;
    
            
    if(comments == '')
        comments = prtrec[0].Comments__c;
    if(appcomments == '')
        appcomments = prtrec[0].Approval_Rejection_Comments__c;
    if(coordcomments == '')
        coordcomments = prtrec[0].Coordinator_Comments__c;
        
    prosmaterial = prtrec[0].Prospect_Material__c;
    system.debug('prosmaterial is : '+prosmaterial);
   }
    Account_Material__c ams;
    if(!prtrec[0].Prospect_Material__c)
        ams = Account_Material_Functions.getPricing(amid);
    else if(mat != null && mat != '')
        ams = Account_Material_Functions.getPricingRFQ(mat,amid).get(0);
    system.debug('Account Material returned:'+ams);
    
    
         
  //Account_Material__c AccountMat =[Select id, UoMs__c from Account_Material__c where id =:amid];
   SAPTiers = new List<SAP_Price_Tier__c>();         
  for(SAP_Price_Tier__c spt:[select id, price__c, volume__c, price_uom__c, volume_uom__c, SAP_Price__c, tpi__c, sap_price__r.price_request_transaction__c, currencyisocode, req_price__c from SAP_Price_Tier__c 
                           where sap_price__r.type__c = 'Requested' and SAP_Price__r.price_request_Transaction__c =:ids ])
   {
      SAPTiers.add(spt);
   }
   //system.debug('SAP Tiers:'+SAPTiers);
 
  if(SAPTiers.size() > 0)
    //SAPTiers.add(1);
  toptier = SAPTiers.remove(0);
   
   for(SAP_Price_Tier__c spt:SAPTiers){
       spt.volume__c = spt.volume__c.intValue();
       spt.price__c = spt.price__c.setscale(4);
   }
   if(toptier !=null){
  //if(volume == '')
     volume = toptier.volume__c == null ? 0:toptier.volume__c.intvalue();
      
  if(volumeuom == '')
     volumeuom = toptier.volume_uom__c;
     system.debug('Toptier volumeuom:'+volumeuom);
 
  price = toptier.req_price__c;
  //price = toptier.price__c.setscale(4);
  
  if(priceuom == '')
     priceuom = toptier.price_uom__c;
      system.debug('Toptier priceuom:'+priceuom);
  
   } 
   psruom = priceuom;
   
  system.debug('After spt query');  
  Set<String> validuoms = new Set<String>();
  
  //Tiers = new List<Double>(); 
  //boolean addtiers = true;
  
  //transactions = Account_material_functions.gettransactions(ams, new map<string, string>());
  
   /*CSP_JSON_Response csps = null;
   if(am.SAP_Data__c != null)
     csps = (csp_JSON_Response)JSON.deserialize(am.SAP_Data__c, CSP_JSON_Response.class);
   
   if(tiers.size() == 0 && csps != null )
   {
     if(csps.tbl_CSP_prices.size() > 0 && addtiers)
     {
     addtiers = false;
     String csp_effective_date = csps.tbl_csp_prices.get(0).csp_effective_date;
     for( CSP_JSON_Response.tbl_CSP_prices pr:csps.tbl_CSP_prices)
      if(pr.csp_volume  != null && pr.csp_volume != '' && pr.csp_effective_date == csp_effective_date)
        tiers.add(stringtodouble(pr.csp_volume));
     }
        
     if(csps.tbl_target_prices.size() > 0 && addtiers)
     {
     addtiers = false;
     for( CSP_JSON_Response.tbl_target_prices tar:csps.tbl_target_prices)
      if(tar.tier_volume != null && tar.tier_volume != '')
        tiers.add(stringtodouble(tar.tier_volume));
     }
   }*/
   
   if((mat != null && mat != '') || prosmaterial == false)
   if(ams.UoMs__c != null && ams.UoMs__c != '')
   {
   system.debug('Inside Validuoms');
   
    //if(i == 0)
      validuoms.addall(ams.UoMs__c.split(';'));
    /*else
    {
      List<String> templist = new list<String>();
      List<String> comparelist = new list<String>();
      for(integer j=0; j<comparelist.size(); j++)
        if(validuoms.contains(comparelist.get(j)))
          templist.add(comparelist.get(j));
      templist.sort();
      validuoms.clear();
      validuoms.addall(templist);
    }*/

   }   
  
  List<String> alluoms = new list<String>();
  alluoms.addall(validuoms);
  alluoms.sort();
  for(string s:alluoms)
    uomoptions += '<option value="' + s + '">' + s + '</option>';
  system.debug('UoM:'+uomoptions);
  
  /*if(tiers.size() == 0)
    tiers.add(1);
    toptier = tiers.remove(0);*/
   psreffdate = effdate;
   psrexpdate = expdate;
   String psId= ApexPages.currentpage().getparameters().get('psId');
   System.debug('psId is:'+psId);
   List<SAP_Price_Support__c> ps = new List<SAP_Price_Support__c>();
   
   if(psId != '' && psId != null)
   {
       ps = [Select Id, Agreement_Number__c, Supplier_Name__c, Supplier_Number__c, Supplier_Supported_Price__c, X1st_Discount_Sell__c, Region_Code__c, Region_Description__c from SAP_Price_Support__c where id =: psId];
       if(ps.size()> 0)
       {
           psrsupplier = '';
           aggrnum = '';
           psregion = '';
            
                    
           psrsupplier = ps[0].Supplier_Name__c+' - '+ps[0].Supplier_Number__c;            
           aggrnum = ps[0].Agreement_Number__c;
           psregion = ps[0].Region_Code__c;
           suppPrice = ps[0].Supplier_Supported_Price__c;
           suppdisc1 = ps[0].X1st_Discount_Sell__c;
           
       }
   }
   if(aggrnum != null && aggrnum.contains('U')){
       upfront ='true';    
       system.debug('------'+upfront);
   }
   else{
       upfront ='false';
   } 
   regionoptions = getPSRegion(); 
}



Public string getPSRegion(){
     String region = '';
     List<String> regionlst = new list<String>();

     for(PlantRegion__c p:PlantRegion__c.getall().values())
     {
       if(p.code__c != null)
       regionlst.add(p.code__c + ' - ' + p.name);
       else
       regionlst.add(p.name);

     }
     regionlst.sort();
     for(String s:regionlst){
        region +=  '<option value="' + s + '" label="' + s + '"';
        if(psregion != '' && psregion != null){
        if(s.contains(psregion))
          region += ' selected="selected" ';}
        region += '>' + s + '</option>';
     }
     system.debug('region:'+region);
     return region;
}

Private static string getPriceProtection(){
     String PriceProtection = '';
     List<String> protections = new list<String>();

     for(Price_Protection_Codes__c p:Price_Protection_Codes__c.getall().values())
     {
       if(p.code__c != null)
       protections.add(p.code__c + ' - ' + p.name);
       else
       protections.add(p.name);

     }
     protections.sort();
     for(String s:protections){
        PriceProtection +=  '<option value="' + s + '" label="' + s + '"';
        if(s == 'Default Protection')
          PriceProtection += ' selected="selected" ';
        PriceProtection += '>' + s + '</option>';
     }
     return PriceProtection;
}

Private static string getpacCode(){
     String pacCodelist= '';
     List<String> pacCodes = new list<String>();

     for(PAC_Code__c p:PAC_Code__c.getall().values())
     {
       if(p.name != null)
       pacCodes.add(p.name + ' - ' + p.code__c);
       else
       pacCodes.add(p.code__c);

     }
     pacCodes.sort();
     system.debug('PAC Codes are:'+pacCodes);
     for(String s:pacCodes){
        pacCodelist +=  '<option value="' + s + '" label="' + s + '"';
        if(s == pacCode)
          pacCodelist += ' selected="selected" ';
        pacCodelist += '>' + s + '</option>';
     }
     return pacCodelist;
}

Private static string getReasonCode(){
     String ReasonCode = '';
     List<String> codes = new list<String>();

     for(Reason_Codes__c p:Reason_Codes__c.getall().values())
       codes.add(p.name);
     
     codes.sort();
     
     for(String s:codes){
        ReasonCode +=  '<option value="' + s + '" label="' + s + '"';
        ReasonCode += '>' + s + '</option>';
     }
     return ReasonCode;
}

Public string getFreightTerms(){
String Freightstring = '';
     List<String> freightList = new list<String>();
     for(Freight_Terms_Code__c f:Freight_Terms_Code__c.getall().values())
     {
       if(f.name != null)
         if(freight != f.name + '-' + f.Description__c)
           freightList.add(f.name + '-' + f.Description__c);
       //else
         //  freightList.add(f.name);
     }
     freightList.add(freight);
     freightList.sort();
     
     for(String f:freightList){
        FreightString +=  '<option value="' + f + '" label="' + f + '"';
        if(Freight != null && Freight != '')
            if(f.contains(Freight))
                FreightString += ' selected="selected" ';
        FreightString += '>' + f.escapehtml4() + '</option>';
     }
     system.debug('FreightString :'+FreightString );
     return FreightString;

}
   
public static Double Stringtodouble(Double d){ return d; }
public static Double Stringtodouble(Decimal d){ return Double.valueof(d); }
public static Double stringtodouble(String sIn){
  string temp = '';
  if(sIn != '' && sIn != null)
  {
    if(sIn.contains('-'))
    {  temp = sIn.replaceall('-', '');
       temp = '-' + temp;
    }
    else{ temp = sIn; }
    if(temp.contains(','))
      temp = temp.replaceall(',','');
    return double.valueof(temp);
  }
  else{ return null; }
} 



}