using Microsoft.AspNetCore.Mvc;
using CZConnect.Models;
using CZConnect.DAL;

namespace CZConnect.Controllers;

[ApiController]
[Route("api/[controller]")]
public class ApplicantFormController : ControllerBase
{
    private readonly IRepository _repository;

    public ApplicantFormController(AppDBContext context, IRepository repository) =>
        this._repository = repository;

    [HttpGet]
    public async Task<ActionResult<IEnumerable<ApplicantForm>>> GetApplicantForm()
    {
        var applicantForms = _repository.SelectAll<ApplicantForm>();
        return Ok(applicantForms);
    }

    [HttpGet("{id}")]
    public async Task<ActionResult<ApplicantForm>> GetApplicantForm(long id)
    {
        var model = await _repository.SelectById<ApplicantForm>(id);

        if (model == null)
        {
            return NotFound();
        }

        return Ok(model);
    }

    [HttpPost]
    public async Task<ActionResult<ApplicantForm>> InsertApplicantForm(ApplicantForm newForm)
    {
        await _repository.CreateAsync<ApplicantForm>(newForm);
        return CreatedAtAction(nameof(newForm), new { id = newForm.Id }, newForm);
    }

    [HttpPut("{id}")]
    public async Task<IActionResult> UpdateApplicantForm(ApplicantForm formToUpdate)
    {
        await _repository.UpdateAsync<ApplicantForm>(formToUpdate);
        return NoContent();
    }

    [HttpDelete("{id}")]
    public async Task<ActionResult<ApplicantForm>> DeleteApplicantForm(long id)
    {
        var model = await _repository.SelectById<ApplicantForm>(id);

        if (model == null)
        {
            return NotFound();
        }

        await _repository.DeleteAsync<ApplicantForm>(model);

        return NoContent();
    }
}