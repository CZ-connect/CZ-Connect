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
                new Employee { EmployeeName = "Jan van Loon", Role = EmployeeRole.Admin },
                new Employee { EmployeeName = "Miri Ham", Role = EmployeeRole.Recruitment }
            };
            foreach(var e in employees)
                dbContext.Employees.Add(e);
        }

        if (!dbContext.Referrals.Any()) 
        {
            var referrals = new Referral[]
            {
                new Referral{ ParticipantName = "Coen", ParticipantEmail = "koen@mail.com",
                            Status = ReferralStatus.Approved, RegistrationDate = new DateTime(2023, 3, 22),
                            EmployeeId = 1, Employee = null },  
                new Referral{ ParticipantName = "Koen van den Heuvel", ParticipantEmail = "jos@exmaple.com",
                            Status = ReferralStatus.Approved, RegistrationDate = new DateTime(2023, 3, 22),
                            EmployeeId = 1, Employee = null },
                new Referral{ ParticipantName = "Koen van den Heuvel", ParticipantEmail = "koen@mail.com",
                            Status = ReferralStatus.Approved, RegistrationDate = new DateTime(2023, 3, 22),
                            EmployeeId = 1, Employee = null },
                new Referral{ ParticipantName = "Willem Bollekam", ParticipantEmail = "willi@mail.com",
                            Status = ReferralStatus.Pending, RegistrationDate = new DateTime(2023, 2, 8),
                            EmployeeId = 1, Employee = null },
                new Referral{ ParticipantName = "Martijn van den Woud", ParticipantEmail = "mvdw@mail.com",
                            Status = ReferralStatus.Denied, RegistrationDate = new DateTime(2023, 1, 5),
                            EmployeeId = 1, Employee = null },
                new Referral{ ParticipantName = "Marin Kieplant", ParticipantEmail = "plantje@mail.com",
                            Status = ReferralStatus.Pending, RegistrationDate = new DateTime(2022, 8, 18),
                            EmployeeId = 2, Employee = null },
            };
            foreach(var r in referrals)
                dbContext.Referrals.Add(r);
        }

        if (!dbContext.GraphData.Any()) 
        {
            var graphData = new GraphData[]
            {
                new GraphData{ Date = new DateTime(2023, 4, 1), AmmountOfNewReferrals = 12, AmmountOfApprovedReferrals = 2 },
                new GraphData{ Date = new DateTime(2023, 3, 1), AmmountOfNewReferrals = 8, AmmountOfApprovedReferrals = 4 },
                new GraphData{ Date = new DateTime(2023, 2, 1), AmmountOfNewReferrals = 5, AmmountOfApprovedReferrals = 3 },
                new GraphData{ Date = new DateTime(2023, 1, 1), AmmountOfNewReferrals = 14, AmmountOfApprovedReferrals = 9 },
                new GraphData{ Date = new DateTime(2022, 12, 1), AmmountOfNewReferrals = 13, AmmountOfApprovedReferrals = 7 },
                new GraphData{ Date = new DateTime(2022, 11, 1), AmmountOfNewReferrals = 11, AmmountOfApprovedReferrals = 6 },
                new GraphData{ Date = new DateTime(2022, 10, 1), AmmountOfNewReferrals = 12, AmmountOfApprovedReferrals = 9 },
                new GraphData{ Date = new DateTime(2022, 9, 1), AmmountOfNewReferrals = 9, AmmountOfApprovedReferrals = 5 },
                new GraphData{ Date = new DateTime(2022, 8, 1), AmmountOfNewReferrals = 8, AmmountOfApprovedReferrals = 6 },
                new GraphData{ Date = new DateTime(2022, 7, 1), AmmountOfNewReferrals = 16, AmmountOfApprovedReferrals = 11 },
                new GraphData{ Date = new DateTime(2022, 6, 1), AmmountOfNewReferrals = 20, AmmountOfApprovedReferrals = 6 },
                new GraphData{ Date = new DateTime(2022, 5, 1), AmmountOfNewReferrals = 18, AmmountOfApprovedReferrals = 9 },
                new GraphData{ Date = new DateTime(2022, 4, 1), AmmountOfNewReferrals = 11, AmmountOfApprovedReferrals = 10 },
                new GraphData{ Date = new DateTime(2022, 3, 1), AmmountOfNewReferrals = 10, AmmountOfApprovedReferrals = 2 },
                new GraphData{ Date = new DateTime(2022, 2, 1), AmmountOfNewReferrals = 14, AmmountOfApprovedReferrals = 3 },
                new GraphData{ Date = new DateTime(2022, 1, 1), AmmountOfNewReferrals = 18, AmmountOfApprovedReferrals = 1 },
                new GraphData{ Date = new DateTime(2021, 12, 1), AmmountOfNewReferrals = 17, AmmountOfApprovedReferrals = 5 },
                new GraphData{ Date = new DateTime(2021, 11, 1), AmmountOfNewReferrals = 8, AmmountOfApprovedReferrals = 6 },
                new GraphData{ Date = new DateTime(2021, 10, 1), AmmountOfNewReferrals = 12, AmmountOfApprovedReferrals = 9 },
                new GraphData{ Date = new DateTime(2021, 9, 1), AmmountOfNewReferrals = 14, AmmountOfApprovedReferrals = 10 },
                new GraphData{ Date = new DateTime(2021, 8, 1), AmmountOfNewReferrals = 10, AmmountOfApprovedReferrals = 5 },
                new GraphData{ Date = new DateTime(2021, 7, 1), AmmountOfNewReferrals = 9, AmmountOfApprovedReferrals = 4 },
                new GraphData{ Date = new DateTime(2021, 6, 1), AmmountOfNewReferrals = 16, AmmountOfApprovedReferrals = 9 },
                new GraphData{ Date = new DateTime(2021, 5, 1), AmmountOfNewReferrals = 17, AmmountOfApprovedReferrals = 4 },
                new GraphData{ Date = new DateTime(2021, 4, 1), AmmountOfNewReferrals = 11, AmmountOfApprovedReferrals = 7 },
                new GraphData{ Date = new DateTime(2021, 3, 1), AmmountOfNewReferrals = 12, AmmountOfApprovedReferrals = 9 },
                new GraphData{ Date = new DateTime(2021, 2, 1), AmmountOfNewReferrals = 14, AmmountOfApprovedReferrals = 4 },
                new GraphData{ Date = new DateTime(2021, 1, 1), AmmountOfNewReferrals = 15, AmmountOfApprovedReferrals = 7 }
            };
            foreach(var d in graphData)
                dbContext.GraphData.Add(d);
        }
        dbContext.SaveChanges();
    }
}