namespace CZConnect.Models;

public class EmployeeDto
{
    public required string Name { get; set; }
    public required string Email { get; set; }
    public required string Role { get; set; } 
    public required string Password {get;set;}
    public required string Department {get;set;}
}
