using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ProjectAgileWeb7.Models
{
    public enum CardType { Visa, MasterCard, AmericanExpress }
    public enum Currency { SEK, USD, EUR, RON, CZK}
    public class Payment
    {
        public int Id { get; set; }
        public Status Status { get; set; }
        public DateTime Date { get; set; }

        public Currency Currency { get; set; }

        [Column(TypeName = "decimal(18,4)")]
        public decimal Amount { get; set; }

        [Required]
        [Display(Name = "Credit Card type")]
        public CardType Type { get; set; }

        [Required]
        [Display(Name = "Credit Card number")]
        [RegularExpression(@"^([0-9]{16})$", ErrorMessage = "Enter your 16-digits Credit Card number")]
        public string CardNumber { get; set; }

        [Required]
        [RegularExpression(@"^([0-9]{3})$", ErrorMessage = "Invalid CVV (Click the link below for help)")]
        public string CVV { get; set; }

        [Required]
        [Display(Name = "First Name")]
        public string CardHolderFirstName { get; set; }

        [Required]
        [Display(Name = "Last Name")]
        public string CardHolderLastName { get; set; }

        [Required]
        [Display(Name = "Expiration Date")]
        public string ExpirationDate { get; set; }
    }
}
