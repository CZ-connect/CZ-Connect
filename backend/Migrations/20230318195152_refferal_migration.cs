using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace backend.Migrations
{
    /// <inheritdoc />
    public partial class refferal_migration : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "FirstName",
                table: "Referrals");

            migrationBuilder.RenameColumn(
                name: "id",
                table: "Referrals",
                newName: "Id");

            migrationBuilder.AddColumn<string>(
                name: "EmployeeId",
                table: "Referrals",
                type: "nvarchar(450)",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "ParticipantEmail",
                table: "Referrals",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "ParticipantName",
                table: "Referrals",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<DateTime>(
                name: "RegistrationDate",
                table: "Referrals",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.AddColumn<string>(
                name: "Status",
                table: "Referrals",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");

            migrationBuilder.CreateTable(
                name: "Employees",
                columns: table => new
                {
                    Id = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    EmployeeName = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Employees", x => x.Id);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Referrals_EmployeeId",
                table: "Referrals",
                column: "EmployeeId");

            migrationBuilder.AddForeignKey(
                name: "FK_Referrals_Employees_EmployeeId",
                table: "Referrals",
                column: "EmployeeId",
                principalTable: "Employees",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Referrals_Employees_EmployeeId",
                table: "Referrals");

            migrationBuilder.DropTable(
                name: "Employees");

            migrationBuilder.DropIndex(
                name: "IX_Referrals_EmployeeId",
                table: "Referrals");

            migrationBuilder.DropColumn(
                name: "EmployeeId",
                table: "Referrals");

            migrationBuilder.DropColumn(
                name: "ParticipantEmail",
                table: "Referrals");

            migrationBuilder.DropColumn(
                name: "ParticipantName",
                table: "Referrals");

            migrationBuilder.DropColumn(
                name: "RegistrationDate",
                table: "Referrals");

            migrationBuilder.DropColumn(
                name: "Status",
                table: "Referrals");

            migrationBuilder.RenameColumn(
                name: "Id",
                table: "Referrals",
                newName: "id");

            migrationBuilder.AddColumn<string>(
                name: "FirstName",
                table: "Referrals",
                type: "nvarchar(max)",
                nullable: true);
        }
    }
}
