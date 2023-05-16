using System.Linq.Expressions;
using CZConnect.Controllers;
using CZConnect.DAL;
using CZConnect.Models;
using Microsoft.AspNetCore.Mvc;
using Moq;

namespace backend.tests;
[TestClass]
public class LoginTest
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
    public async Task LoginShouldRertunActionTrue()
    {
        // Arrange
        var request = new EmployeeDto { Email = "test@example.com", Name = "Test", Password = "Test123", Role = "Admin" };
        var mockRepositoryEmployee = new Mock<IRepository>();
        mockRepositoryEmployee .Setup(x => x.AllAsync<Referral>(It.IsAny<Expression<Func<Referral, bool>>>()))
            .ReturnsAsync((List<Referral>) null);
        var controllerEmployee = new EmployeeController(null,mockRepositoryEmployee.Object);
        // Act
        var result = await controllerEmployee.Register(request);

        // Assert
        Assert.IsInstanceOfType(result.Result, typeof(CreatedAtActionResult));
    }

    [TestMethod]
    public async Task LoginShouldRertunActionFalse()
    {
        // Arrange
        var request = new EmployeeLoginDto { Email = "test@example.com", Password = "Test123" };
        var mockRepositoryEmployee = new Mock<IRepository>();
        mockRepositoryEmployee .Setup(x => x.AllAsync<Referral>(It.IsAny<Expression<Func<Referral, bool>>>()))
            .ReturnsAsync((List<Referral>) null);
        var controllerEmployee = new EmployeeController(null,mockRepositoryEmployee.Object);
        // Act
        var result = await controllerEmployee.Login(request);
        // Assert
        Assert.IsInstanceOfType(result.Result, typeof(BadRequestObjectResult));

    }
}