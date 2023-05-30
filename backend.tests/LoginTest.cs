using System.Linq.Expressions;
using CZConnect.Controllers;
using CZConnect.DAL;
using CZConnect.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
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
    public async Task LoginShouldReturnOkResultWithToken()
    {
        // Arrange
        var request = new EmployeeLoginDto
        {
            Email = "test@example.com",
            Password = "Test123"
        };

        var expectedEmployee = new Employee 
        {
            EmployeeEmail = request.Email,
            Verified = true,
            PasswordHash = BCrypt.Net.BCrypt.HashPassword(request.Password),
            EmployeeName = "Test Employee",
            Role = EmployeeRole.Recruitment,  // Set this to the correct role,
            Id = 1
        };

        var mockRepositoryEmployee = new Mock<IRepository>();
        mockRepositoryEmployee
            .Setup(x => x.FindByAsync<Employee>(It.IsAny<Expression<Func<Employee, bool>>>()))
            .ReturnsAsync(expectedEmployee);

        var mockConfigurationSection = new Mock<IConfigurationSection>();
        mockConfigurationSection.Setup(x => x.Value).Returns("testing123457689123412348529834712903410293847123049817234019238471203984712039487");

        var mockConfiguration = new Mock<IConfiguration>();
        mockConfiguration.Setup(x => x.GetSection("Jwt:Key")).Returns(mockConfigurationSection.Object);

        var controllerEmployee = new EmployeeController(mockConfiguration.Object, mockRepositoryEmployee.Object);
    
        // Act
        var result = await controllerEmployee.Login(request);

        // Assert
        Assert.IsInstanceOfType(result.Result, typeof(OkObjectResult));
    
        // Assert that the response contains a token.
        var okResult = result.Result as OkObjectResult;
        Assert.IsInstanceOfType(okResult.Value, typeof(string));
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
    
    
    [TestMethod]
    public async Task RegisterShouldPass()
    {
        // Arrange
        var request = new EmployeeDto
        {
            Email = "test@example.com",
            Name = "Test Employee",
            Password = "Test123",
            Department = "Test Department",
            Verified = true,
            Role = "Admin" // Use a valid role
        };

        var mockRepositoryEmployee = new Mock<IRepository>();
        mockRepositoryEmployee
            .Setup(x => x.FindByAsync<Employee>(It.IsAny<Expression<Func<Employee, bool>>>()))
            .ReturnsAsync((Employee) null);

        var expectedDepartment = new Department
        {
            Id = 1,
            DepartmentName = request.Department
        };
        mockRepositoryEmployee
            .Setup(x => x.FindByAsync<Department>(It.IsAny<Expression<Func<Department, bool>>>()))
            .ReturnsAsync(expectedDepartment);

        var controllerEmployee = new EmployeeController(null, mockRepositoryEmployee.Object);
    
        // Act
        var result = await controllerEmployee.Register(request);

        // Assert
        Assert.IsInstanceOfType(result.Result, typeof(CreatedAtActionResult));
    }
    [TestMethod]
    public async Task RegisterShouldFailOnDuplicated()
    {
        // Arrange
        var request = new EmployeeDto
        {
            Email = "test@example.com",
            Name = "Test Employee",
            Password = "Test123",
            Department = "Test Department",
            Verified = true,
            Role = EmployeeRole.Recruitment.ToString() // Use a valid role
        };

        var existingEmployee = new Employee 
        {
            EmployeeEmail = request.Email,
            EmployeeName = request.Name,
            PasswordHash = BCrypt.Net.BCrypt.HashPassword(request.Password),
            DepartmentId = 1,
            Verified = request.Verified,
            Role = EmployeeRole.Recruitment
        };

        var mockRepositoryEmployee = new Mock<IRepository>();
        mockRepositoryEmployee
            .Setup(x => x.FindByAsync<Employee>(It.IsAny<Expression<Func<Employee, bool>>>()))
            .ReturnsAsync(existingEmployee);

        var controllerEmployee = new EmployeeController(null, mockRepositoryEmployee.Object);
    
        // Act
        var result = await controllerEmployee.Register(request);

        // Assert
        Assert.IsInstanceOfType(result.Result, typeof(BadRequestObjectResult));
    }


}