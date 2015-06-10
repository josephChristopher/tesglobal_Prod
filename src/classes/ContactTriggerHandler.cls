public class ContactTriggerHandler extends Reach.TriggerHandlerFactory {
	
    public override void beforeInsert() {
        System.debug('Before Insert');
      
    }
    
    public override void beforeUpdate() {
        System.debug('Before Update');

      
    }
    
	public override void afterInsert() 
	{
        System.debug('After Insert');

	}



	public override void afterUpdate() {
        updateB2CAccounts();
	}
    
    
    private void updateB2CAccounts() {
        if (!B2CSyncRecursiveCheck.hasSyncAlreadyRun())
            new B2CAccountUpdater((List<Contact>) Trigger.new).updateAccounts();
    }

    
	
	
    
    
}