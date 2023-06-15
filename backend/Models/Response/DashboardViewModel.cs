namespace CZConnect.Models;

public class DashboardViewModel 
{
    public List<EmployeeWithCounters> employeeWithCounters { get; set; }
    public int completedReferrals { get; set; }
    public int pendingReferrals { get; set; }
}
