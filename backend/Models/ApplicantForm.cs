namespace CZConnect.Models;

public class ApplicantForm 
{
    public long Id { get; set; }

    [Required]
    public string Name { get; set; } = string.Empty;

    [Required]
    public string Email { get; set; } = string.Empty;
}