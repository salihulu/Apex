//Add a field named 'Parent Account' to Account Object
//Add a account record named  'ParentAcc'


//Queueable Class
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

//Anonymous Window
QueueableParantAccount classQue = new QueueableParantAccount();
System.enqueueJob(classQue);
