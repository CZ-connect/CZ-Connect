using System.Linq.Expressions;
using CZConnect.Controllers;
using CZConnect.DAL;
using CZConnect.Models;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Mvc;
using Moq;
using BCrypt.Net;


namespace backend.tests;

[TestClass]
public class EmployeeTest
{
    private List<Employee> _employees;
    private List<Referral> _referrals;

    [TestInitialize]
    public void Initialize()
    {
        EmployeeRole[] _roles = (EmployeeRole[]) Enum.GetValues(typeof(EmployeeRole));

        _employees = new List<Employee>
        {
            new()
            {
                Id = 1,
                EmployeeName = "Marijn van den Bos",
                EmployeeEmail = "m.vandenbos5@student.avans.nl",
                DepartmentId = 1,
                Role = _roles[1]
            },
            new()
            {
                Id = 2,
                EmployeeName = "Coen van den Berge",
                EmployeeEmail = "cvdb@out.look.com",
                DepartmentId = 2,
                Role = _roles[2]
            },
            new()
            {
                Id = 3,
                EmployeeName = "Jos van den Berge",
                EmployeeEmail = "j@outlook.com",
                DepartmentId = 3,
                Role = _roles[2]
            }
        };
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
    public async Task getEmployeeShouldSuceed()
    {
        // Arrange
        long existingId = 456;
        var mockRepository = new Mock<IRepository>();
        var controller = new EmployeeController(null,mockRepository.Object);
        Employee employee = new Employee { Id = existingId };
        mockRepository.Setup(repo => repo.SelectByIdAsync<Employee>(existingId)).ReturnsAsync(employee);

        // Act
        var result = await controller.GetEmployee(existingId);

        // Assert
        Assert.IsInstanceOfType(result.Result, typeof(OkObjectResult));
    }
    [TestMethod]
    public async Task getEmployeeShouldFail()
    {
        var mockRepository = new Mock<IRepository>();
        var controller = new EmployeeController(null,mockRepository.Object);

        var result = await controller.GetEmployee(200);
        Assert.IsNotNull(result);
        Assert.IsInstanceOfType(result.Result, typeof(NotFoundResult));
    }
    [TestMethod]
    public async Task getEmployeesShouldSuceed()
    {
        //employee mock
        var mockRepositoryEmployee = new Mock<IRepository>();
        mockRepositoryEmployee.Setup(repo => repo.UpdateAsync(_employees.First())).Verifiable();
        var controllerEmployee = new EmployeeController(null,mockRepositoryEmployee.Object);
        var result = await controllerEmployee.GetEmployees();
        Assert.IsNotNull(result);
        Assert.IsInstanceOfType(result.Result, typeof(OkObjectResult));
    }
    
    [TestMethod]
    public async Task getRefferalsShouldFail()
    {
        //employee mock
        var mockRepositoryEmployee = new Mock<IRepository>();
        mockRepositoryEmployee .Setup(x => x.AllAsync<Referral>(It.IsAny<Expression<Func<Referral, bool>>>()))
            .ReturnsAsync((List<Referral>) null);
        var controllerEmployee = new EmployeeController(null,mockRepositoryEmployee.Object);
        var  result = controllerEmployee.GetReferrals(200);
        Assert.IsNotNull(result);
        Assert.IsInstanceOfType(result.Result.Result, typeof(NotFoundResult));
    }
    [TestMethod]
    public async Task getRefferalsShouldSucceed()
    {
        //employee mock
        var mockRepositoryEmployee = new Mock<IRepository>();
        mockRepositoryEmployee .Setup(x => x.AllAsync<Referral>(It.IsAny<Expression<Func<Referral, bool>>>()))
            .ReturnsAsync((List<Referral>) _referrals);
        var controllerEmployee = new EmployeeController(null,mockRepositoryEmployee.Object);
        var  result = controllerEmployee.GetReferrals(_employees.First().Id);
        Assert.IsNotNull(result);
        //first result in the list is the same as the first referral in the list
        Assert.IsInstanceOfType(result.Result.Result, typeof(OkObjectResult));
    }
}