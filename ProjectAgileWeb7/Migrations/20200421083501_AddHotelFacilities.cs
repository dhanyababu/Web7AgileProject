using Microsoft.EntityFrameworkCore.Migrations;

namespace ProjectAgileWeb7.Migrations
{
    public partial class AddHotelFacilities : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_HotelFacility_Facilities_FacilityId",
                table: "HotelFacility");

            migrationBuilder.DropForeignKey(
                name: "FK_HotelFacility_Hotels_HotelId",
                table: "HotelFacility");

            migrationBuilder.DropPrimaryKey(
                name: "PK_HotelFacility",
                table: "HotelFacility");

            migrationBuilder.RenameTable(
                name: "HotelFacility",
                newName: "HotelFacilities");

            migrationBuilder.RenameIndex(
                name: "IX_HotelFacility_FacilityId",
                table: "HotelFacilities",
                newName: "IX_HotelFacilities_FacilityId");

            migrationBuilder.AddPrimaryKey(
                name: "PK_HotelFacilities",
                table: "HotelFacilities",
                columns: new[] { "HotelId", "FacilityId" });

            migrationBuilder.AddForeignKey(
                name: "FK_HotelFacilities_Facilities_FacilityId",
                table: "HotelFacilities",
                column: "FacilityId",
                principalTable: "Facilities",
                principalColumn: "FacilityId",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_HotelFacilities_Hotels_HotelId",
                table: "HotelFacilities",
                column: "HotelId",
                principalTable: "Hotels",
                principalColumn: "HotelId",
                onDelete: ReferentialAction.Cascade);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_HotelFacilities_Facilities_FacilityId",
                table: "HotelFacilities");

            migrationBuilder.DropForeignKey(
                name: "FK_HotelFacilities_Hotels_HotelId",
                table: "HotelFacilities");

            migrationBuilder.DropPrimaryKey(
                name: "PK_HotelFacilities",
                table: "HotelFacilities");

            migrationBuilder.RenameTable(
                name: "HotelFacilities",
                newName: "HotelFacility");

            migrationBuilder.RenameIndex(
                name: "IX_HotelFacilities_FacilityId",
                table: "HotelFacility",
                newName: "IX_HotelFacility_FacilityId");

            migrationBuilder.AddPrimaryKey(
                name: "PK_HotelFacility",
                table: "HotelFacility",
                columns: new[] { "HotelId", "FacilityId" });

            migrationBuilder.AddForeignKey(
                name: "FK_HotelFacility_Facilities_FacilityId",
                table: "HotelFacility",
                column: "FacilityId",
                principalTable: "Facilities",
                principalColumn: "FacilityId",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_HotelFacility_Hotels_HotelId",
                table: "HotelFacility",
                column: "HotelId",
                principalTable: "Hotels",
                principalColumn: "HotelId",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
