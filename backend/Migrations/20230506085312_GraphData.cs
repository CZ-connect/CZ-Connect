using Microsoft.EntityFrameworkCore.Migrations;

namespace backend.Migrations
{
    public partial class GraphData : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.Sql(@"
   CREATE PROCEDURE GetReferralStats
    @Year INT = NULL
AS
BEGIN
    IF @Year IS NULL
        SET @Year = YEAR(GETDATE())

    SELECT
        ROW_NUMBER() OVER(ORDER BY YEAR(r.RegistrationDate), MONTH(r.RegistrationDate)) AS Id, 
        YEAR(r.RegistrationDate) AS Year,
        MONTH(r.RegistrationDate) AS Month,
        COUNT(CASE WHEN r.status = 'Pending' THEN 1 END) AS AmmountOfNewReferrals,
        COUNT(CASE WHEN r.status = 'Approved' THEN 1 END) AS AmmountOfApprovedReferrals
    FROM 
        Referrals r
    WHERE 
        YEAR(r.RegistrationDate) = @Year
    GROUP BY 
        YEAR(r.RegistrationDate), MONTH(r.RegistrationDate)
    ORDER BY 
        YEAR(r.RegistrationDate), MONTH(r.RegistrationDate)
END

           

");

        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.Sql("DROP PROCEDURE IF EXISTS GetReferralStats;");
        }
    }
}