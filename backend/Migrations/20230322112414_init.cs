﻿using System;
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
                columns: new[] { "id", "participantEmail", "participantName", "registrationDate", "status" },
                values: new object[,]
                {
                    { 1L, "cmberge@avans.nl", "Coen", new DateTime(2023, 3, 22, 12, 24, 13, 922, DateTimeKind.Local).AddTicks(5360), "Aangemeld" },
                    { 2L, "m1@avans.nl", "Marijn 1", new DateTime(2023, 3, 22, 12, 24, 13, 922, DateTimeKind.Local).AddTicks(5435), "Aangenomen" },
                    { 3L, "m2@avans.nl", "Marijn 2", new DateTime(2023, 3, 22, 12, 24, 13, 922, DateTimeKind.Local).AddTicks(5442), "Afgewezen" },
                    { 4L, "jos@avans.nl", "Jos", new DateTime(2023, 3, 22, 12, 24, 13, 922, DateTimeKind.Local).AddTicks(5449), "Aangemeld" },
                    { 5L, "jedrek@avans.nl", "Jedrek", new DateTime(2023, 3, 22, 12, 24, 13, 922, DateTimeKind.Local).AddTicks(5455), "Aangenomen" },
                    { 6L, "wballeko@avans.nl", "William", new DateTime(2023, 3, 22, 12, 24, 13, 922, DateTimeKind.Local).AddTicks(5461), "Afgewezen" }
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
