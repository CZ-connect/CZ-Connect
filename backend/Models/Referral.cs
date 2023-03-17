namespace CZConnect.Models;

public class Referral 
{
    public string Id { get; set; }
    public string ParticipantName { get; set; }
    public string ParticipantEmail { get; set; }
    public string ParticipantEmail { get; set; }
    public string Status { get; set; }
    public DateTime RegistrationDate { get; set; }
    public Employee Employee { get; set; }
}