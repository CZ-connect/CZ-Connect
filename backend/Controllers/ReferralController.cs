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
    [Route("{id}")]
    public async Task<ActionResult<Referral>> GetReferralById(long id)
    {
        var referral = await _repository.SelectByIdAsync<Referral>(id);
        if (referral == null)
        {
            return NotFound();
        }
        return Ok(referral);
    }
    
    [HttpGet]
    public async Task<ActionResult<IEnumerable<Referral>>> GetAllReferrals()
    {
        ReferralResponse referralsResponse = new ReferralResponse();

        referralsResponse.referrals = await _repository.AllAsync<Referral>();

        referralsResponse.completed = referralsResponse.referrals.Count(r => r.Status == ReferralStatus.Approved);
        referralsResponse.pending = referralsResponse.referrals.Count(r => r.Status == ReferralStatus.Pending);

        return Ok(referralsResponse);
    }

    [HttpGet]
    [Route("employee/{id}")]
    public async Task<ActionResult<IEnumerable<Referral>>> GetReferralsPerEmployee(long id)
    {
        ReferralResponse referralsResponse = new ReferralResponse();
        referralsResponse.referrals = await _repository.AllAsync<Referral>(x => x.EmployeeId == id);

        referralsResponse.completed = referralsResponse.referrals.Count(r => r.Status == ReferralStatus.Approved);
        referralsResponse.pending = referralsResponse.referrals.Count(r => r.Status == ReferralStatus.Pending);

        if (referralsResponse.referrals == null)
        {
            return NotFound();
        }

        return Ok(referralsResponse);
    }

    [HttpPut]
    [Route("{id}")]
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
    
    [HttpPut]
    [Route("accept/{id}")]
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
        await _repository.CreateAsync(referral);
        return Ok();
    } 

    [HttpDelete]  
    [Route("{id}")]
    public async Task<ActionResult<Referral>> DeleteReferral(long id) 
    {
        var referral = await _repository.SelectByIdAsync<Referral>(id);
        if(referral == null) 
        {
            return NotFound();
        }
        await _repository.DeleteAsync(referral);
        return Ok();
    }  
}
   
