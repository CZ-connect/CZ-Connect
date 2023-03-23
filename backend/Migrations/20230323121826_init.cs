using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace backend.Migrations
{
    /// <inheritdoc />
    public partial class init : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "ApplicantForms",
                columns: table => new
                {
                    Id = table.Column<long>(type: "bigint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Email = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ApplicantForms", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Referrals",
                columns: table => new
                {
                    id = table.Column<long>(type: "bigint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    employeeName = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    participantEmail = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    participantName = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    registrationDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    status = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Referrals", x => x.id);
                });

            migrationBuilder.InsertData(
                table: "Referrals",
                columns: new[] { "id", "employeeName", "participantEmail", "participantName", "registrationDate", "status" },
                values: new object[,]
                {
                    { 1L, "CZ-Medewerker", "cmberge@avans.nl", "Coen", new DateTime(2023, 3, 23, 13, 18, 26, 310, DateTimeKind.Local).AddTicks(7564), "Afgerond" },
                    { 2L, "CZ-Medewerker", "m1@avans.nl", "Marijn 1", new DateTime(2023, 3, 23, 13, 18, 26, 310, DateTimeKind.Local).AddTicks(7634), "In afwachting" },
                    { 3L, "CZ-Medewerker", "m2@avans.nl", "Marijn 2", new DateTime(2023, 3, 23, 13, 18, 26, 310, DateTimeKind.Local).AddTicks(7638), "Afgerond" },
                    { 4L, "CZ-Medewerker", "jos@avans.nl", "Jos", new DateTime(2023, 3, 23, 13, 18, 26, 310, DateTimeKind.Local).AddTicks(7643), "Afgerond" },
                    { 5L, "CZ-Medewerker", "jedrek@avans.nl", "Jedrek", new DateTime(2023, 3, 23, 13, 18, 26, 310, DateTimeKind.Local).AddTicks(7647), "Afgerond" },
                    { 6L, "CZ-Medewerker", "wballeko@avans.nl", "William", new DateTime(2023, 3, 23, 13, 18, 26, 310, DateTimeKind.Local).AddTicks(7652), "In afwachting" }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "ApplicantForms");

            migrationBuilder.DropTable(
                name: "Referrals");
        }
    }
}
