using CZConnect.Models;
using CZConnect.Models;
internal class DbInit
{
    internal static void Initialize(AppDBContext dbContext)
    {
        ArgumentNullException.ThrowIfNull(dbContext, nameof(dbContext));
        dbContext.Database.EnsureCreated();
        if (!dbContext.Employees.Any()) 
        {
            var employees = new Employee[] 
            {
                new Employee{EmployeeName = "Karel de Groot"},
                new Employee{EmployeeName = "Wilfred de Kok"},
            };
            foreach(var e in employees)
                dbContext.Employees.Add(e);
        } 
        if(!dbContext.Referrals.Any()) 
        {
            var referrals = new Referral[] 
            {   
                new Referral{ParticipantName = "Coen", ParticipantEmail = "koen@mail.com",
                            Status = ReferralStatus.Approved, RegistrationDate = new DateTime(2023, 3, 22), EmployeeId = 1, Employee = null},  
                new Referral{ParticipantName = "Joost Voogd", ParticipantEmail = "joost@exmaple.com",
                            Status = ReferralStatus.Approved, RegistrationDate = new DateTime(2023, 3, 22), EmployeeId = 1, Employee = null},
                new Referral{ParticipantName = "Koen van den Heuvel", ParticipantEmail = "koen@mail.com",
                            Status = ReferralStatus.Approved, RegistrationDate = new DateTime(2023, 3, 22), EmployeeId = 1, Employee = null},
                new Referral{ParticipantName = "Willem Bollekam", ParticipantEmail = "willi@mail.com",
                            Status = ReferralStatus.Pending, RegistrationDate = new DateTime(2023, 2, 8), EmployeeId = 1, Employee = null},
                new Referral{ParticipantName = "Martijn van den Woud", ParticipantEmail = "mvdw@mail.com",
                            Status = ReferralStatus.Denied, RegistrationDate = new DateTime(2023, 1, 5), EmployeeId = 1, Employee = null},
                new Referral{ParticipantName = "Marin Kieplant", ParticipantEmail = "plantje@mail.com",
                            Status = ReferralStatus.Pending, RegistrationDate = new DateTime(2022, 8, 18), EmployeeId = 2, Employee = null},
            };
            foreach(var r in referrals)
                dbContext.Referrals.Add(r);
        }
        dbContext.SaveChanges();
    }
}