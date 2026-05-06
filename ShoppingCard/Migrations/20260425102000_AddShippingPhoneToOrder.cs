using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace ShoppingCard.Migrations
{
    /// <inheritdoc />
    public partial class AddShippingPhoneToOrder : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "ShippingPhone",
                table: "Orders",
                type: "nvarchar(max)",
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "ShippingPhone",
                table: "Orders");
        }
    }
}
