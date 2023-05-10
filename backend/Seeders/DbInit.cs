using CZConnect.Models;

internal class DbInit
{
    internal static void Initialize(AppDBContext dbContext)
    {
        try
        {
            ArgumentNullException.ThrowIfNull(dbContext, nameof(dbContext));
            dbContext.Database.EnsureCreated(); 
            if (!dbContext.Departments.Any())
            {
                var departments = new Department[]
                {
                    new() {DepartmentName = "Sales"},
                    new() {DepartmentName = "Finance"},
                    new() {DepartmentName = "Human Resources"},
                    new() {DepartmentName = "Marketing"},
                    new() {DepartmentName = "ICT"},
                    new() {DepartmentName = "Recruitment"},
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
                List<Referral> referrals = GenerateRandomReferrals(1000);
                foreach(var r in referrals)
                    dbContext.Referrals.Add(r);
            }
        
            dbContext.SaveChanges();
        }
        catch (Exception e)
        {
            Console.WriteLine(e);
            throw;
        }
        
    }

    private static List<Employee> GenerateRandomEmployees(int amount)
    {
        List<Employee> employees = new List<Employee>();
        int departmentId = 1;
        for(int i=0; i < amount; i++)
        {
            employees.Add(new Employee(){
                EmployeeName = GetDutchName(),
                EmployeeEmail = String.Concat(GetDutchName().Where(n => !Char.IsWhiteSpace(n))) + "@example.com",
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
                ParticipantName = GetDutchName(),
                ParticipantEmail = String.Concat(GetDutchName().Where(n => !Char.IsWhiteSpace(n))) + "@example.com",
                Status = GetRandomStatus(),
                RegistrationDate = GetRandomDate(),
                EmployeeId = random.Next(1,30),
            };
            referrals.Add(referral);
        }

        return referrals;
    }

    private static string GetDutchName()
    {
        Random random = new Random();
        
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
        return dutchNames[random.Next(0, dutchNames.Length)];
    }
    private static ReferralStatus GetRandomStatus()
    { 
        ReferralStatus[] statuses = (ReferralStatus[])Enum.GetValues(typeof(ReferralStatus));
        Random random = new Random();
        return statuses[random.Next(0, statuses.Length)];
    }
    private static DateTime GetRandomDate()
    { 
        Random random = new Random();
        DateTime start = new DateTime(2023, 1, 1);
        int range = (DateTime.Today - start).Days;
        return start.AddDays(random.Next(range));
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
    private static ReferralStatus GetRandomStatus()
    { 
        ReferralStatus[] statuses = (ReferralStatus[])Enum.GetValues(typeof(ReferralStatus));
        Random random = new Random();
        return statuses[random.Next(0, statuses.Length)];
    }
    private static DateTime GetRandomDate()
    { 
        Random random = new Random();
        DateTime start = new DateTime(2023, 1, 1);
        int range = (DateTime.Today - start).Days;
        return start.AddDays(random.Next(range));
    }
}