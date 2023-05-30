namespace CZConnect.Models;

public class EmployeeDtoUpdate
{
    public required string Name { get; set; }
    public required string Email { get; set; }
    public required string Department {get;set;}
    public required string Role {get;set;}
    public required bool Verified {get;set;}
}
