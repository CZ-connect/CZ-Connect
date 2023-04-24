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

                new() { EmployeeName = "Jan van Loon", Role = EmployeeRole.Admin },
                new() { EmployeeName = "Miri Ham", Role = EmployeeRole.Recruitment }

            };
            foreach(var e in employees)
                dbContext.Employees.Add(e);
        }

        if (!dbContext.Referrals.Any()) 
        {
            var referrals = new[]
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
            var graphData = new[]
            {
                new GraphData{ Year = 2023, Month = 4, AmmountOfNewReferrals = 12, AmmountOfApprovedReferrals = 2 },
                new GraphData{ Year = 2023, Month = 3, AmmountOfNewReferrals = 8, AmmountOfApprovedReferrals = 4 },
                new GraphData{ Year = 2023, Month = 2, AmmountOfNewReferrals = 5, AmmountOfApprovedReferrals = 3 },
                new GraphData{ Year = 2023, Month = 1, AmmountOfNewReferrals = 14, AmmountOfApprovedReferrals = 9 },
                new GraphData{ Year = 2022, Month = 12, AmmountOfNewReferrals = 13, AmmountOfApprovedReferrals = 7 },
                new GraphData{ Year = 2022, Month = 11, AmmountOfNewReferrals = 11, AmmountOfApprovedReferrals = 6 },
                new GraphData{ Year = 2022, Month = 10, AmmountOfNewReferrals = 12, AmmountOfApprovedReferrals = 9 },
                new GraphData{ Year = 2022, Month = 9, AmmountOfNewReferrals = 9, AmmountOfApprovedReferrals = 5 },
                new GraphData{ Year = 2022, Month = 8, AmmountOfNewReferrals = 8, AmmountOfApprovedReferrals = 6 },
                new GraphData{ Year = 2022, Month = 7, AmmountOfNewReferrals = 16, AmmountOfApprovedReferrals = 11 },
                new GraphData{ Year = 2022, Month = 6, AmmountOfNewReferrals = 20, AmmountOfApprovedReferrals = 6 },
                new GraphData{ Year = 2022, Month = 5, AmmountOfNewReferrals = 18, AmmountOfApprovedReferrals = 9 },
                new GraphData{ Year = 2022, Month = 4, AmmountOfNewReferrals = 11, AmmountOfApprovedReferrals = 10 },
                new GraphData{ Year = 2022, Month = 3, AmmountOfNewReferrals = 10, AmmountOfApprovedReferrals = 2 },
                new GraphData{ Year = 2022, Month = 2, AmmountOfNewReferrals = 14, AmmountOfApprovedReferrals = 3 },
                new GraphData{ Year = 2022, Month = 1, AmmountOfNewReferrals = 18, AmmountOfApprovedReferrals = 1 },
                new GraphData{ Year = 2021, Month = 12, AmmountOfNewReferrals = 17, AmmountOfApprovedReferrals = 5 },
                new GraphData{ Year = 2021, Month = 11, AmmountOfNewReferrals = 8, AmmountOfApprovedReferrals = 6 },
                new GraphData{ Year = 2021, Month = 10, AmmountOfNewReferrals = 12, AmmountOfApprovedReferrals = 9 },
                new GraphData{ Year = 2021, Month = 9, AmmountOfNewReferrals = 14, AmmountOfApprovedReferrals = 10 },
                new GraphData{ Year = 2021, Month = 8, AmmountOfNewReferrals = 10, AmmountOfApprovedReferrals = 5 },
                new GraphData{ Year = 2021, Month = 7, AmmountOfNewReferrals = 9, AmmountOfApprovedReferrals = 4 },
                new GraphData{ Year = 2021, Month = 6, AmmountOfNewReferrals = 16, AmmountOfApprovedReferrals = 9 },
                new GraphData{ Year = 2021, Month = 5, AmmountOfNewReferrals = 17, AmmountOfApprovedReferrals = 4 },
                new GraphData{ Year = 2021, Month = 4, AmmountOfNewReferrals = 11, AmmountOfApprovedReferrals = 7 },
                new GraphData{ Year = 2021, Month = 3, AmmountOfNewReferrals = 12, AmmountOfApprovedReferrals = 9 },
                new GraphData{ Year = 2021, Month = 2, AmmountOfNewReferrals = 14, AmmountOfApprovedReferrals = 4 },
                new GraphData{ Year = 2021, Month = 1, AmmountOfNewReferrals = 15, AmmountOfApprovedReferrals = 7 }
            };
            foreach(var d in graphData)
                dbContext.GraphData.Add(d);
        }
        dbContext.SaveChanges();
    }
}