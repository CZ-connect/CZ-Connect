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
                return BadRequest("Invalid role value");
            }

            Employee employee = new Employee
            {
                Username = request.Username,
                EmployeeName = request.EmployeeName,
                PasswordHash = passwordHash,
                Role = role
            };

            await _repository.CreateAsync<Employee>(employee);
            return CreatedAtAction(nameof(GetEmployee), new { id = employee.Id }, employee);
        }



        [HttpPost("login")]
        public async Task<ActionResult<Employee>> Login(EmployeeLoginDto request)
        {
            var employee = await _repository.FindByAsync<Employee>(e => e.Username == request.Username);

            if (employee == null)
            {
                return BadRequest("Wrong password or username");
            }
          
            if (!BCrypt.Net.BCrypt.Verify(request.Password, employee.PasswordHash))
            {
                return BadRequest("Wrong password or username");
            }

            string token = CreateToken(employee);

            return Ok(token);
        }

        private string CreateToken(Employee employee)
        {
            List<Claim> claims = new List<Claim> {
                new Claim(ClaimTypes.Name, employee.Username)
            };
            claims.Add(new Claim("displayname", employee.EmployeeName));
            claims.Add(new Claim("role", employee.Role.ToString()));

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

        [HttpGet("{id}")]
        public async Task<ActionResult<Employee>> GetEmployee(long id)
        {
            var employee = await _repository.SelectByIdAsync<Employee>(id);

            if (employee == null)
            {
                return NotFound();
            }

            return Ok(employee);
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