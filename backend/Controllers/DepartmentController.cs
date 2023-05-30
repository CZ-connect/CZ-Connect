using Microsoft.AspNetCore.Mvc;
using CZConnect.Models;
using CZConnect.DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace CZConnect.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class DepartmentController : ControllerBase
    {
        private readonly IRepository _repository;

        public DepartmentController(IRepository repository)
        {
            this._repository = repository;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<Department>>> GetDepartments()
        {
            var departments = await _repository.AllAsync<Department>();
            if (departments == null)
            {
                return NotFound();
            }

            return Ok(departments);
        }

        [HttpGet]
        [Route("{id}")]
        public async Task<ActionResult<Department>> GetDepartmentById(long id)
        {
            var department = await _repository.SelectByIdAsync<Department>(id);
            if (department == null)
            {
                return NotFound();
            }

            return Ok(department);
        }

        [HttpPut]
        [Route("{id}")]
        public async Task<ActionResult<Department>> UpdateDepartment(long id, DepartmentDtoUpdate request)
        {
            var department = await _repository.SelectByIdAsync<Department>(id);

            if (department == null)
            {
                return NotFound();
            }

            department.DepartmentName = request.DepartmentName;
            await _repository.UpdateAsync<Department>(department);
            return Ok(department);
        }

        [HttpPost]
        public async Task<ActionResult<Department>> InsertDepartment(Department department)
        {
            await _repository.CreateAsync(department);
            return Ok();
        }

        [HttpDelete]
        [Route("{id}")]
        public async Task<ActionResult<Department>> DeleteDepartment(long id)
        {
            var department = await _repository.SelectByIdAsync<Department>(id);
            var departmentId = department.Id;
            var employees = await _repository.AllAsync<Employee>();
            if (department == null)
            {
                return NotFound();
            }
            
            var employeesInDepartment = employees.Where(e => e.DepartmentId == departmentId);
            foreach (var employee in employeesInDepartment)
            {
                employee.DepartmentId = null;
                employee.Department = null;
                await _repository.UpdateAsync<Employee>(employee);
            }
            
            await _repository.DeleteAsync(department);
            return Ok();
        }
    }
}