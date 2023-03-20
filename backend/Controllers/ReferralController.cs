using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Mvc;
using CZConnect.Models;

namespace CZConnect.Controllers;

[ApiController]
[Route("api/[controller]")]
public class ReferralController : ControllerBase
{
    private readonly AppDBContext _AppDBContext;

    public ReferralController(AppDBContext AppDBContext) =>
        _AppDBContext = AppDBContext;
    
    [HttpGet]
    public async Task<List<Referral>> Get() =>
        await _AppDBContext.Referrals.ToListAsync();
}