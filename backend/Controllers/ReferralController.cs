using Microsoft.AspNetCore.Mvc;
using CZConnect.Models;
using CZConnect.DAL;

namespace CZConnect.Controllers;

[ApiController]
[Route("api/[controller]")]
public class ReferralController : ControllerBase
{
    private readonly IRepository _repository;

    public ReferralController(IRepository repository) =>
        this._repository = repository;
    
    [HttpGet]
    public async Task<ActionResult<IEnumerable<Referral>>> GetAllReferrals()
    {
        ReferralResponse referralsResponse = new ReferralResponse();

        referralsResponse.referrals = await _repository.AllAsync<Referral>();

        referralsResponse.completed = referralsResponse.referrals.Count(r => r.Status == "Goedgekeurd");
        referralsResponse.pending = referralsResponse.referrals.Count(r => r.Status == "In Afwachting");

        return Ok(referralsResponse);
    }

    [HttpGet]
    [Route("employee/{id}")]
    public async Task<ActionResult<IEnumerable<Referral>>> GetReferralsPerEmployee(long id)
    {
        ReferralResponse referralsResponse = new ReferralResponse();
        referralsResponse.referrals = await _repository.AllAsync<Referral>(x => x.EmployeeId == id);

        referralsResponse.completed = referralsResponse.referrals.Count(r => r.Status == "Goedgekeurd");
        referralsResponse.pending = referralsResponse.referrals.Count(r => r.Status == "In Afwachting");

        if (referralsResponse == null)
        {
            return NotFound();
        }

        return Ok(referralsResponse);
    }
}
   
