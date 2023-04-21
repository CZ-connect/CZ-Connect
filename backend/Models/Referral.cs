namespace CZConnect.Models;

public class Referral 
{
    public long Id { get; set; }
    public string ParticipantName { get; set; }

    public ReferralStatus Status { get; set; }
    public string? ParticipantEmail { get; set; }
    public string? ParticipantPhoneNumber { get; set; }
    public DateTime RegistrationDate { get; set; }
    public long EmployeeId { get; set; }
    public Employee? Employee { get; set; }
}