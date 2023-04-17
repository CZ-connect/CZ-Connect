using Microsoft.AspNetCore.Mvc;
using CZConnect.Models;
using CZConnect.DAL;

namespace CZConnect.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class GraphDataController : ControllerBase
    {
        private readonly IRepository _repository;

        public GraphDataController(IRepository repository)
        {
            this._repository = repository;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<GraphData>>> GetGraphData([FromQuery(Name = "year")] int year)
        {
            if (year == 0)
            {
                Console.WriteLine("year query parameter is empty, setting to current year . . .");
                year = DateTime.Now.Year;
            }

            var graphData = await _repository
                    .AllAsync<GraphData>(x => x.Year == year);

            return Ok(graphData);
        }
    }
}