using Microsoft.AspNetCore.Mvc;
using CZConnect.Models;
using CZConnect.DAL;

namespace CZConnect.Controllers;

[ApiController]
[Route("api/[controller]")]
public class ReferralController : ControllerBase
{
    private readonly AppDBContext _AppDBContext;
    private readonly IRepository _repository;

    public ReferralController(AppDBContext AppDBContext, IRepository repository) 
    {
        _AppDBContext = AppDBContext;
        _repository = repository;
    }

    [HttpGet("{id}")]
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