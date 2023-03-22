using Microsoft.AspNetCore.Mvc;
using CZConnect.Models;
using CZConnect.DAL;

namespace CZConnect.Controllers;

[ApiController]
[Route("api/[controller]")]
public class ReferralController : ControllerBase
{
    private readonly IRepository _repository;

    public ReferralController(AppDBContext context, IRepository repository) =>
        this._repository = repository;
    
    [HttpGet]
    public async Task<ActionResult<IEnumerable<Referral>>> GetReferral()
    {
        var referrals = await _repository.AllAsync<Referral>();
        return Ok(referrals);
    }
}