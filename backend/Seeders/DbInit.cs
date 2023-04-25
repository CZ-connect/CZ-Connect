using CZConnect.Models;

internal class DbInit
{
    internal static void Initialize(AppDBContext dbContext)
    {
        ArgumentNullException.ThrowIfNull(dbContext, nameof(dbContext));
        dbContext.Database.EnsureCreated(); 
        if (!dbContext.Departments.Any())
        {
            var departments = new Department[]
            {
                new Department{DepartmentName = "Sales"},
                new Department{DepartmentName = "Finance"},
                new Department{DepartmentName = "Human Resources"},
                new Department{DepartmentName = "Marketing"},
                new Department{DepartmentName = "ICT"},
                new Department{DepartmentName = "Recruitment"},
            };
            foreach(var d in departments)
                dbContext.Departments.Add(d);
        }
        if (!dbContext.Employees.Any()) 
        {
            List<Employee> employees = GenerateRandomEmployees(30);
            foreach(var e in employees)
                dbContext.Employees.Add(e);
        } 
       
        if(!dbContext.Referrals.Any()) 
        {
            List<Referral> referrals = GenerateRandomReferrals(100);
            foreach(var r in referrals)
                dbContext.Referrals.Add(r);
        }
        
        dbContext.Database.EnsureCreated();

        if (!dbContext.Employees.Any()) 
        {
            var departments = new Department[]
            {

                new() { EmployeeName = "Jan van Loon", Role = EmployeeRole.Admin },
                new() { EmployeeName = "Miri Ham", Role = EmployeeRole.Recruitment }

                new Department{DepartmentName = "Sales"},
                new Department{DepartmentName = "Finance"},
                new Department{DepartmentName = "Human Resources"},
                new Department{DepartmentName = "Marketing"},
                new Department{DepartmentName = "ICT"},
                new Department{DepartmentName = "Recruitment"},
            };
            foreach(var d in departments)
                dbContext.Departments.Add(d);
        }
        if (!dbContext.Employees.Any()) 
        {
            List<Employee> employees = GenerateRandomEmployees(30);
            foreach(var e in employees)
                dbContext.Employees.Add(e);
        }

        if (!dbContext.Referrals.Any()) 
        } 
       
        if(!dbContext.Referrals.Any()) 
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
            List<Referral> referrals = GenerateRandomReferrals(100);
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

    private static List<Employee> GenerateRandomEmployees(int amount)
    {
        List<Employee> employees = new List<Employee>();
        int departmentId = 1;
        for(int i=0; i < amount; i++)
        {
            employees.Add(new Employee(){
                EmployeeName = GetDutchName(i),
                EmployeeEmail = String.Concat(GetDutchName(i).Where(n => !Char.IsWhiteSpace(n))) + "@example.com",
                DepartmentId = departmentId });
            if(i % 6 == 0)
            {
                departmentId+=1;
            }
        }
        return employees;
    }

    private static List<Referral> GenerateRandomReferrals(int amount)
    {
        List<Referral> referrals = new List<Referral>();
        Random random = new Random();
        
        for(int i=0; i < amount; i++)
        {
            Referral referral = new Referral
            {
                ParticipantName = GetDutchName(i),
                ParticipantEmail = String.Concat(GetDutchName(i).Where(n => !Char.IsWhiteSpace(n))) + "@example.com",
                Status = GetRandomStatus(),
                RegistrationDate = GetRandomDate(),
                EmployeeId = random.Next(1,30),
            };
            referrals.Add(referral);
        }

        return referrals;
    }

    private static string GetDutchName(int position)
    {
        string[] dutchNames = new string[] 
        { "Daan de Vries", "Sofie Jansen", "Liam van der Berg", "Emma van Dijk", "Lucas de Boer", "Julia Peters", "Milan Bakker", "Sara van der Meer",
            "Levi Visser", "Lotte de Jong", "Luuk van den Brink", "Zoë Hendriks", "Bram van Leeuwen", "Anna van der Linden", "Jesse Smit", "Noa van Beek",
            "Thijs van der Velde", "Tess Mulder", "Finn Janssen", "Eva Vermeer", "Tim de Graaf", "Isa Kuijpers", "Julian Jacobs", "Lynn Schouten", "Sem Hoekstra",
            "Evi Willemsen", "Ruben van der Laan", "Sarah Groen", "Tygo van der Pol", "Fleur Koster", "Daan van Vliet", "Sophie Hermans", "Max van der Wal",
            "Lauren Visser", "Bram van der Heijden", "Lieke van der Meulen", "Noud Smits", "Mila Vos", "Luuk van den Bosch", "Roos de Wit", "Hugo de Haan",
            "Isa van Veen", "Boaz van den Broek", "Elin Vermeulen", "Jayden Mulders", "Maud van der Heuvel", "Dex Koning", "Yara Dekker", "Stijn van der Woude",
            "Vera Meijer", "Timo Willems", "Lynn van der Poel", "Jelle van den Bosch", "Elin van der Horst", "Daniël Dekker", "Liv van Dijk", "Lucas van de Ven",
            "Emily Smeets", "Joep van der Berg", "Lotte van de Brink", "Daan Jansen", "Mila van der Wal", "Thijs Kuijpers", "Anna Koster", "Mees van Beek",
            "Julia de Vries", "Sem Peters", "Sarah de Jong", "Jesse de Boer", "Tess Vermeer", "Julian de Graaf", "Fenna Visser", "Bram Smit", "Lynn de Wit",
            "Finn Schouten", "Roos van der Laan", "Tygo Vermeulen", "Isa van der Velde", "Hugo Vos", "Lieke Groen", "Dex Hermans", "Noud van der Linden",
            "Vera van der Meer", "Boaz Hoekstra", "Maud van der Pol", "Yara Jacobs", "Luuk Willemsen", "Emily van Leeuwen", "Daniël Mulder", "Liv van der Heijden",
            "Timo Dekker", "Elin Koning", "Jayden Meijer", "Sophie van Vliet", "Jelle Willems", "Lotte Smits", "Stijn van der Poel", " Mees van Dijk",
            "Julia de Wit", "Evi van Veen",
        };
        return dutchNames[position];
    }
    private static string GetRandomStatus()
    {
        string[] status = { "Goedgekeurd", "In Afwachting", "Afgewezen" };
        Random random = new Random();
        return status[random.Next(0, status.Length)];
    }
    private static DateTime GetRandomDate()
    { 
        Random random = new Random();
        DateTime start = new DateTime(2022, 1, 1);
        int range = (DateTime.Today - start).Days;
        return start.AddDays(random.Next(range));
    }
}