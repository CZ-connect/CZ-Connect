using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Mvc;
using CZConnect.Models;
using CZConnect.Db;

namespace CZConnect.Controllers;

[ApiController]
[Route("api/[controller]")]
public class ReferralController : ControllerBase
{
    private readonly DataContext _dataContext;

    public ReferralController(DataContext dataContext) =>
        _dataContext = dataContext;
    
    [HttpGet]
    public async Task<List<Referral>> Get() =>
        await _dataContext.Referrals.ToListAsync();
}