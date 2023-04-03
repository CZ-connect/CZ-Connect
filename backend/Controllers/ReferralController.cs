using Microsoft.AspNetCore.Mvc;
using CZConnect.Models;
using CZConnect.DAL;
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
    public async Task<ActionResult<IEnumerable<Referral>>> GetReferral()
    {
        ReferralResponse referralsResponse = new ReferralResponse();

        referralsResponse.referrals = await _repository.AllAsync<Referral>();

        referralsResponse.completed = referralsResponse.referrals.Count(r => r.Status == "Afgerond");
        referralsResponse.pending = referralsResponse.referrals.Count(r => r.Status == "In afwachting");;

        return Ok(referralsResponse);
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
   
