using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace backend.Migrations
{
    /// <inheritdoc />
    public partial class spGetUnlinkedReferrals : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.Sql(@"
                CREATE PROCEDURE GetUnlinkedReferrals

                AS
                BEGIN

                SELECT r.Id , r.ParticipantName , r.Status , r.ParticipantEmail , r.linkedin , r.ParticipantPhoneNumber , r.RegistrationDate , r.EmployeeId 
                FROM
                    Referrals r  left join Employees e on r.EmployeeId = e.Id 
                WHERE
                    r.EmployeeId is null OR e.DepartmentId IS NULL
                END
            ");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.Sql("DROP PROCEDURE IF EXISTS GetUnlinkedReferrals");
        }
    }
}
