namespace CZConnect.Models;

public class EmployeeWithCounters
{
    public Employee employee { get; set; }
    public int referralCounter { get; set; }

    public EmployeeWithCounters(Employee _employee, int _referralCounter)
    {
        this.employee = _employee;
        this.referralCounter = _referralCounter;
    }
}
