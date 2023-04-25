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

        [HttpGet]
        [Route("{id}")]
        public async Task<ActionResult<Employee>> GetEmployee(long id)
        {
            var employee = await _repository.SelectByIdAsync<Employee>(id); 
           
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
    }
}