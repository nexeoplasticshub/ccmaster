@isTest

public class SendOpportunityUpdate_test{

    public static testMethod void testMe(){
        
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        User u = new User(Alias = 'standt1', Email='nn@testorg.com',EmailEncodingKey='UTF-8', LastName='Nexeo_Integration User', LanguageLocaleKey='en_US', LocaleSidKey='en_US', ProfileId = p.Id, 
        TimeZoneSidKey='America/Los_Angeles', UserName='ksbc@gorg.com', IsActive = true);
        insert u;
        account acc = new account(name = 'test1234');
        insert acc;
        contact cnt = new contact(LastName = 'test',Account = acc,phone= '1234567890',Role__c = 'Accounting',No_Email__c = true);
        insert cnt;
        //Nexeo_Competitor__c nc = new Nexeo_Competitor__c(name = 'test',Status__c='Active',RecordTypeid='012E0000000LH70');
        Id RecordTypeId = Schema.SObjectType.Nexeo_Competitor__c.getRecordTypeInfosByName().get('Supplier').getRecordTypeId();
        Nexeo_Competitor__c nc = new Nexeo_Competitor__c(name = 'test',Status__c='Active',RecordTypeid=RecordTypeId);
        insert nc;
        opportunity op = new opportunity(name = 'Distribution Plastics',CurrencyIsoCode = 'AUD',Customer_Prospect__c = acc.id,Requested_Supplier__c = nc.id,Contact__c = cnt.id,CloseDate = system.today(),StageName = 'Concept');
        insert op;
        Supplier_Contact__c scon = new Supplier_Contact__c(First_Name__c = 'test',Competitor_Supplier_or_OEM__c = nc.id);
        insert scon;
        Opportunity_Call_Report__c ocr = new Opportunity_Call_Report__c(Opportunity__c = op.id,Supplier_Contact__c = scon.id,Employee__c = u.id);
        insert ocr;
        //EmailTemplate em = new EmailTemplate(name = 'testr');
        //insert em;
        
        //ApexPages.currentPage().getParameters().put('tid',em.id);
        ApexPages.standardcontroller sc = new ApexPages.standardcontroller(ocr);
        SendOpportunityUpdate s = new SendOpportunityUpdate(sc);
        SendOpportunityUpdate.wrapperclass w = new SendOpportunityUpdate.wrapperclass(scon);
        try{
        s.sendEmail();
        }
        catch (exception e){}
        }
    }