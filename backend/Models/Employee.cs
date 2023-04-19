namespace CZConnect.Models;

public class Employee
{
    public long Id { get; set; }
    public string EmployeeName { get; set; }
    public long DepartmentId { get;set; }
    public Department? Department { get;set; }
}