using CZConnect.Controllers;
using CZConnect.DAL;
using CZConnect.Models;
using Microsoft.AspNetCore.Mvc;
using Moq;

namespace backend.tests;

[TestClass]
public class DepartmentTest
{
    private List<Department> _departments;
    private List<Employee> _employees;
    [TestInitialize]
    public void Initialize()
    {
         EmployeeRole[] _roles = (EmployeeRole[]) Enum.GetValues(typeof(EmployeeRole));
        _departments = new List<Department>()
        {
            new()
            {
                Id = 1,
                DepartmentName = "TestDepartment"
            },
            new()
            {
                Id = 2,
                DepartmentName = "TestDepartment2"
            },
            new()
            {
                Id = 3,
                DepartmentName = "TestDepartment3"
            }
        };

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
    }

    [TestMethod]
    public async Task getGetDepartmentsShouldFail()
    {
        var mockRepository = new Mock<IRepository>();
        var controller = new DepartmentController(mockRepository.Object);
        mockRepository
            .Setup(x => x.AllAsync<Department>())
            .ReturnsAsync((List<Department>) null);
        
        var result = await controller.GetDepartments();
        Assert.IsNotNull(result);
        Assert.IsInstanceOfType(result.Result, typeof(NotFoundResult));
        mockRepository.Verify(x => x.AllAsync<Department>(), Times.Once);
    }
    [TestMethod]
    public async Task getGetDepartmentsShoulSucceed()
    {
        var mockRepository = new Mock<IRepository>();
        var controller = new DepartmentController(mockRepository.Object);
        mockRepository
            .Setup(x => x.AllAsync<Department>())
            .ReturnsAsync((List<Department>) _departments);
        
        var result = await controller.GetDepartments();
        Assert.IsNotNull(result);
        Assert.IsInstanceOfType(result.Result, typeof(OkObjectResult));
        mockRepository.Verify(x => x.AllAsync<Department>(), Times.Once);
    }
    [TestMethod]
    public async Task getIndividualDepartmentShouldSucceed()
    {
        var mockRepository = new Mock<IRepository>();
        mockRepository.Setup(repo => repo.SelectByIdAsync<Department>(1))
            .ReturnsAsync(_departments.FirstOrDefault(d => d.Id == 1));

        var controller = new DepartmentController(mockRepository.Object);
        var result = await controller.GetDepartmentById(1);

        var okResult = result.Result as OkObjectResult;

        Assert.IsNotNull(okResult);
        Assert.AreEqual(200, okResult.StatusCode);
        Assert.IsInstanceOfType(okResult.Value, typeof(Department));
    }

    [TestMethod]
    public async Task getIndividualDepartmentShouldGiveNotFound()
    {
        var mockRepository = new Mock<IRepository>();
        mockRepository.Setup(repo => repo.SelectByIdAsync<Department>(8))
            .ReturnsAsync(() => null);
        var controller = new DepartmentController(mockRepository.Object);

        var result = await controller.GetDepartmentById(8);

        Assert.IsInstanceOfType(result.Result, typeof(NotFoundResult));
    }

    [TestMethod]
    public async Task DeleteDepartmentSucceeds()
    {
        var count = _departments.Count;
        var mockRepository = new Mock<IRepository>();
        mockRepository.Setup(repo => repo.DeleteAsync<Department>(_departments.First()))
            .Callback<Department>((entity) => _departments.Remove(_departments.First()));
        mockRepository.Setup(repo => repo.SelectByIdAsync<Department>(_departments.First().Id))
            .ReturnsAsync(_departments.First());
        mockRepository.Setup(repo => repo.AllAsync<Employee>())
            .ReturnsAsync(_employees);
         mockRepository.Setup(repo => repo.UpdateAsync(_employees.First())).Verifiable();
        var controller = new DepartmentController(mockRepository.Object);

        //var result = await controller.DeleteDepartment(12);
        
        var result = await controller.DeleteDepartment(_departments.First().Id);

        Assert.IsNotNull(result);
        Assert.IsInstanceOfType(result.Result, typeof(OkResult));
        Assert.AreNotEqual(count, _departments.Count);
    }

    [TestMethod]
    public async Task DeleteDepartmentFails()
    {
        var count = _departments.Count;
        var mockRepository = new Mock<IRepository>();
        mockRepository.Setup(repo => repo.DeleteAsync<Department>(_departments.First()))
            .Callback<Department>((entity) => _departments.Remove(_departments.First()));
        mockRepository.Setup(repo => repo.SelectByIdAsync<Department>(_departments.First().Id))
            .ReturnsAsync(_departments.First());
        mockRepository.Setup(repo => repo.AllAsync<Employee>())
            .ReturnsAsync(_employees);
         mockRepository.Setup(repo => repo.UpdateAsync(_employees.First())).Verifiable();
        var controller = new DepartmentController(mockRepository.Object);

        var result = await controller.DeleteDepartment(8);

        Assert.IsNotNull(result);
        Assert.IsInstanceOfType(result.Result, typeof(NotFoundResult));
        Assert.AreEqual(count, _departments.Count);
    }
}