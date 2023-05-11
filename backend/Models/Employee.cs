namespace CZConnect.Models;

public class Employee
{
    public long Id { get; set; }
    public string EmployeeName { get; set; } = string.Empty;
    public EmployeeRole Role { get; set; }

    public string Username {get;set;} = string.Empty;
    public string PasswordHash {get;set;} = string.Empty;
    
}