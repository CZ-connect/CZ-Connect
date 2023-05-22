using Microsoft.AspNetCore.Mvc;
using CZConnect.Models;
using CZConnect.DAL;
using System.Security.Claims;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Text;

namespace CZConnect.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class EmployeeController : ControllerBase
    {
        private readonly IRepository _repository;
        private readonly IConfiguration _configuration;

        public EmployeeController(IConfiguration configuration, IRepository repository){
            _configuration = configuration;
            _repository = repository;
        }

        [HttpPost("register")]
        public async Task<ActionResult<Employee>> Register(EmployeeDto request)
        {
            string passwordHash = BCrypt.Net.BCrypt.HashPassword(request.Password);
            if (!Enum.TryParse(request.Role, out EmployeeRole role))
            {
                return BadRequest("Ongeldige rol toegevoegd.");
            }

            Employee employee = new Employee
            {
                EmployeeEmail= request.Email,
                EmployeeName = request.Name,
                PasswordHash = passwordHash,
		DepartmentId = 1,
                Role = role
            };

            await _repository.CreateAsync<Employee>(employee);
            return CreatedAtAction(nameof(GetEmployee), new { id = employee.Id }, employee);
        }



        [HttpPost("login")]
        public async Task<ActionResult<Employee>> Login(EmployeeLoginDto request)
        {
            var employee = await _repository.FindByAsync<Employee>(e => e.EmployeeEmail == request.Email);

            if (employee == null)
            {
                return BadRequest("Verkeerde email of wachtwoord ingevuld");
            }
          
            if (!BCrypt.Net.BCrypt.Verify(request.Password, employee.PasswordHash))
            {
                return BadRequest("Verkeerde email of wachtwoord ingevuld");
            }

            string token = CreateToken(employee);

            return Ok(token);
        }

        private string CreateToken(Employee employee)
        {
            List<Claim> claims = new List<Claim> {
                new Claim(ClaimTypes.Name, employee.EmployeeEmail)
            };
            claims.Add(new Claim("displayname", employee.EmployeeName));
            claims.Add(new Claim("role", employee.Role.ToString()));
            claims.Add(new Claim("id", employee.Id.ToString()));

            var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(
                _configuration.GetSection("Jwt:Key").Value!
            ));

            var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha512Signature);

            var token = new JwtSecurityToken(
                claims: claims,
                expires: DateTime.Now.AddDays(1),
                signingCredentials: creds
            );

            var jwt = new JwtSecurityTokenHandler().WriteToken(token);
            return jwt;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<Employee>>> GetEmployees()
        {
            var employees = await _repository.AllAsync<Employee>();
           
            return Ok(employees);
        }

        [HttpGet]
        [Route("{id}")]
        public async Task<ActionResult<Employee>> GetEmployee(long id)
        {
            var employee = await _repository.SelectByIdAsync<Employee>(id);
            if (employee == null)
            {
                return NotFound();
            }
            return Ok(employee);
        }

        [HttpGet]
        [Route("department/{departmentId}")]
        public async Task<ActionResult<IEnumerable<Employee>>> GetEmployeesByDepartment(long departmentId)
        {
            var employeesPerDepartment = await _repository.AllAsync<Employee>(e => e.DepartmentId == departmentId);
            var referrals = await _repository.AllAsync<Referral>();
            var employeeWithReferralCounter = employeesPerDepartment.Select(employee => {
                var referralCount = referrals.Count(r => r.EmployeeId == employee.Id);
                return new {
                    Employee = employee,
                    ReferralCount = referralCount
                };
            }).ToList();
        
            if(employeesPerDepartment == null)
            {
                return NotFound();
            }

            return Ok(employeeWithReferralCounter);
        }

        [HttpGet("referral/{id}")] //Get Refferals from a employee
        public async Task<ActionResult<IEnumerable<Referral>>> GetReferrals(long id)
        {
            var referrals = await _repository.AllAsync<Referral>(x => x.EmployeeId == id);

            if (referrals == null)
            {
                return NotFound();
            }

            return Ok(referrals);
        }
    }
}
