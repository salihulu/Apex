public class ScheduleableOpenOppReminder implements Schedulable {
   
    public void execute(SchedulableContext SC) {

    List<Opportunity> oppList = [SELECT IsClosed, Id, CloseDate FROM Opportunity Where IsClosed=false AND CloseDate< TODAY];
        if(oppList.size() > 0){
            List<Task> taskList = new List <Task>();
            
            for(Opportunity opp : oppList){
                
             Task tsk= new Task();
                       
             tsk.Subject = 'Opp Close date Passed';
             tsk.Status = 'Not Started';
             tsk.WhatId = opp.id;
             tsk.OwnerId = opp.OwnerId;
             tsk.ActivityDate = Date.today() + 3 ; // DueDate
             taskList.add(tsk);
            
        }
        
        insert taskList ; 
            
        }
    
    }
}
