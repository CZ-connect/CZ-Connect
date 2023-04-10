using CZConnect.Models;
using CZConnect.DAL;
using Microsoft.AspNetCore.Mvc;
using Moq;
using System.Linq.Expressions;
using CZConnect.Controllers;

namespace backend.tests;

[TestClass]
public class ReferralTest
{
    private List<Referral> _referrals;

    [TestInitialize]
    public void Initialize()
    {            
        _referrals = new List<Referral>
        {
            new Referral{Id = 1, ParticipantName = "John Doe", 
                        ParticipantEmail = "johndoe@example.com", Status = "Pending", 
                        RegistrationDate = DateTime.Now, EmployeeId = 1, Employee = null},
            new Referral{Id = 2, ParticipantName = "Jane Smith", 
                        ParticipantEmail = "janesmith@example.com", Status = "Approved",
                        RegistrationDate = DateTime.Now.AddDays(-1), EmployeeId = 2, Employee = null},
            new Referral{Id = 3, ParticipantName = "Bob Johnson", 
                        ParticipantEmail = "bobjohnson@example.com", Status = "Denied",
                        RegistrationDate = DateTime.Now.AddDays(-2), EmployeeId = 1, Employee = null}
        };
    }


    [TestMethod]
    public async Task GetIndividualReferral_Should_Succeed() 
    {
        var mockRepository = new Mock<IRepository>();
        mockRepository.Setup(repo => repo.SelectByIdAsync<Referral>(1))
        .ReturnsAsync(_referrals.FirstOrDefault(r => r.Id == 1));

        var controller = new ReferralController(mockRepository.Object);
        var result = await controller.GetIndividualReferral(1);

        var okResult = result.Result as OkObjectResult;
        
        Assert.IsNotNull(okResult);
        Assert.AreEqual(200, okResult.StatusCode);
        Assert.IsInstanceOfType(okResult.Value, typeof(Referral)); 
    }

    [TestMethod]
    public async Task GetIndividualReferral_Should_Give_NotFound() 
    {
        var mockRepository = new Mock<IRepository>();
        mockRepository.Setup(repo => repo.SelectByIdAsync<Referral>(8))
        .ReturnsAsync(() => null);
        var controller = new ReferralController(mockRepository.Object);

        var result = await controller.GetIndividualReferral(8);

        Assert.IsInstanceOfType(result.Result, typeof(NotFoundResult));
    }


    [TestMethod]
    public async Task GetRefferalById_Should_Succeed()
    {
        var mockRepository = new Mock<IRepository>();
        mockRepository
        .Setup(repo => repo.AllAsync<Referral>(It.IsAny<Expression<Func<Referral, bool>>>()))
        .ReturnsAsync(_referrals.Where(r => r.EmployeeId == 1).ToList());
        var controller = new ReferralController(mockRepository.Object);

        var result = await controller.GetReferrals(1);

        var okResult = result.Result as OkObjectResult;
        
        Assert.IsNotNull(okResult);
        Assert.AreEqual(200, okResult.StatusCode);
        Assert.IsInstanceOfType(okResult.Value, typeof(List<Referral>)); 
        var actualReferrals = okResult.Value as List<Referral>;
        Assert.AreEqual(2, actualReferrals.Count);
    }

    [TestMethod]
    public async Task GetReferrals_ReturnsNotFoundResult()
    {
        var mockRepository = new Mock<IRepository>();
        mockRepository
        .Setup(repo => repo.AllAsync<Referral>(It.IsAny<Expression<Func<Referral, bool>>>()))
        .ReturnsAsync(() => null);
        var controller = new ReferralController(mockRepository.Object);

        var result = await controller.GetReferrals(5);

        Assert.IsInstanceOfType(result.Result, typeof(NotFoundResult));
    }
}