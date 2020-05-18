/*
trigger trgUpdCntBsdOnAct on Account (before insert) {

    Set<Id> acctId = new Set<Id>();

    for(Account actId : Trigger.new){
        acctId.add(actId.Id);
    }

    //extract contact records that relates to the affected accountid
    Map<Id,Contact> cntMaps = new Map<Id,String>([select id, MailingCity from Contact where accountid= :acctId and MailingCity = 'San Francisco']);
    List<Contact> cntToUdpate = new List<Contact>();

    for(Contact c : cntMpas){
        c.Trad_Show_Member__c = true;
        cntToUdpate.add(c);
    }

    udpate cntToUdpate;


    //update contact records

}
*/
trigger trgUpdCntBsdOnAct on Account (before insert) {

    //A single soql to retrieve records based on trigger object
    List<Account> accts = new List<Account>();
    for(Account act : [select Id, (select Id, MailingCity from Contacts) from Account where id in :Trigger.newMap.keySet()]){
        accts.add(act);
    }

    //define collection to collect records that are updated and on whom dml has to be run
    List<Contact> cntToUdpate = new List<Contact>();

    for(Account at : accts){
        for(Contact c : at.contacts){
            c.Trad_Show_Member__c = true;
            cntToUdpate.add(c);
        }

    }
    udpate cntToUdpate;


    //update contact records

}