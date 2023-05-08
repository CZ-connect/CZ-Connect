using Microsoft.AspNetCore.Mvc;
using CZConnect.Models;
using CZConnect.DAL;
using Microsoft.Data.SqlClient;

namespace CZConnect.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class GraphDataController : ControllerBase
    {
        private readonly IRepository _repository;

        public GraphDataController(IRepository repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<GraphData>>> GetGraphData([FromQuery(Name = "year")] int year)
        {
            
            var results = await _repository.ExecuteStoredProcedureAsync<GraphData>(
                "GetReferralStats",
                new SqlParameter("@Year", year)
            );

            // Map the results to the GraphData model
            var graphData = results.Select(r => new GraphData
            {
                Year = r.Year,
                Month = r.Month,
                AmmountOfNewReferrals = r.AmmountOfNewReferrals,
                AmmountOfApprovedReferrals = r.AmmountOfApprovedReferrals
            });

            return Ok(new { graph_data = graphData });
        }

    }
}