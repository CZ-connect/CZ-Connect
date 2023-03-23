namespace CZConnect.Models;

public class Referral 
{
    public long id { get; set; }
    public string employeeName { get; set; }
    public string participantEmail { get; set; }
    public string participantName { get; set; }
    public DateTime registrationDate { get; set; }
    public string status { get; set; }
}
