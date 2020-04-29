using System;
using System.ComponentModel.DataAnnotations.Schema;

namespace ProjectAgileWeb7.Models
{
    public enum CardType { Visa, MasterCard, AmericanExpress }
    public class Payment
    {
        public int Id { get; set; }
        public Status Status { get; set; }
        public DateTime Date { get; set; }
        [Column(TypeName = "decimal(18,4)")]
        public decimal Amount { get; set; }
        public CardType Type { get; set; }
        public long CardNumber { get; set; }
        public int CVV { get; set; }
        public string CardHolderFirstName { get; set; }
        public string CardHolderLastName { get; set; }
        public string BankAndClearing { get; set; }
    }
}
