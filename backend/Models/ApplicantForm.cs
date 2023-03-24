using System.ComponentModel.DataAnnotations;

namespace CZConnect.Models;

public class ApplicantForm 
{
    public long Id { get; set; }

    [Required]
    public string Name { get; set; } = string.Empty;

    [Required]
    [EmailAddress]
    public string Email { get; set; } = string.Empty;
}