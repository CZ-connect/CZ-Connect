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

        referralsResponse.completed = referralsResponse.referrals.Count(r => r.Status == "Goedgekeurd");
        referralsResponse.pending = referralsResponse.referrals.Count(r => r.Status == "In Afwachting");;

        return Ok(referralsResponse);
    }

    [HttpGet("{id}")] //Get Refferals from a employee
    public async Task<ActionResult<IEnumerable<Referral>>> GetReferrals(long id)
    {
        var referrals = await _repository.AllAsync<Referral>(x => x.EmployeeId == id);

        if (referrals == null)
        {
            return NotFound();
        }

        return Ok(referrals);
    }

    [HttpGet("/individual/{id}")]
    public async Task<ActionResult<Referral>> GetIndividualReferral(long id)
    {
        var referral = await _repository.SelectByIdAsync<Referral>(id);

        if(referral == null) 
        {
            return NotFound();
        }

        return Ok(referral);
    }

    [HttpPut("/individual/{id}")]
    public async Task<ActionResult<Referral>> UpdateReferral(long id, [FromBody] string status)
    {
        if(string.IsNullOrWhiteSpace(status)) 
        {
            return BadRequest("Status can not be empty");
        }

        var referral = await _repository.SelectByIdAsync<Referral>(id);

        if(referral == null) 
        {
            return NotFound();
        } 

        referral.Status = status;
        _repository.UpdateAsync(referral);

        return Ok();
    }
}
   
