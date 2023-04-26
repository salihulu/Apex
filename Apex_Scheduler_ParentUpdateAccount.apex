// QueueAble Class

public class QueueableParantAccount implements Queueable {
    public void execute(QueueableContext context) {
        Account parentAcc = [SELECT ParentId, Id, name FROM Account WHERE name LIKE 'Paren%' LIMIT 1];
        List<Account> acclist = [SELECT ParentId, Id, name FROM Account WHERE id !=: parentAcc.id];
        
        
        for(Account acc : accList){
            acc.parentId = parentAcc.id ;
        }
        
        update accList;
        
    }
}

// Apex_Scheduler Class

public class ScheduleQueueableParent implements Schedulable {
   
    public void execute(SchedulableContext SC) {
       System.enqueueJob(new QueueableParantAccount());
   }
}

// SF Setup > Home > Search: Apex Classes > Schedule Apex
