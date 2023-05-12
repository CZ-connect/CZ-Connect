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
    [TestInitialize]
    public void Initialize()
    {
        _departments = new List<Department>()
        {
            new()
            {
                Id = 0,
                DepartmentName = "TestDepartment"
            },
            new()
            {
                Id = 1,
                DepartmentName = "TestDepartment2"
            },
            new()
            {
                Id = 2,
                DepartmentName = "TestDepartment3"
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
}