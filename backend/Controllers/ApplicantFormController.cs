using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Mvc;
using CZConnect.Models;
using CZConnect.Db;
using CZConnect.DAL;

namespace CZConnect.Controllers;

[ApiController]
[Route("api/[controller]")]
public class ApplicantFormController : ControllerBase
{
    private readonly IRepository _repository;

    public ApplicantFormController(DataContext context, IRepository repository) =>
        this._repository = repository;

    [HttpGet]
    public async Task<ActionResult<IEnumerable<ApplicantForm>>> GetApplicantForm()
    {
        return await _repository.SelectAll<ApplicantForm>();
    }

    [HttpGet("{id}")]
    public async Task<ActionResult<ApplicantForm>> GetApplicantForm(long id)
    {
        var model = await _repository.SelectById<ApplicantForm>(id);

        if (model == null)
        {
            return NotFound();
        }

        return model;
    }

    [HttpPost]
    public async Task<ActionResult<ApplicantForm>> InsertApplicantForm(ApplicantForm applicantForm)
    {
        await _repository.CreateAsync<ApplicantForm>(applicantForm);
        return CreatedAtAction(nameof(GetApplicantForm), new { id = applicantForm.Id }, applicantForm);
    }
}