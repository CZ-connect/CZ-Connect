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
            if (departments == null){
                return NotFound();
            }
            return Ok(departments); // Pass the JsonSerializerOptions to Ok method
        }
    }
}