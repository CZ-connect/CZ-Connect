using CZConnect.Models;
using CZConnect.DAL;
using Moq;
using System.Linq.Expressions;
using Microsoft.AspNetCore.Mvc;
using BCrypt.Net;
using Castle.Core.Configuration;
using CZConnect.Controllers;
using Microsoft.Extensions.Configuration;

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
            new()
            {
                Id = 1, ParticipantName = "John Doe",
                ParticipantEmail = "johndoe@example.com", Status = ReferralStatus.Pending,
                RegistrationDate = DateTime.Now, EmployeeId = 1, Employee = null
            },
            new()
            {
                Id = 2, ParticipantName = "Jane Smith",
                ParticipantEmail = "janesmith@example.com", Status = ReferralStatus.Approved,
                RegistrationDate = DateTime.Now.AddDays(-1), EmployeeId = 2, Employee = null
            },
            new()
            {
                Id = 3, ParticipantName = "Bob Johnson",
                ParticipantEmail = "bobjohnson@example.com", Status = ReferralStatus.Denied,
                RegistrationDate = DateTime.Now.AddDays(-2), EmployeeId = 1, Employee = null
            }
        };
    }

    [TestMethod]
    public async Task UpdateReferralStatus_Should_Succeed()
    {
        var mockRepository = new Mock<IRepository>();
        mockRepository.Setup(repo => repo.UpdateAsync(_referrals.First())).Verifiable();
        var controller = new ReferralController(mockRepository.Object);

        var result = await controller.RejectReferral(_referrals.First());

        Assert.IsNotNull(result);
        Assert.IsInstanceOfType(result.Result, typeof(OkResult));
    }

    [TestMethod]
    public async Task UpdateReferralStatus_Should_Fail()
    {
        var mockRepository = new Mock<IRepository>();
        mockRepository.Setup(repo => repo.UpdateAsync(_referrals.First())).Verifiable();
        var controller = new ReferralController(mockRepository.Object);

        var result = await controller.RejectReferral(null);

        Assert.IsNotNull(result);
        Assert.IsInstanceOfType(result.Result, typeof(NotFoundResult));
    }


    [TestMethod]
    public async Task GetIndividualReferral_Should_Succeed()
    {
        var mockRepository = new Mock<IRepository>();
        mockRepository.Setup(repo => repo.SelectByIdAsync<Referral>(1))
            .ReturnsAsync(_referrals.FirstOrDefault(r => r.Id == 1));

        var controller = new ReferralController(mockRepository.Object);
        var result = await controller.GetReferralById(1);

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

        var result = await controller.GetReferralById(8);

        Assert.IsInstanceOfType(result.Result, typeof(NotFoundResult));
    }


    [TestMethod]
    public async Task GetRefferalById_Should_Succeed()
    {
        var mockRepository = new Mock<IRepository>();
        mockRepository
            .Setup(repo => repo.AllAsync<Referral>(It.IsAny<Expression<Func<Referral, bool>>>()))
            .ReturnsAsync(_referrals.Where(r => r.EmployeeId == 1).ToList());
     
        
        var controller = new EmployeeController(null,mockRepository.Object);

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
        var controller = new EmployeeController(null,mockRepository.Object);

        var result = await controller.GetReferrals(5);

        Assert.IsInstanceOfType(result.Result, typeof(NotFoundResult));
    }

    [TestMethod]
    public async Task DeleteReferral_Succeeds()
    {
        var count = _referrals.Count;
        var mockRepository = new Mock<IRepository>();
        mockRepository.Setup(repo => repo.DeleteAsync<Referral>(_referrals.First()))
            .Callback<Referral>((entity) => _referrals.Remove(_referrals.First()));
        mockRepository.Setup(repo => repo.SelectByIdAsync<Referral>(_referrals.First().Id))
            .ReturnsAsync(_referrals.First());
        var controller = new ReferralController(mockRepository.Object);

        
        var result = await controller.DeleteReferral(_referrals.First().Id);

        Assert.IsNotNull(result);
        Assert.IsInstanceOfType(result.Result, typeof(OkResult));
        Assert.AreNotEqual(count, _referrals.Count);
    }

    [TestMethod]
    public async Task DeleteReferral_Fails()
    {
        var count = _referrals.Count;
        var mockRepository = new Mock<IRepository>();
        mockRepository.Setup(repo => repo.DeleteAsync<Referral>(_referrals.First()))
            .Callback<Referral>((entity) => _referrals.Remove(_referrals.First()));
        mockRepository.Setup(repo => repo.SelectByIdAsync<Referral>(_referrals.First().Id))
            .ReturnsAsync(_referrals.First());
        var controller = new ReferralController(mockRepository.Object);

        var result = await controller.DeleteReferral(8);

        Assert.IsNotNull(result);
        Assert.IsInstanceOfType(result.Result, typeof(NotFoundResult));
        Assert.AreEqual(count, _referrals.Count);
    }

    [TestMethod]
    public async Task GetReferralsPerEmployeeFails()
    {
        var mockRepository = new Mock<IRepository>();
        mockRepository
            .Setup(x => x.AllAsync<Referral>(It.IsAny<Expression<Func<Referral, bool>>>()))
            .ReturnsAsync((List<Referral>) null);
        var controller = new ReferralController(mockRepository.Object);
        // Act
        var result = await controller.GetReferralsPerEmployee(_referrals.First().Id);
        // Assert
        Assert.IsInstanceOfType(result.Result, typeof(NotFoundResult));
        mockRepository.Verify(x => x.AllAsync<Referral>(It.IsAny<Expression<Func<Referral, bool>>>()), Times.Once);
        mockRepository.Setup(x => x.AllAsync<Referral>(It.IsAny<Expression<Func<Referral, bool>>>()))
            .ReturnsAsync((List<Referral>) _referrals);
        // Assert
        Assert.IsInstanceOfType(result.Result, typeof(NotFoundResult));
        mockRepository.Verify(x => x.AllAsync<Referral>(It.IsAny<Expression<Func<Referral, bool>>>()), Times.Once);
    }

    [TestMethod]
    public async Task GetReferralsPerEmployeeSucceeds()
    {
        var mockRepository = new Mock<IRepository>();
        mockRepository
            .Setup(x => x.AllAsync<Referral>(It.IsAny<Expression<Func<Referral, bool>>>()))
            .ReturnsAsync((List<Referral>) _referrals);
        var controller = new ReferralController(mockRepository.Object);
        // Act
        var result = await controller.GetReferralsPerEmployee(_referrals.First().Id);
        // Assert
        Assert.IsInstanceOfType(result.Result, typeof(OkObjectResult));
        mockRepository.Verify(x => x.AllAsync<Referral>(It.IsAny<Expression<Func<Referral, bool>>>()), Times.Once);
    }

    [TestMethod]
    public async Task GetUnlinkedRefferalSucceeds()
    {
        var mockRepository = new Mock<IRepository>();
        mockRepository
            .Setup(x => x.AllAsync<Referral>(It.IsAny<Expression<Func<Referral, bool>>>()))
            .ReturnsAsync((List<Referral>) _referrals);
        var controller = new ReferralController(mockRepository.Object);
        controller.GetUnlinkedReferrals();
        // Act
        var result = await controller.GetUnlinkedReferrals();
        // Assert
        Assert.IsNotNull(result);
        Assert.IsInstanceOfType(result.Result, typeof(NotFoundResult));
    }
}