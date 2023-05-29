namespace CZConnect.Models;

public class Employee
{
    public long Id { get; set; }
    public string EmployeeEmail { get; set; } = string.Empty;
    public long? DepartmentId { get;set; } 
    public Department? Department;
    public string EmployeeName { get; set; } = string.Empty;
    public EmployeeRole Role { get; set; }
    public string PasswordHash {get;set;} = string.Empty;
    
}
