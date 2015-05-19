global with sharing class TESMessage {
	public String uuid { get; set; }
	public String subject { get; set; }
	public String account_email_address { get; set; }
	public String tes_mailbox_address { get; set; }
	public String body { get; set; }
	public String message_id { get; set; }
	public String references_header { get; set; }
	public Long recieveDate { get; set; }
	
	public DateTime getDate() {
		return DateTime.newInstance(recieveDate);
	}
}