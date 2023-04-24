using Microsoft.AspNetCore.Mvc;
using CZConnect.Models;
using CZConnect.DAL;

namespace CZConnect.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class EmployeeController : ControllerBase
    {
        private readonly IRepository _repository;

        public EmployeeController(IRepository repository)
        {
            this._repository = repository;
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