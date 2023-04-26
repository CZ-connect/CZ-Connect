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
    public async Task<ActionResult<IEnumerable<Referral>>> GetReferral()
    {
        ReferralResponse referralsResponse = new ReferralResponse();

        referralsResponse.referrals = await _repository.AllAsync<Referral>();

        referralsResponse.completed = referralsResponse.referrals.Count(r => r.Status == ReferralStatus.Approved);
        referralsResponse.pending = referralsResponse.referrals.Count(r => r.Status == ReferralStatus.Pending);

        return Ok(referralsResponse);
    }

    [HttpGet("{id}")]
    public async Task<ActionResult<Referral>> GetReferral(long id)
    {
        var referral = await _repository.SelectByIdAsync<Referral>(id);

        if(referral == null) 
        {
            return NotFound();
        }

        return Ok(referral);
    }

    [HttpPut("{id}")]
    public async Task<ActionResult<Referral>> RejectReferral(Referral referral)
    {
        if(referral == null) 
        {
            return NotFound();
        }
        referral.Status = ReferralStatus.Denied;
        await _repository.UpdateAsync(referral);
        return Ok();
    }
    
    [HttpPut("accept/{id}")]
    public async Task<ActionResult<Referral>> AcceptReferral(Referral referral)
    {
        if(referral == null) 
        {
            return NotFound();
        }
        referral.Status = ReferralStatus.Approved;
        await _repository.UpdateAsync(referral);
        return Ok();
    }
    
    [HttpPost]
    public async Task<ActionResult<Referral>> InsertReferral(Referral referral)
    {
        await _repository.CreateAsync<Referral>(referral);
        return Ok();
    }   
}
   
