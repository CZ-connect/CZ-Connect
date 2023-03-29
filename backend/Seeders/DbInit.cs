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
                new Employee{ Id = 1, EmployeeName = "Jan van Loon"},
                new Employee{ Id = 2, EmployeeName = "Miri Ham"},
            };
            foreach(var e in employees)
                dbContext.Employees.Add(e);
        } 
        if(!dbContext.Referrals.Any()) 
        {
            var referrals = new Referral[] 
            {
                new Referral{Id = 1, ParticipantName = "Koen van den Heuvel", ParticipantEmail = "koen@mail.com",
                            Status = "Approved", RegistrationDate = new DateTime(2023, 3, 22), EmployeeId = 1, Employee = null},
                new Referral{Id = 2, ParticipantName = "Willem Bollekam", ParticipantEmail = "willi@mail.com",
                            Status = "Pending", RegistrationDate = new DateTime(2023, 2, 8), EmployeeId = 1, Employee = null},
                new Referral{Id = 3, ParticipantName = "Martijn van den Woud", ParticipantEmail = "mvdw@mail.com",
                            Status = "Rejected", RegistrationDate = new DateTime(2023, 1, 5), EmployeeId = 1, Employee = null},
                new Referral{Id = 4, ParticipantName = "Marin Kieplant", ParticipantEmail = "plantje@mail.com",
                            Status = "Approved", RegistrationDate = new DateTime(2022, 8, 18), EmployeeId = 2, Employee = null},
            };
            foreach(var r in referrals)
                dbContext.Referrals.Add(r);
        }
        dbContext.SaveChanges();
    }
}